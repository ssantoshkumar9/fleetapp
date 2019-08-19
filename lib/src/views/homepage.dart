import 'package:fleetly/src/blocs/getdriver_bloc.dart';
import 'package:fleetly/src/models/getdriver_model.dart';
import 'package:fleetly/src/models/getevents_model.dart';
import 'package:fleetly/src/repositories/get_drivers_api_client.dart';
import 'package:fleetly/src/repositories/get_drivers_repository.dart';
import 'package:fleetly/src/user_profile.dart';
import 'package:fleetly/src/views/webView.dart';
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
   Homepage({this.getDriversListResultData,this.str,this.getEventsList, this.htmlText});
   String str;
   String htmlText;
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
String htmlText;
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


  
  
  @override
  Widget build(BuildContext context) {
    _validateAndGetData();
   
      return DefaultTabController(
         length: 2,
     child:Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: TabBar(
            indicatorColor: Colors.orange,
              tabs: [
                Tab(text: 'Home',),
                Tab(text: 'Events',),
              ],
            ), //backgroundColor: Color.fromRGBO(56, 66, 86, 1.0),
        backgroundColor: Colors.green,
        elevation: 0.0,
        
        title: Text(
          'Home',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: SafeArea(
        
        child: Container(child:  showCaseStudyList()),
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
//if (getEventsList.events.length > 0) {
//  return Container(
   
//         child:  TabBarView(
//             children: [
               
//                 Container(
//                  child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: getEventsList.events.length,
//               itemBuilder: (context, index) {
//                   return _getItemUI(context, index, 'externalProjectType');
//               },
              
//               // itemBuilder: _getItemUI,
//             ),
//                ),
//                Container(
//                  child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: getEventsList.events.length,
//               itemBuilder: (context, index) {
//                   return _getItemUI(context, index, 'externalProjectType');
//               },
              
//               // itemBuilder: _getItemUI,
//             ),
//                ),
//               // Icon(Icons.directions_car),
//               // Icon(Icons.directions_transit),
//             ],
//           ),
// );
// }else{
return Container(child:  TabBarView(
            children: [
               
                Container(
                 child:FleetlyWebview(htmlText:widget.htmlText)),
               Container(
                 child: Center(child: Text('data'))
               ),
              // Icon(Icons.directions_car),
              // Icon(Icons.directions_transit),
            ],),
);
// }

               
   }
 }
class MyTabs {
  final String title;
  MyTabs({this.title});
}