import 'package:fleetly/src/blocs/getdriver_bloc.dart';
import 'package:fleetly/src/models/getdriver_model.dart';
import 'package:fleetly/src/models/getevents_model.dart';
import 'package:fleetly/src/repositories/get_drivers_api_client.dart';
import 'package:fleetly/src/repositories/get_drivers_repository.dart';
import 'package:fleetly/src/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
   
 final GetDriversListRepository getDriversListRepository = GetDriversListRepository(
    getDriversApiClient: GetDriversApiClient(
      httpClient: http.Client(),
    ),
  );
   Homepage({this.getDriversListResultData,this.str,this.getEventsList});
   String str;
  GetDrivers getDriversListResultData;
  GetEvents getEventsList;
  @override
  createState() => new _MyAppState();
}




 class _MyAppState extends State<Homepage> with TickerProviderStateMixin {
  final List<MyTabs> _tabs = [new MyTabs(title: "Home"),
  new MyTabs(title: "Events")
  ];
     GetDriversListBloc _getDriversListBloc;
  GetDrivers getDriversListResultData;
  MyTabs _myHandler ;
  TabController _controller ;
     String str;
  GetEvents getEventsList;

  void initState() {
    super.initState();

   
    //  _getDriversListBloc = GetDriversListBloc(getDriversListRepository: widget.getDriversListRepository);
    //  _getDriversListBloc.dispatch(GetDriversListCount());
    //_showList();
    _controller = new TabController(length: 2, vsync: this);
    _myHandler = _tabs[0];
      new MyTabs(title: "Events");

    _controller.addListener(_handleSelected);
  }
    void _handleSelected() {
    setState(() {
       _myHandler= _tabs[_controller.index];
    });
  }
  void _validateAndGetData() async { 
     final response = await getDriversData(widget.str);  
       print(response.body);
     if (response.statusCode == 200) {
       print(response);
       final resourcesList = getDriversFromJson(response.body);
         getDriversListResultData = resourcesList;
         print(getDriversListResultData);
      //    var newDateTimeObj2 = new DateFormat("dd/MM/yyyy HH:mm:ss").parse("10/02/2000 15:13:09");

      //    DateTime reporteddate = DateTime.parse(getDriversListResultData.lastReportedTime);
      // //var nowDate = new DateTime.now();
      // var formatter = new DateFormat('yyyy-MM-dd');

      // String formattedReportedDate = formatter.format(reporteddate);
      // print(formattedReportedDate);
         final eventsResponse = await getEventsData(widget.str,getDriversListResultData.deviceIdentifier,'2019-08-08',getDriversListResultData.email);  
       print(eventsResponse.body);
       final events = getEventsFromJson(eventsResponse.body);
       getEventsList = events;
       
     }
  }
  Widget _getItemUI(BuildContext context, int index, String string) {
    var projectName = getEventsList.events[index];
    var clientName = "";
   var projectDescription = "";

  //  if (widget.getEventsList == null){
  //    if (string == "Internal"){
  //    projectName = getEventsList.events[index].displayname;
  //    clientName = internalLList[index].clientName;
  //    projectDescription = internalLList[index].descrption; 
  //    }else{
  //    projectName = externalList[index].projectName;
  //    clientName = externalList[index].clientName;
  //    projectDescription = externalList[index].descrption; 
  //    }
    

  //  }else{
  //   // projectName = widget.resultData[index].title;
  //   //  clientName = widget.resultData[index].projectDescription;

  //  }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors:[const Color(0xffFAFAFA), const Color(0xffEEEEEE)] ,
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.6, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          color: Colors.green,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: new ListTile(
          //trailing: Icon(Icons.navigate_next),
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(20.0),
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        //image: new NetworkImage( "https://foresite.com/wp-content/uploads/2018/02/case-study.jpg")
                        image: new AssetImage("assets/casestudy.png"),
                        ))),
          ),
          title: Container(
            padding: EdgeInsets.only(top: 8),
            child: new Text(
              projectName.evetId,
              //style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
              style:
                  new TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
          // subtitle: new Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
              
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.all(4.0),
          //         child: new Text(clientName,
          //             style: new TextStyle(
                        
          //                 fontSize: 15.0,
          //                 fontWeight: FontWeight.w100,
          //                 color: CommonColors.midNightBlue,
          //                 letterSpacing: 0.2,
          //                 wordSpacing: 1)),
          //       ),
          //               new Text(projectDescription, maxLines: 3,   overflow: TextOverflow.ellipsis,
          //           style: new TextStyle(
          //               fontSize: 14.0,
          //               fontWeight: FontWeight.w100,
          //               color: CommonColors.blueShadeWhite,
          //               letterSpacing: 0.2,
          //               wordSpacing: 1)),
          //     ]),
      //     onTap: () {
      //       if (widget.resultData == null){
      //  //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new PdfPageData(pdfUrl: totalList[index].details, title: totalList[index].title,)));

      //       }else{
      //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new PdfPageData(pdfUrl: widget.resultData[index].details, title: widget.resultData[index].title,)));

      //       }

      //     },
        ),
      ),
    );
  }
  

  
  
  @override
  Widget build(BuildContext context) {
    _validateAndGetData();
      return DefaultTabController(
         length: 2,
     child:Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: TabBar(
            indicatorColor: Colors.orange,
              tabs: [
                Tab(text: 'External',),
                Tab(text: 'Internal',),
              ],
            ), //backgroundColor: Color.fromRGBO(56, 66, 86, 1.0),
        backgroundColor: Colors.green,
        elevation: 0.0,
        
        title: Text(
          'Projects',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: SafeArea(
        
        child: Container(child: showCaseStudyList()),
      ),
    ),
    );
    // return  Scaffold(
    //   appBar: AppBar(
    //    bottom: PreferredSize(child: Container(color: Colors.green, height: 2,), preferredSize: Size.fromHeight(4.0)),        //backgroundColor: Color.fromRGBO(56, 66, 86, 1.0),

    //     iconTheme: IconThemeData(
    //       color: Colors.green, //change your color here
    //     ),
    //     title: Container(
    //       child: Text( _myHandler.title, textAlign: TextAlign.center,
    //           style: new TextStyle(
    //               fontSize: 18.0,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.black),
    //         ),
          
    //     ),
    //     backgroundColor: Colors.white,
    //   ),
    //   body: new DefaultTabController(
    //       length: 2,
    //       child: new Scaffold(
    //         appBar: new AppBar(
    //           backgroundColor: Colors.white,
    //             automaticallyImplyLeading: false,

    //           actions: <Widget>[],
    //           title: new TabBar(
    //             controller: _controller,
    //             tabs: [
    //             Tab(icon: Text('Home')),
    //             Tab(icon: Text('Events'))
    //           ],
    //             labelColor: Colors.black,
    //           indicatorColor: Colors.green,
    //           labelStyle: new TextStyle (fontSize: 16.0, fontWeight: FontWeight.w700),
    //           ),
    //         ),
    //         body: new TabBarView(
    //           physics: NeverScrollableScrollPhysics(),

    //           children: [
    //           login(_controller.index),
    //           login(_controller.index),

    //          // VolunteerLogin()
    //          // ParticipantLogin(),
    //         ],
    //       ),
    //         ),
    //       ),
    
    // );
  }
   Widget showCaseStudyList() {

return Container(
   
        child:  TabBarView(
            children: [
               
                Container(
                 child: ListView.builder(
              shrinkWrap: true,
              itemCount: getEventsList.events.length,
              itemBuilder: (context, index) {
                  return _getItemUI(context, index, 'externalProjectType');
              },
              
              // itemBuilder: _getItemUI,
            ),
               ),
               Container(
                 child: ListView.builder(
              shrinkWrap: true,
              itemCount: getEventsList.events.length,
              itemBuilder: (context, index) {
                  return _getItemUI(context, index, 'externalProjectType');
              },
              
              // itemBuilder: _getItemUI,
            ),
               ),
              // Icon(Icons.directions_car),
              // Icon(Icons.directions_transit),
            ],
          ),
);
               
   }
 }
class MyTabs {
  final String title;
  MyTabs({this.title});
}