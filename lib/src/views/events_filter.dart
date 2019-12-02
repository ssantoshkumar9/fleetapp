import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:fleetly/src/models/newevents_model.dart';
import 'package:fleetly/src/views/homepage.dart';
import 'package:fleetly/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class EventsFilterPage extends StatefulWidget {
     EventsFilterPage({this.token,this.reportTime});
      String token;
            String reportTime;

ProgressDialog pr;

  @override
  _MyEventsFilterPageState createState() => _MyEventsFilterPageState();
}

class _MyEventsFilterPageState extends State<EventsFilterPage> {
         FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  TabController _controller ;
   int eventCount;
    int _cIndex = 0;
       BuildContext _context;
  bool trackingEvents = true;
  bool generalInformation = true;
  bool low = false;
  bool medium = false;
  bool high = false;
  bool incident = false;
  bool accident = false;
  bool dismissed = false;
  bool intervention = false;
  bool unassigned = false;
  bool speed = false;
  bool suddenAcceleration = false;
  bool suddenBreaking = false;
  bool emergency = false;
  bool gshock = false;
  bool suddenturn = false;
  bool system = false;
  bool sdcardremoved = false;
  bool userrequest = false;
  bool normal = false;
  bool accoff = false;
  bool accon = false;
  bool powercut = false;
  bool vibration = false;
  bool soundalarm = false;
  bool geofenceruleexc = false;
  bool entergeofencearea = false;
  bool exitgeofencearea = false;
  bool unknown = false;
            String reportTime;

   List<NewEventsList>  getEventsList;
   String alertText;

  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;
 List arr = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
  List eventsarr = ['','','','Incident','Accident','Dismissed','Intervention','Un Assigned','Speed','Sudden Acceleration','Sudden Breaking','Emergency','GShock','Sudden Turn"','System','SD Card Removed','UserRequest','Normal','Acc Off','Acc On','Power Cut','Vibration','Sound Alarm','GeoFenceRuleException','Enter Geofence Area','Exit Geofence Area','UNKNOWN'];
  ProgressDialog pr;

 List severity = [];
 List<String> generalEvents = [];
  /// box widget
  /// [title] is the name of the checkbox
  /// [boolValue] is the boolean value of the checkbox
   void initState() {
    super.initState();
    //Default
pr = new ProgressDialog(context);
pr.style(
  message: 'Please wait...',
  borderRadius: 10.0,
  backgroundColor: Colors.white,
  progressWidget: CircularProgressIndicator(),
  elevation: 10.0,
  insetAnimCurve: Curves.easeInOut,
  progress: 0.0,
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
     color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );
   }
  Widget checkbox(String title, bool boolValue ,int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "Tracking Events":
                  trackingEvents = value;
                  arr[index] = value;
                  break;
                  case "General Information":
                  generalInformation = value;
                  arr[index] = value;
                  break;
                  case "Low":
                  low = value;
                  arr[index] = value;
                  break;
                  case "Medium":
                  medium = value;
                  arr[index] = value;
                  break;
                   case "High":
                  high = value;
                  arr[index] = value;
                  break;
                   case "Incident":
                  incident = value;
                  arr[index] = value;
                  break;
                  case "Accident":
                  accident = value;
                  arr[index] = value;
                  break;
                  case "Dismissed":
                  dismissed = value;
                  arr[index] = value;
                  break;
                   case "Intervention":
                  intervention = value;
                  arr[index] = value;
                  break;
                  case "Un Assigned":
                  unassigned = value;
                  arr[index] = value;
                  break;
                  case "Speed":
                  speed = value;
                  arr[index] = value;
                  break;
                  case "Sudden Acceleration":
                  suddenAcceleration = value;
                  arr[index] = value;
                  break;
                  case "Sudden Breaking":
                  suddenBreaking = value;
                  arr[index] = value;
                  break;
                  case "Emergency":
                  emergency = value;
                  arr[index] = value;
                  break;
                  case "GShock":
                  gshock = value;
                  arr[index] = value;
                  break;
                   case "Sudden Turn":
                  suddenturn = value;
                  arr[index] = value;
                  break;
                  case "System":
                  system = value;
                  arr[index] = value;
                  break;
                  case "SD Card Removed":
                  sdcardremoved = value;
                  arr[index] = value;
                  break;
                  case "UserRequest":
                  userrequest = value;
                  arr[index] = value;
                  break;
                  case "Normal":
                  normal = value;
                  arr[index] = value;
                  break;
                  case "Acc Off":
                  accoff = value;
                  arr[index] = value;
                  break;
                  case "Acc On":
                  accon = value;
                  arr[index] = value;
                  break;
                  case "Power Cut":
                  powercut = value;
                  arr[index] = value;
                  break;
                  case "Vibration":
                  vibration = value;
                  arr[index] = value;
                  break;
                  case "Sound Alarm":
                  soundalarm = value;
                  arr[index] = value;
                  break;
                  
                  case "GeoFenceRuleException":
                  geofenceruleexc = value;
                  arr[index] = value;
                  break;
                  case "Enter Geofence Area":
                  entergeofencearea = value;
                  arr[index] = value;
                  break;
                  case "Exit Geofence Area":
                  exitgeofencearea = value;
                  arr[index] = value;
                  break;
                  case "UNKNOWN":
                  unknown = value;
                  arr[index] = value;
                  break;
                
              }
            });
          },
        ),
                Text(title),
       

      ],

    );
  }
  Widget _showCancelButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
                 child:  new Text('Cancel',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                
            // child: _formMode == FormMode.LOGIN
            //     ? new Text('SUBMIT',
            //         style: new TextStyle(fontSize: 20.0, color: Colors.white))
            //     : new Text('Create account',
            //         style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            //onPressed: showNotification,
           // onPressed: _validateAndSubmit,
          ),
        ));
  }
  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 15.0, 15.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
                 child:  new Text('Apply',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                
            // child: _formMode == FormMode.LOGIN
            //     ? new Text('SUBMIT',
            //         style: new TextStyle(fontSize: 20.0, color: Colors.white))
            //     : new Text('Create account',
            //         style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            //onPressed: showNotification,
            onPressed: _validateAndSubmit,
          ),
        ));
  }
  Widget _validateAndSubmit(){
   
    severity.clear();
    generalEvents.clear();
          for (var i = 0; i < arr.length; i++) {
            if (i <= 2){
             if (arr[i]== true){
               severity.add(i+1);
             }
            }else{
              if (arr[i]== true){
            //   generalEvents.add('"' + eventsarr[i] + '"');

               generalEvents.add( '"' + eventsarr[i] + '"');
             }
            }
          }

checkForNewSharedLists();
  }
   void checkForNewSharedLists() async{
    var token = widget.token;
    var time = widget.reportTime;
    time = '"' + time + '"';
          pr.show();

Map<String, String> headers = {HttpHeaders.authorizationHeader: "Bearer $token","Content-Type": "application/json"};
 String json = '{"Datetime": $time, "TrackingEvents": $generalEvents, "Severity": $severity,"Take":120,"Skip":0}';
 
// var severity = [1,2,3];
      final eventsResponse = await post('https://api.fleetly.tech/api/GetEvents', headers: headers,body: json);
      print(eventsResponse);
      //final eventsResponse = await getEventsData(widget.str,widget.reportTime);  
       print(eventsResponse.body);
       if (eventsResponse.statusCode == 200) {
       print(eventsResponse);
       final events = newEventsListFromJson(eventsResponse.body);
       setState(() {
        getEventsList = events;
           Navigator.of(context).push(new MaterialPageRoute(
                       builder: (BuildContext context) => new Homepage(str: widget.toString(),reportTime:widget.reportTime,getEventsList:getEventsList, idStr: '2',generalEvents:generalEvents,severity: severity,)));

       

       });
       eventCount = getEventsList.length;
      checkUserExist();
       
    
       
       }else  if (eventsResponse.statusCode == 401){
       checkTokenExp();
       alertText = "Token expired";
         _showDialogAlert();
     }else{
       alertText = "Something went wrong, please try again.";
       _showDialogAlert() ;

     }
  }
   void _showDialogAlert() {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
         _context = context;
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new Text("FLEETLY",style: TextStyle(color: Colors.green,fontSize: 18, fontWeight: FontWeight.bold),)),
          content: new Text(alertText),
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
      await storage.write(key: "token", value: widget.token);
      await storage.write(key: "reportTime", value: widget.reportTime);

      

  String value = await storage.read(key: "EventCount");
  if (value == "00"){
    final storage = new FlutterSecureStorage();
     String val =  value.toString();
      await storage.write(key: "EventCount", value: val);
  }else{
     var eventsavedVal = int.parse(value);
  
   if (eventCount > eventsavedVal){
     String val =  value.toString();
      await storage.write(key: "EventCount", value: val);
      if (getEventsList[0].severity == 5 ){
       showNotification();

      };
   }
  }
   
    }
    showNotification() async {
    var android = new AndroidNotificationDetails('channelId', 'channelName', 'channelDescription', priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, getEventsList[0].type.toString(), getEventsList[0].address, platform,payload: getEventsList[0].eventId);
  }
     Widget showData(){
    return Column(
      children: <Widget>[
        Container(
                    height: MediaQuery.of(context).size.height-180,
                    child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return _listItem(context);
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                    _showCancelButton(),
                    _showPrimaryButton(),

                ],
              ),
                  ),
      ],
    );
    
  }
  Widget _listItem(BuildContext context){
    return Container(
          //height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  checkbox("Tracking Events", trackingEvents ,27 ),
                  checkbox("General Information", generalInformation, 28),
                  
                ],
              ),
              Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(child: Text('Severity',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),),
                ),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  checkbox("Low", low, 0),
                  checkbox("Medium", medium,1),
                  checkbox("High", high, 2),

                ],
              ),
              Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8),
                  child: Container(child: Text('Clasification',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),
                ),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  checkbox("Incident", incident,3),
                  checkbox("Accident", accident,4),
                 checkbox("Dismissed", dismissed,5),

          
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  checkbox("Intervention", intervention,6),
                  checkbox("Un Assigned", unassigned,7),
                  

                ],
              ),
               Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8),
                  child: Container(child: Text('Tracking Event Types',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),
                ),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  checkbox("Speed", speed,8),
                  checkbox("Sudden Acceleration", suddenAcceleration,9),


                ],
              ),

               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                    checkbox("Sudden Breaking", suddenBreaking,10),



                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  checkbox("Emergency", emergency,11),
                  checkbox("GShock", gshock,12),
                  checkbox("Sudden Turn", suddenturn,13),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  checkbox("System", system,14),
                  checkbox("SD Card Removed", sdcardremoved,15),

                ],
              ),
               Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8),
                  child: Container(child: Text('General Event Types',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),
                ),
              ],),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  checkbox("UserRequest", userrequest,16),
                  checkbox("Normal", normal,17),
                   checkbox("Acc Off", accoff,18),

                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  checkbox("Acc On", accon,19),
                  checkbox("Power Cut", powercut,20),
                   checkbox("Vibration", vibration,21),

                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  checkbox("Sound Alarm", soundalarm,22),
                  checkbox("GeoFenceRuleException", geofenceruleexc,23),

                ],
              ),
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                              checkbox("Enter Geofence Area", entergeofencearea,24),

                ],
              ),
                  
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  checkbox("Exit Geofence Area", exitgeofencearea,25),
                  checkbox("UNKNOWN", unknown,26),

                ],
              ),
              
              
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start ,
              //   children: <Widget>[
                  
              //     checkbox("Mon", monVal),
              //     checkbox("Tu", tuVal),
              //     checkbox("Wed", wedVal),
              //     checkbox("Thur", thurVal),
              //     checkbox("Fri", friVal),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     checkbox("Sat", satVal),
              //     checkbox("Sun", sunVal),
              //   ],
              // ),
            ],
          ),
        );
  }
  @override
  Widget build(BuildContext context) {
    
severity.clear();
generalEvents.clear();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Event Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
          centerTitle: true,
        ),
        body: Container(child: showData(),));
  }
  
}