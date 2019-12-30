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
import 'package:fleetly/src/views/datepicker.dart';
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
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

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
  ProgressDialog pr;

  String str;
  String htmlText;
  GetDrivers getDriversListResultData;
  List<NewEventsList> getEventsList = [];
    List<NewEventsList> _searchResult = [];


  @override
  createState() => new _MyAppState();
}

class _MyAppState extends State<Homepage> with TickerProviderStateMixin {
  bool isDateSelected = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int eventCount;
  Timer timer;
  String idStr;
  ProgressDialog pr;

  int _cIndex = 0;
  BuildContext _context;
    int imgCount = 0;
String sendTime;
String tokenValue = "";

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
  List<NewEventsList> getEventsList = [];
  List<NewEventsList> _searchResult = [];
    List<NewEventsList> _bothResult = [];

  List<String> generalEvents = [];
  List severity = [];

  String htmlText;

 final TextEditingController _searchController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();


  final FocusNode _searchbarFocus = FocusNode();
 
 

  DateTime _date = new DateTime.now();
   var nowDate = new DateTime.now();
   var formatter = new DateFormat('yyyy-MM-dd');

  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async{

    final DateTime picked = await showDatePicker(
      
      context: context,initialDate: _date,firstDate: new DateTime(2016),
      lastDate: new DateTime(2020)
    );
    print(_date);
    if (picked != null && picked != _date){
      print('date selected: ${_date.toString()}');
      setState(() {
        isDateSelected = true;
        sendTime = _date.toString();
        
        checkForNewSharedListsHome();

        _date = picked;
        String formattedReportedDate = formatter.format(_date);
        _dateController.text = formattedReportedDate;
        if (_dateController.text.isNotEmpty && _searchController.text.isNotEmpty){

     var formatter = new DateFormat('dd-MMM-yyyy');
    String formattedReportedDate = formatter.format(_date);
      _bothResult.clear();

      for (int i = 0; i < _searchResult.length; i++) {
        NewEventsList data = _searchResult[i];
        if (data.time.toLowerCase().contains(formattedReportedDate.toLowerCase()) ) {
          _bothResult.add(data);
        }else{
         print(_searchResult.length);


        }

      }


        }else{
          _searchResult.clear();
   var formatter = new DateFormat('dd-MMM-yyyy');
    String formattedReportedDate = formatter.format(_date);
       var formatter2 = new DateFormat('yyyy-MM-dd');

        String formattedReportedDate2 = formatter2.format(_date);

          _dateController.text = formattedReportedDate2;

      for (int i = 0; i < getEventsList.length; i++) {
        NewEventsList data = getEventsList[i];
        if (data.time.toLowerCase().contains(formattedReportedDate.toLowerCase()) ) {
                    _searchResult.add(data);

        }else{

        }
      }
        }

      });
    }else{
       setState(() {
        _date = picked;
        if (picked == null) {

        }else{
            var formatter2 = new DateFormat('yyyy-MM-dd');

        String formattedReportedDate2 = formatter2.format(_date);
                _dateController.text = formattedReportedDate2;
        if (_dateController.text.isNotEmpty && _searchController.text.isNotEmpty){

     var formatter = new DateFormat('dd-MMM-yyyy');
    String formattedReportedDate = formatter.format(_date);
       _bothResult.clear();
      for (int i = 0; i < _searchResult.length; i++) {
        NewEventsList data = _searchResult[i];
        if (data.time.toLowerCase().contains(formattedReportedDate.toLowerCase()) ) {
          _bothResult.add(data);

        }else{
           print(_searchResult.length);


        }

      }


        }else{
          _searchResult.clear();
   var formatter = new DateFormat('dd-MMM-yyyy');
    String formattedReportedDate = formatter.format(_date);
    var formatter2 = new DateFormat('yyyy-MM-dd');

        String formattedReportedDate2 = formatter2.format(_date);

          _dateController.text = formattedReportedDate2;
      for (int i = 0; i < getEventsList.length; i++) {
        NewEventsList data = getEventsList[i];
        if (data.time.toLowerCase().contains(formattedReportedDate.toLowerCase()) ) {
                    _searchResult.add(data);

        }else{

        }
      }
        }
        }
       

      });
    }
  }



//   Future<Null>   _selectDate(BuildContext context) async{
         

//     final DateTime picked = await showDatePicker(
//       context: context,initialDate: _date,firstDate: new DateTime(2016),
//       lastDate: new DateTime(2020)
//     );

//     if (picked != null && picked != _date){
//       print('date selected: ${_date.toString()}');
//       setState(() {
//         _date = picked;
//         if (_searchController.text.isNotEmpty) {
// setState(() {
  
  
//        if (_date.toString() != null) {
//       // String formattedReportedDate = formatter.format(_date);

//          var formatter = new DateFormat('dd-MMM-yyyy');
//     String formattedReportedDate = formatter.format(_date);
//    var formatter2 = new DateFormat('yyyy-MM-dd');
//        String formattedReportedDate2 = formatter2.format(_date);
// _dateController.text = formattedReportedDate2;

//     print(_searchResult.length);
// if (_searchResult.length > 0){
//   for (int i = 0; i < _searchResult.length; i++) {
//         NewEventsList data = _searchResult[i];
//         if (data.time.toLowerCase().contains(formattedReportedDate.toLowerCase())  ) {
//         }else{
//           _searchResult.remove(data);

//         }
//       }
// }else{

// }
      
//     }
//     });
//         }else{
// setState(() {
//        if (_date.toString() != null) {

//          var formatter = new DateFormat('dd-MMM-yyyy');
//     String formattedReportedDate = formatter.format(_date);

//       for (int i = 0; i < widget.getEventsList.length; i++) {
//         NewEventsList data = widget.getEventsList[i];
//         if (data.time.toLowerCase().contains(formattedReportedDate.toLowerCase())  ) {
//         }else{
//          _searchResult.remove(data);

//         }
//       }
//     }
//     });
//         }
        
//       });
//     }else{



//     }
//   }
  void initState() {
    super.initState();
    //   pr = new ProgressDialog(context);
    // pr.style(
    //     message: 'Please wait...',
    //     borderRadius: 10.0,
    //     backgroundColor: Colors.white,
    //     progressWidget: CircularProgressIndicator(),
    //     elevation: 10.0,
    //     insetAnimCurve: Curves.easeInOut,
    //     progress: 0.0,
    //     maxProgress: 100.0,
    //     progressTextStyle: TextStyle(
    //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    checkUserExist();
   // getToken();
    getEventsList = widget.getEventsList;
    //checkForNewSharedListsHome();
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

      final storage = new FlutterSecureStorage();

  tokenValue = await storage.read(key: "token");
if  (isDateSelected == true){

}else{
    sendTime = await storage.read(key: "currentTime");

}

    //var token = widget.str;
    
    if (widget.idStr == "2") {
      generalEvents = generalEvents;
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
     var timeActual= new DateFormat("H:m:s").format(nowDate);
      var timeSend = '"' + timeActual + '"';

    print(timeSend);
     sendTime = '"' + sendTime + '"';

    //var time = widget.reportTime;
     print(sendTime);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokenValue",
      "Content-Type": "application/json"
    };
    // String json =
    //     '{"Datetime": $time, "TrackingEvents": $generalEvents, "Severity": $severity ,"Take":120,"Skip":0}';

       String json =
        '{"Datetime": $sendTime,"TimeZone":"","Take":120,"Skip":0, "DeviceIdentifier":""}';
// var severity = [1,2,3];
    final eventsResponse = await post(
        'https://api-qa.fleetly.tech/api/GetEvents',
        headers: headers,
        body: json);
    print(eventsResponse);
    //final eventsResponse = await getEventsData(widget.str,widget.reportTime);
    if (eventsResponse.statusCode == 200) {
      //pr.hide();
      print(eventsResponse);
      final events = newEventsListFromJson(eventsResponse.body);
      setState(() {
        getEventsList = events;
        _searchResult = events;
       if (isDateSelected == true) {
showData();
       }
        
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
    //await storage.write(key: "currentTime", value: widget.reportTime);

    String value = await storage.read(key: "EventCount");
    if (value == "00" || value == "" || value == "0") {
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
          itemCount: getEventsList.length,
          itemBuilder: (context, index) {
            return _listItem(context, index, getEventsList);
          },
        );
      }
    });
  }

 
 void getToken() async { 
      final storage = new FlutterSecureStorage();

  tokenValue = await storage.read(key: "token");
 }
  @override
  Widget build(BuildContext context) {
    //_validateAndGetData();
//getToken();
 return new WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
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
              Icons.lock,
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
    )
 );


  }

  void deleteKeys() async {
    final prefs = await SharedPreferences.getInstance();
    FlutterSecureStorage storage = FlutterSecureStorage();

    await storage.deleteAll();
  }

  Widget showData() {
//     if (tokenValue == ""){
// getToken();
//     }else{
 if (_cIndex == 0) {
      return Container(
        child: FleetlyWebview(htmlText: widget.str),
        height: MediaQuery.of(context).size.height,
      );
    } else if (_cIndex == 1) {
      if (getEventsList.length > 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                   Container(child: _dateSearchBar(), width: 140,height: 40,),

                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, top: 1),
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
                    //  pr.show();
                     _selectDate(context);

                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new EventsFilterPage(
                      //             token: widget.str,
                      //             reportTime: widget.reportTime)));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(child: _searchBar(), width: 150,height: 40,),
                  ),

                  // GestureDetector(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 8, top: 4),
                  //     child: Container(
                  //       width: 22,
                  //       height: 22,
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: AssetImage(
                  //             "assets/filter.png",
                  //           ),
                  //           // fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //       child: null /* add child content here */,
                  //     ),
                  //   ),
                  //   onTap: () {
                  // Navigator.of(context).push(new MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             new EventsFilterPage(
                  //                 token: widget.str,
                  //                 reportTime: widget.reportTime)));
                  //   },
                  // ),
                ],
              ),
            ),
            searchNotEmpty(),
           
           
          ],
        );
      } else {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                 Container(child: _dateSearchBar(), width: 140,height: 40,),

                  
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, top: 1),
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
                    //  pr.show();
                    _selectDate(context);

                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         new EventsFilterPage(
                      //             token: widget.str,
                      //             reportTime: widget.reportTime)));
                    },
                  ),
               Padding(
                 padding: const EdgeInsets.only(left: 8),
                 child: Container(child: _searchBar(), width: 150, height: 40,),
               ),

                  // GestureDetector(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 8, top: 4),
                  //     child: Container(
                  //       width: 22,
                  //       height: 22,
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: AssetImage(
                  //             "assets/filter.png",
                  //           ),
                  //           // fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //       child: null /* add child content here */,
                  //     ),
                  //   ),
                  //   onTap: () {
                      
                  //     //  Navigator.of(context).push(new MaterialPageRoute(
                  //     //     builder: (BuildContext context) =>
                  //     //         new BasicDateField()));
                  //     Navigator.of(context).push(new MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             new EventsFilterPage(
                  //                 token: widget.str,
                  //                 reportTime: widget.reportTime)));
                  //   },
                  // ),
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
//getEventsList = widget.getEventsList;
   
   // }
  }

  Widget searchNotEmpty(){
    if (_searchController.text.isNotEmpty && _dateController.text.isNotEmpty) {
      return Container(
              child: Container(
                height: MediaQuery.of(context).size.height -220,
                child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _bothResult.length,
                        itemBuilder: (context, index) {
                          return _listItem(context, index, _searchResult);
                        },
                      )
                    
              ),
            );

    }else{
 return Container(
              child: Container(
                height: MediaQuery.of(context).size.height -220,
                child: _searchController.text.isNotEmpty || _dateController.text.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResult.length,
                        itemBuilder: (context, index) {
                          return _listItem(context, index, _searchResult);
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: getEventsList.length,
                        itemBuilder: (context, index) {
                          return _listItem(
                              context, index, getEventsList);
                        },
                      ),
              ),
            );
    }
    

  }
  void onSearchTextChanged(String text){


    setState(() {
      print(_date);
      if (text != null && _dateController.text.isNotEmpty||_dateController.text != "" ){
print(_dateController.text);
         if (_date.toString() != null) {
         var formatter = new DateFormat('dd-MMM-yyyy');
    String formattedReportedDate = formatter.format(_date);
_bothResult.clear();

      for (int i = 0; i < _searchResult.length; i++) {
        NewEventsList data = _searchResult[i];
        if (data.time.toLowerCase().contains(formattedReportedDate.toLowerCase()) ||data.type.toLowerCase().contains(text.toLowerCase()) ||data.vrn.toLowerCase().contains(text.toLowerCase()) || data.driver.toLowerCase().contains(text.toLowerCase()) ) {
        _bothResult.add(data);
        }else{

        }
      }
    }   }else if (text != null || _dateController.text.isNotEmpty || _dateController.text != "") {
          _searchResult.clear();

       if  (text != null){
      for (int i = 0; i < getEventsList.length; i++) {
        NewEventsList data = getEventsList[i];
        if (data.type.toLowerCase().contains(text.toLowerCase()) ||data.vrn.toLowerCase().contains(text.toLowerCase()) || data.driver.toLowerCase().contains(text.toLowerCase())) {
          _searchResult.add(data);
        }
      }
      }else{
   var formatter = new DateFormat('dd-MMM-yyyy');
    String formattedReportedDate = formatter.format(_date);
     for (int i = 0; i < getEventsList.length; i++) {
        NewEventsList data = getEventsList[i];
        if (data.time.toLowerCase().contains(formattedReportedDate.toLowerCase()) ) {
          _searchResult.add(data);
        }
      }
      }
    }
    });
   
    // _searchResult.clear();
    // if (text.isEmpty) {
    //   setState(() {});
    //   return;
    // }

    // widget.getEventsList.forEach((userDetail) {
    //   if (userDetail.time.contains(text) || userDetail.time.contains(text))
    //     _searchResult.add(userDetail);
    // });

    // setState(() {});
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
Widget _dateSearchBar() {

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

                    //focusNode: _searchbarFocus,

                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),

                    textAlign: TextAlign.left,

                    decoration: InputDecoration(
                        contentPadding:
                            new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                        border: InputBorder.none,
                        hintText: 'Search date',
                        
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 19,
                            color: Colors.grey)),

//decoration: InputDecoration(hintText: 'Search'),

                    onChanged: onSearchTextChanged,

                    controller: _dateController,
                  ),

                  // Icon(Icons.edit,color: Colors.green,),
                  _dateController.text.length > 0
                      ? new IconButton(
                          icon: new Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              isDateSelected = false;
                              //pr.hide();
                              _dateController.clear();
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
       
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, // <--- border color

            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
    );
  }
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
                            new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        border: InputBorder.none,
                        hintText: 'Search here',
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
            padding: const EdgeInsets.only(right: 5, top: 12),
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
          borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
    );
  }

  Widget showList() {
    print(getEventsList);
    if (getEventsList.length > 0) {
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
                    itemCount: getEventsList.length,
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
 var assetsImage = new AssetImage("assets/car.png");
 Color color;
  //<- Creates an object that fetches an image.
    if (data[index].type == "AccOff"){
     if (data[index].severity == 1){
assetsImage = new AssetImage("assets/AccOff1.jpg"); 
color = Colors.orange;

      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/AccOff2.jpg"); 
color = Colors.blue;

      }else{
assetsImage = new AssetImage("assets/AccOff3.jpg"); 
color = Colors.red;

      }
    }else if (data[index].type == "AccOn"){
    if (data[index].severity == 1){
assetsImage = new AssetImage("assets/AccOn1.jpg"); 
color = Colors.orange;

      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/AccOn2.jpg"); 
color = Colors.blue;

      }else{
assetsImage = new AssetImage("assets/AccOn3.jpg"); 
color = Colors.red;

      }
    }else if (data[index].type == "Emergency"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/Emergency1.jpg"); 
color = Colors.orange;

      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/Emergency2.jpg"); 
color = Colors.blue;

      }else{
assetsImage = new AssetImage("assets/Emergency3.jpg"); 
color = Colors.red;

      }
      
    }else if (data[index].type == "EnterArea"){
 
assetsImage = new AssetImage("assets/EnterArea3.jpg"); 

      color = Colors.red;

      
    }else if (data[index].type == "ExitArea"){

assetsImage = new AssetImage("assets/ExitArea3.jpg"); 
color = Colors.red;

    
      
    }else if (data[index].type == "GShock"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/GShock1.jpg"); 
color = Colors.orange;


      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/GShock2.jpg"); 
color = Colors.blue;


      }else{
assetsImage = new AssetImage("assets/GShock3.jpg"); 
color = Colors.red;


      }
      
    }else if (data[index].type == "PowerCut"){

assetsImage = new AssetImage("assets/PowerCut.jpg"); 
color = Colors.black;

      
      
    }else if (data[index].type == "Snapshot"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/Snapshot1.jpg"); 
color = Colors.orange;


      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/Snapshot2.jpg"); 
color = Colors.blue;


      }else{
assetsImage = new AssetImage("assets/Snapshot3.jpg"); 
color = Colors.red;


      }
      
    }else if (data[index].type == "SoundAaarm"){
 
assetsImage = new AssetImage("assets/SoundAaarm.jpg"); 
color = Colors.black;
 
      
    }else if (data[index].type == "Speed"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/speed1.jpg"); 
color = Colors.orange;


      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/Speed2.jpg"); 
color = Colors.blue;


      }else{
assetsImage = new AssetImage("assets/speed3.jpg"); 
color = Colors.red;


      }
      
    }else if (data[index].type == "SuddenAcceleration"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/SuddenAcceleration1.jpg"); 
color = Colors.orange;


      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/SuddenAcceleration2.jpg"); 
color = Colors.blue;


      }else{
assetsImage = new AssetImage("assets/SuddenAcceleration3.jpg"); 
color = Colors.red;


      }
      
    }else if (data[index].type == "SuddenBraking"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/SuddenBraking1.jpg"); 
color = Colors.orange;


      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/SuddenBraking2.jpg"); 
color = Colors.blue;


      }else{
assetsImage = new AssetImage("assets/SuddenBraking3.jpg"); 
color = Colors.red;


      }
      
    }else if (data[index].type == "SuddenTurn"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/SuddenTurn1.jpg"); 
color = Colors.orange;


      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/SuddenTurn2.jpg"); 
color = Colors.blue;


      }else{
assetsImage = new AssetImage("assets/SuddenTurn3.jpg"); 
color = Colors.red;


      }
      
    }else if (data[index].type == "System"){

assetsImage = new AssetImage("assets/System.jpg"); 
color = Colors.red;


      
      
    }else if (data[index].type == "Unknown"){

assetsImage = new AssetImage("assets/Unknown.jpg"); 

      color = Colors.black;

      
    }else if (data[index].type == "UserRequest"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/UserRequest1.jpg"); 
color = Colors.orange;


      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/UserRequest2.jpg"); 
color = Colors.blue;


      }else{
assetsImage = new AssetImage("assets/UserRequest3.jpg"); 
color = Colors.red;


      }
      
    }else if (data[index].type == "Vibration"){
          if (data[index].severity == 1){
assetsImage = new AssetImage("assets/Vibration1.jpg"); 

      }else if (data[index].severity == 2){
assetsImage = new AssetImage("assets/Vibration2.jpg"); 

      }else{
assetsImage = new AssetImage("assets/Vibration2.jpg"); 

      }
      
    }
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
                       // borderRadius: new BorderRadius.circular(20.0),
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          //image: new NetworkImage( "https://foresite.com/wp-content/uploads/2018/02/case-study.jpg")
                          image: assetsImage,
                        )
                        )
                        ),
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
                                      color: color,
                                      fontWeight: FontWeight.w400,
                                      //  color: CommonColors.blueShadeWhite,
                                      letterSpacing: 0.2,
                                      wordSpacing: 1)),
                            ),
                          ),
                        ),
                        // new Text(getEventsList.events[index].locationAddress,maxLines: 2,overflow: TextOverflow.ellipsis, style: new TextStyle(fontWeight: FontWeight.w400,fontSize: 18,),
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
    var token = tokenValue;
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
