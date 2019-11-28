import 'dart:async';
import 'dart:io';

import 'package:fleetly/src/blocs/getdriver_bloc.dart';
import 'package:fleetly/src/models/getdriver_model.dart';
import 'package:fleetly/src/models/getevents_model.dart';
import 'package:fleetly/src/models/newevents_model.dart';
import 'package:fleetly/src/models/userdetails_model.dart';
import 'package:fleetly/src/repositories/get_drivers_api_client.dart';
import 'package:fleetly/src/repositories/get_drivers_repository.dart';
import 'package:fleetly/src/user_profile.dart';
import 'package:fleetly/src/views/events_filter.dart';
import 'package:fleetly/src/views/images.dart';
import 'package:fleetly/src/views/login.dart';
import 'package:fleetly/src/views/webView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  final GetDriversListRepository getDriversListRepository =
      GetDriversListRepository(
    getDriversApiClient: GetDriversApiClient(
      httpClient: http.Client(),
    ),
  );
  Homepage(
      {this.userData,
      this.reportTime,
      this.str,
      this.getEventsList,
      this.htmlText,
      this.idStr,
      this.generalEvents,
      this.severity});
  UserDetails userData;
  GetEvents eventsList;
  String eventNae;
  String eventLoc;
  String reportTime;
  String idStr;
  List<String> generalEvents = [];
  List severity = [];

  String str;
  String htmlText;
  GetDrivers getDriversListResultData;
  List<NewEventsList> getEventsList;

  @override
  createState() => new _MyAppState();
}

class _MyAppState extends State<Homepage> with TickerProviderStateMixin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int eventCount;
  Timer timer;
  String idStr;

  int _cIndex = 0;
  BuildContext _context;
    int imgCount = 0;


  List<UserDetails> userData;
  final List<MyTabs> _tabs = [
    new MyTabs(title: "Home"),
    new MyTabs(title: "Events"),
    new MyTabs(title: "Sign out"),
    // new MyTabs(title: "Profile")
  ];
  GetDriversListBloc _getDriversListBloc;
  GetDrivers getDriversListResultData;
  MyTabs _myHandler;
  TabController _controller;
  String str;
  List<NewEventsList> getEventsList;
  List<NewEventsList> _searchResult;
  List<String> generalEvents = [];
  List severity = [];

  String htmlText;
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 15), (Timer t) => checkForNewSharedLists());
    timer = Timer.periodic(
        Duration(seconds: 300), (Timer t) => checkForNewSharedListsHome());

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: selectNotification);
    //_validateAndGetData();

    //  _getDriversListBloc = GetDriversListBloc(getDriversListRepository: widget.getDriversListRepository);
    //  _getDriversListBloc.dispatch(GetDriversListCount());
    //_showList();
    _controller = new TabController(length: 3, vsync: this);
    if (widget.idStr == "2") {
      _myHandler = _tabs[1];
      _incrementTab(1);
    } else {
      _myHandler = _tabs[0];
      checkForNewSharedListsHome();
    }
    new MyTabs(title: "Events");

    _controller.addListener(_handleSelected);
  }

  Future selectNotification(String payload) {
    debugPrint('print payload : $payload');
    // showDialog(context: context, builder: (_) => AlertDialog(
    //   title: new Text('Notification'),
    //   content: new Text('Payload'),
    // ));
  }

  void checkForNewSharedListsHome() async {
    var token = widget.str;
    if (widget.idStr == "2") {
      generalEvents = widget.generalEvents;
      severity = widget.severity;
    } else {
      generalEvents = [
        "Speed",
        "SuddenAcceleration",
        "Emergency",
        "GShock",
        "UserRequest",
        "EnterArea",
        "SuddenTurn"
      ];
      severity = [1, 2, 3];
    } //2019-11-10T13:10:44
    // widget.reportTime
    var time = widget.reportTime;
     time = '"' + time + '"';
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json"
    };
    String json =
        '{"Datetime": $time, "TrackingEvents": $generalEvents, "Severity": $severity ,"Take":120,"Skip":0}';

// var severity = [1,2,3];
    final eventsResponse = await post(
        'https://api-qa.fleetly.tech/api/GetEvents',
        headers: headers,
        body: json);
    print(eventsResponse);
    //final eventsResponse = await getEventsData(widget.str,widget.reportTime);
    print(eventsResponse.body);
    if (eventsResponse.statusCode == 200) {
      print(eventsResponse);
      final events = newEventsListFromJson(eventsResponse.body);
      setState(() {
        getEventsList = events;
      });
      eventCount = getEventsList.length;
      checkUserExist();
    } else if (eventsResponse.statusCode == 401) {
      checkTokenExp();
      _showDialogAlert();
    }
  }

  void _showDialogAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _context = context;
        // return object of type Dialog
        return AlertDialog(
          title: Center(
              child: new Text(
            "FLEETLY",
            style: TextStyle(
                color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          content: new Text('Token Expired'),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginSignUpPage()));
              },
            ),
          ],
        );
      },
    );
  }

  void checkTokenExp() async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "token", value: "");
  }

  void checkUserExist() async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "token", value: widget.str);
    await storage.write(key: "reportTime", value: widget.reportTime);

    String value = await storage.read(key: "EventCount");
    if (value == "00") {
      final storage = new FlutterSecureStorage();
      String val = value.toString();
      await storage.write(key: "EventCount", value: val);
    } else {
      var eventsavedVal = int.parse(value);

      if (eventCount > eventsavedVal) {
        String val = value.toString();
        await storage.write(key: "EventCount", value: val);
        if (getEventsList[0].severity == 5) {
          showNotification();
        }
        ;
      }
    }
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, getEventsList[0].type.toString(), getEventsList[0].address, platform,
        payload: getEventsList[0].eventId);
  }

  void _handleSelected() {
    setState(() {
      _myHandler = _tabs[_controller.index];
    });
  }
  // void _validateAndGetData() async {
  //    final response = await getDriversData(widget.str);
  //      print(response.body);
  //    if (response.statusCode == 200) {
  //      print(response);
  //      final resourcesList = getDriversFromJson(response.body);
  //        getDriversListResultData = resourcesList;
  //        print(getDriversListResultData);
  //     //    var newDateTimeObj2 = new DateFormat("dd/MM/yyyy HH:mm:ss").parse("10/02/2000 15:13:09");

  //     //    DateTime reporteddate = DateTime.parse(getDriversListResultData.lastReportedTime);
  //     // //var nowDate = new DateTime.now();
  //     // var formatter = new DateFormat('yyyy-MM-dd');

  //     // String formattedReportedDate = formatter.format(reporteddate);
  //     // print(formattedReportedDate);
  //   // final http.Response response =
  //   // await http.post(Uri.encodeFull(url), body: activityData);

  //        final eventsResponse = await getEventsData(widget.str,widget.getDriversListResultData.deviceIdentifier,'2019-08-12',widget.userData.userName);
  //      print(eventsResponse.body);
  //      if (eventsResponse.statusCode == 200) {
  //      print(eventsResponse);
  //      final events = getEventsFromJson(eventsResponse.body);
  //      getEventsList = events;
  //      showList();
  //      }

  //    }
  // }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
      if (index == 0) {
        print(widget.str);
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: FleetlyWebview(htmlText: widget.str),
        );
      } else {
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.getEventsList.length,
          itemBuilder: (context, index) {
            return _listItem(context, index, widget.getEventsList);
          },
        );
      }
    });
  }

  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchbarFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    //_validateAndGetData();

    return Scaffold(
      backgroundColor: Colors.white,
      //  appBar: AppBar(
      //    automaticallyImplyLeading: false,
      //    // bottom: TabBar(
      //    //     indicatorColor: Colors.orange,
      //    //       tabs: [
      //    //         Tab(text: 'Home',),
      //    //         Tab(text: 'Events',),
      //    //        // Tab(text: 'Profile',),
      //    //       ],
      //    //     ), //backgroundColor: Color.fromRGBO(56, 66, 86, 1.0),
      //    backgroundColor: Colors.green,
      //    elevation: 0.0,

      //    title: Text(
      //      'Home',
      //      style: TextStyle(fontSize: 24),
      //    ),
      //  ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: _cIndex == 0 ? Colors.green : Colors.black,
            ),
            title: _cIndex == 0
                ? new Text(
                    'Home',
                    style: TextStyle(color: Colors.green),
                  )
                : new Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.event,
              color: _cIndex == 1 ? Colors.green : Colors.black,
            ),
            title: _cIndex == 1
                ? new Text(
                    'Events',
                    style: TextStyle(color: Colors.green),
                  )
                : new Text(
                    'Events',
                    style: TextStyle(color: Colors.black),
                  ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.event,
              color: _cIndex == 2 ? Colors.green : Colors.black,
            ),
            title: _cIndex == 2
                ? new Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.green),
                  )
                : new Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.black),
                  ),
          ),

          //  BottomNavigationBarItem(
          //    icon: Icon(Icons.person),
          //    title: Text('Profile')
          //  )
        ],
        onTap: (index) {
          setState(() {
            if (index == 2) {
              setState(() {
                deleteKeys();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginSignUpPage()));
              });
            }
          });
          _incrementTab(index);
        },
      ),
      //    bottomNavigationBar: BottomAppBar(
      //   child: new Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.menu),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.search),
      //         onPressed: () {},
      //       )
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: Container(child: showData()),

        // child: Container(child:  showList()),
      ),
    );
  }

  void deleteKeys() async {
    final prefs = await SharedPreferences.getInstance();
    FlutterSecureStorage storage = FlutterSecureStorage();

    await storage.deleteAll();
  }

  Widget showData() {
    if (_cIndex == 0) {
      return Container(
        child: FleetlyWebview(htmlText: widget.str),
        height: MediaQuery.of(context).size.height,
      );
    } else if (_cIndex == 1) {
      if (widget.getEventsList.length > 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                  Container(child: _searchBar(), width: 200),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 1),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/calendar.png",
                            ),
                            // fit: BoxFit.cover,
                          ),
                        ),
                        child: null /* add child content here */,
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new EventsFilterPage(
                      //             token: widget.str,
                      //             reportTime: widget.reportTime)));
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, top: 4),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/filter.png",
                            ),
                            // fit: BoxFit.cover,
                          ),
                        ),
                        child: null /* add child content here */,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new EventsFilterPage(
                                  token: widget.str,
                                  reportTime: widget.reportTime)));
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Container(
                height: MediaQuery.of(context).size.height -200,
                child: _searchController.text.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResult.length,
                        itemBuilder: (context, index) {
                          return _listItem(context, index, _searchResult);
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.getEventsList.length,
                        itemBuilder: (context, index) {
                          return _listItem(
                              context, index, widget.getEventsList);
                        },
                      ),
              ),
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height-200,
            //   child: ListView.builder(
            //                 shrinkWrap: true,
            //                 itemCount: widget.getEventsList.length,
            //                 itemBuilder: (context, index) {
            //                   return _listItem(context,index);
            //                 },
            //               ),
            // ),
          ],
        );
      } else {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                  Container(child: _searchBar(), width: 200),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 1),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/calendar.png",
                            ),
                            // fit: BoxFit.cover,
                          ),
                        ),
                        child: null /* add child content here */,
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new EventsFilterPage(
                      //             token: widget.str,
                      //             reportTime: widget.reportTime)));
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, top: 4),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/filter.png",
                            ),
                            // fit: BoxFit.cover,
                          ),
                        ),
                        child: null /* add child content here */,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new EventsFilterPage(
                                  token: widget.str,
                                  reportTime: widget.reportTime)));
                    },
                  ),
                ],
              ),
            ),
           
         Padding(
           padding: const EdgeInsets.only(top: 150,left: 8,right: 8),
           child: Container(
                    child: Center(
                      child: Text(
              'No Events',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
                    )),
         )
       
          ],
        );
        // return Center(
        //   child: Container(
        //       child: Container(
        //           child: Text(
        //     'No Events',
        //     style: TextStyle(color: Colors.red, fontSize: 20),
        //   ))),
        // );
      }
    } else {
      //  return Center(
      // child: Container(
      //            child: Container(child: Text('No Events', style: TextStyle(color: Colors.red,fontSize: 20),))
      //          ),
      //  );
      // setState(() {
      //     return Navigator.of(context).push(new MaterialPageRoute(
      //                 builder: (BuildContext context) => new LoginSignUpPage()));
      // });

    }
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    widget.getEventsList.forEach((userDetail) {
      if (userDetail.time.contains(text) || userDetail.time.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

//   onSearchTextChanged(String text) async {
//     _searchResult.clear();

//     if (text.isEmpty) {
//       setState(() {});

//       return;
//     }

// // }

//  widget.getEventsList.forEach((userDetail) {
//       if (userDetail.time.contains(text) ||
//           userDetail.type.toString().contains(text)) _searchResult.add(userDetail);
//     });

// //     setState(() {
// //       widget.getEventsList.forEach((searchRetreat) {
// //       for (var i = 0; i < getEventsList.length; i++) {
// //         // if (getEventsList[i].time.toLowerCase().contains(text) ||
// //         //     searchRetreat.retreats[i].location.toLowerCase().contains(text) ||
// //            if  (getEventsList[i].time.toLowerCase().contains(text)) {
// //           if (_searchResult.contains(searchRetreat)) {
// //           } else {
// //             _searchResult.add(searchRetreat);
// //           }

// //           print(_searchResult);
// //         } else {
// //           setState(() {
// //             return Center(
// //                 child: Text(
// //               'No data found',
// //               style: TextStyle(color: Colors.red, fontSize: 20),
// //             ));
// //           });

// // // _showDialog();

// //         }
// //       }

// // // print(_searchResult.length);

// // // print(_searchResult);
// //     // });

// // // if (_searchResult.isEmpty){

// // // setState(() {

// // // return Container(child: Center(child: Text('No data found',style: TextStyle(color: Colors.red, fontSize: 20),)));

// // });
// //     });

//   }

  Widget _searchBar() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Stack(
                alignment: const Alignment(1.0, 1.0),
                children: <Widget>[
                  new TextField(
                    textInputAction: TextInputAction.search,

                    focusNode: _searchbarFocus,

                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),

                    textAlign: TextAlign.left,

                    decoration: InputDecoration(
                        contentPadding:
                            new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                        border: InputBorder.none,
                        hintText: 'Search for retreats',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 19,
                            color: Colors.grey)),

//decoration: InputDecoration(hintText: 'Search'),

                    onChanged: onSearchTextChanged,

                    controller: _searchController,
                  ),

                  // Icon(Icons.edit,color: Colors.green,),
                  _searchController.text.length > 0
                      ? new IconButton(
                          icon: new Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          })
                      : new Container(
                          height: 0.0,
                        ),
                ]),
          ),
          new SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 10),
            child: new Icon(
              Icons.search,
              color: _searchController.text.length > 0
                  ? Colors.green
                  : Colors.grey,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, // <--- border color

            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.elliptical(10, 10))),
    );
  }

  Widget showList() {
    print(widget.getEventsList);
    if (widget.getEventsList.length > 0) {
      var token = widget.str;

      return TabBarView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: FleetlyWebview(htmlText: widget.str),
          ),

          Container(
            height: MediaQuery.of(context).size.height,

            //color: CommonColors.volunteerRetreatsListBackgrdColor,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Container(
                      child: Text('dataevwvvfv'),
                      height: 150,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.getEventsList.length,
                    itemBuilder: (context, index) {
                      return _listItem(context, index, getEventsList);
                    },
                  ),
                ],
              ),
            ),
          ),

          // ProfilePage(userDetails:widget.userData)
          // Icon(Icons.directions_car),
          // Icon(Icons.directions_transit),
        ],
      );
    } else {
      return TabBarView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: FleetlyWebview(htmlText: widget.str),
          ),

          Container(
              child: Center(
                  child: Container(
                      child: Text(
            'No Events',
            style: TextStyle(color: Colors.red, fontSize: 20),
          )))),
          // ProfilePage(userDetails:widget.userData)
          // Icon(Icons.directions_car),
          // Icon(Icons.directions_transit),
        ],
      );
    }
  }

  Widget _listItem(BuildContext context, int index, data) {
    Color color;
  List images = data[index].images;
  print(images.length);
  if (images.length > 0){
  imgCount = 1;
  }else{
imgCount = 0;
  }
  // if (data[index].type.toString() == "GShock"){
  //   color = Colors.orange;

  // }else if (data[index].type.toString() == ""){

  // }else if (data[index].type.toString() == ""){
    
  // }else if (data[index].type.toString() == ""){
    
  // }else if (data[index].type.toString() == ""){
    
  // }
    String dateNow = data[index].time.toString();
    print(dateNow);
    dateNow.substring(0, 10);
    print(dateNow.substring(13, 23));
    var date = dateNow.substring(13, 23);
   
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 120,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
        child: Card(
          color: Colors.white,
          child: Center(
            child: new ListTile(
              //trailxing: Icon(Icons.navigate_next),
              leading: Padding(
                padding: const EdgeInsets.all(2.0),
                // child: Image.network(responseData.image),
                //child: Center(
                child: new Container(
                    width: 38.0,
                    height: 38.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(20.0),
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          //image: new NetworkImage( "https://foresite.com/wp-content/uploads/2018/02/case-study.jpg")
                          image: new AssetImage("assets/car.png"),
                        ))),
              ),
              title: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 4),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: new Text(data[index].vrn.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                  //  color: CommonColors.blueShadeWhite,
                                  letterSpacing: 0.2,
                                  wordSpacing: 1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Center(
                            child: Container(
                              width: 140,
                              child: new Text(data[index].type.toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w400,
                                      //  color: CommonColors.blueShadeWhite,
                                      letterSpacing: 0.2,
                                      wordSpacing: 1)),
                            ),
                          ),
                        ),
                        // new Text(widget.getEventsList.events[index].locationAddress,maxLines: 2,overflow: TextOverflow.ellipsis, style: new TextStyle(fontWeight: FontWeight.w400,fontSize: 18,),
                        //  ),
                      ],
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Container(
                              width: 85,
                              child: new Text(data[index].driver.toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                      //  color: CommonColors.blueShadeWhite,
                                      letterSpacing: 0.2,
                                      wordSpacing: 1)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:4,),
                            child: Container(
                              width: 70,
                              child: new Text(date,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      //  color: CommonColors.blueShadeWhite,
                                      letterSpacing: 0.2,
                                      wordSpacing: 1)),
                            ),
                          ),
imgCount == 1 ? Container(
  width:90,
  child:   Padding(
          padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
          child: SizedBox(
            height: 25.0,
            child: new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.green,
                   child:  new Text('Images',
                      style: new TextStyle(fontSize: 15.0, color: Colors.white)),
           
              onPressed: (){
  Navigator.of(context).push(new MaterialPageRoute(
                       builder: (BuildContext context) => new ImagesPage(images:images)));

              },
            ),
          )),
): Container(),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 8),
                          //   child: new Text('0Miles',
                          //       maxLines: 3,
                          //       overflow: TextOverflow.ellipsis,
                          //       style: new TextStyle(
                          //           fontSize: 12.0,
                          //           color: Colors.black,
                          //           fontWeight: FontWeight.w300,
                          //           //  color: CommonColors.blueShadeWhite,
                          //           letterSpacing: 0.2,
                          //           wordSpacing: 1)),
                          // ),
                          // new Text(widget.getEventsList.events[index].locationAddress,maxLines: 2,overflow: TextOverflow.ellipsis, style: new TextStyle(fontWeight: FontWeight.w400,fontSize: 18,),
                          //  ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              onTap: () {
                // Navigator.of(context).push(new MaterialPageRoute(
                //          builder: (BuildContext context) => new EventsFilterPage(token: widget.str,reportTime:widget.reportTime)));

                //_showDialog();
                //showNotification();
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new Text("VMetrics")),
          content: new Text("No results found, please try again "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget showTabBarList() {
    var token = widget.str;
    return TabBarView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: FleetlyWebview(htmlText: widget.str),
        ),

        Container(child: Center(child: Text('data'))),
        // ProfilePage(userDetails:widget.userData)
        // Icon(Icons.directions_car),
        // Icon(Icons.directions_transit),
      ],
    );
  }
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
