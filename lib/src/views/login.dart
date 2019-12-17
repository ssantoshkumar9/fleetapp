
    
import 'dart:async';
import 'dart:io';
import 'package:fleetly/src/models/newevents_model.dart';
import 'package:fleetly/src/views/forgot_password.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:fleetly/src/models/getdriver_model.dart';
import 'package:fleetly/src/models/getevents_model.dart';
import 'package:fleetly/src/models/userdetails_model.dart';
import 'package:fleetly/src/user_profile.dart';
import 'package:fleetly/src/views/homepage.dart';
import 'package:fleetly/src/views/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:flutter_login_demo/services/authentication.dart';

class LoginSignUpPage extends StatefulWidget {
     LoginSignUpPage({this.getDriversListResultData,this.eventsList});
ProgressDialog pr;

  GetDrivers getDriversListResultData;
  GetEvents eventsList;
  //LoginSignUpPage({this.auth, this.onSignedIn});

  //final BaseAuth auth;
  //final VoidCallback onSignedIn;
 

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
         FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  List userDataList;
   BuildContext _context;
   String alertText;
   String date;
GetDrivers getDriversListResultData;
  List<NewEventsList> getEventsList;
 var httpClient = new HttpClient();
  final TextEditingController _emailTextController = TextEditingController();
    final TextEditingController _passwordTextController = TextEditingController();


  final _formKey = new GlobalKey<FormState>();
  // final loginAPi = LoginApiClient(); 
  String _email;
  String _password;
  String _errorMessage;
  String reportTime;
  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;
  ProgressDialog pr;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
void checkTime() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "currentTime");
  if (value == "0" || value == null){
    var nowDate = new DateTime.now();
   String dateNow = nowDate.toString();
         dateNow.substring(0,10);
         print( dateNow.substring(0,10));
         var date =  dateNow.substring(0,10);
        //  var time = dateNow[1];
         var hrs = dateNow.substring(11,13);
         var min = dateNow.substring(14,16);
         var sec =  dateNow.substring(17,19);
         var reqtime  = date + 'T' + hrs + ':' + min + ':' + sec;
         reportTime = reqtime;
         await storage.write(key: "currentTime", value: reportTime);
  }else{
reportTime = value;
if (value != null){
   await storage.write(key: "currentTime", value: value);

}

  }

  
}
 void checkUserExists() async{
  final prefs = await SharedPreferences.getInstance();
  FlutterSecureStorage storage = FlutterSecureStorage();

if (prefs.getBool('first_run') ?? true) {

  //await storage.deleteAll();

  prefs.setBool('first_run', false);
}else{
  
   String token = await storage.read(key: "token");
   print(token);
  if (token != "" || token != null){
    
//  final eventsResponse = await getEventsData(token,reportTime);  
//        print(eventsResponse.body);
//        if (eventsResponse.statusCode == 200) {
//        print(eventsResponse);
//        final events = newEventsListFromJson(eventsResponse.body);
//        getEventsList = events;
//        Navigator.of(context).push(new MaterialPageRoute(
//                        builder: (BuildContext context) => new Homepage(str:token, reportTime: reportTime,getEventsList :getEventsList)));

//        }
  }
}
}
  // Perform login or signup
  void _validateAndSubmit() async {
    if (_emailTextController.text.isEmpty || _passwordTextController.text.isEmpty){
     if(_emailTextController.text.isEmpty){
       alertText = "Please enter Email ID";
        _showDialogAlert();

     }else{
       bool isVerifiedEmail = isEmail(_emailTextController.text);
        if (isVerifiedEmail){
       alertText = "Please enter Password";
           _showDialogAlert();


        }else{
        alertText = "Please enter valid Email ID";

         _showDialogAlert();

        }

     }

    }else{
          _showCircularProgress();

       if ((_emailTextController.text.isNotEmpty) && (_passwordTextController.text.isNotEmpty) ) {
        bool isVerifiedEmail = isEmail(_emailTextController.text);
        if (isVerifiedEmail){
var userDetails;
   pr.show();
 
//  var token  = 'VIJXJg5xivRnFlifdcbkBFnE4AUCDzeK5z6ALF4pmdkuby-FYl5lWEwapGyYXOj93IBhbUPy2Fd-prnxAkE-iBWHWhWdfmQjHsUwlw1ZPsO0UErnhS20qKgbUVTNd1FKWPkUjsJNCJ_gIka5Kj7dIZ909K7SC02CZJdx4oPawk8UG5mpQJ4HpMM4hibjXL3ZGsDKpKh9Icwh85hw1qmAqFrPQfUmT1OrpMnWqz_UWz3X3sDPmJM3HL1MQlfBmICtD3FOifvxMmz-hqNYrXNSEcejgtZ_wtgr5zHBlmh1cL27haPe10y_5WvL1fQSh7jta9slvnC2MqsskNsAGt7JB50eN-E6mPZ4yME-6BOPPgd5lP4hTYLiABtmFN6I58xsqCgU_pYTrn-O25ZOZdkwF616E5uQp-HDirC3RHs5vPnRCSKoTfwKTQ2b9VnGzstjxNon5PGbZzGRJz9sTlALFbE5XuJu-pPnqbp2N4wqGSTAtSLr4wwyMYPNnUlKUnbH';
// final webResponse = await webViewData(token);  
//        print(webResponse.body);
//      if (webResponse.statusCode == 200) {
//        print(webResponse..body);
//      }
    // Navigator.of(context).push(new MaterialPageRoute(
    //                   builder: (BuildContext context) => new Homepage(str:token, htmlText:webResponse.body)));
        print(_emailTextController.text,);
        print( _password);

// debgug url
        //https://api-qa.fleetly.tech/
        var body = {'username': _emailTextController.text, 'password': _passwordTextController.text,'grant_type':'password'};
      Response res = await post('https://api-qa.fleetly.tech/api/users/login?=',body: body);
      // await httpClient.post('https://trackany-qa.azurewebsites.net/api/users/login?=',body);
      print(res);
      if (res.statusCode == 200) {
         //final data = res.body;
     final resourcesList = loginFromJson(res.body);
     final storage = new FlutterSecureStorage();
      await storage.write(key: "token", value: resourcesList.accessToken);
    print(resourcesList.accessToken);
      var accessToken = resourcesList.accessToken;
      
       if (["", null].contains(accessToken)) { 
     } else{
       final response = await userData(accessToken);  
       print(response.body);
     if (response.statusCode == 200) {
       var userList = userDetailsFromJson(response.body);
     userDetails = userList;
       print(response);
       checkTime();
       if (reportTime == "0" || reportTime == ""){
         checkTime();
       }else{
print(date);
 var nowDate = new DateTime.now();
  print(reportTime);
  var dateSend = '"' + reportTime + '"';
    var time = new DateFormat("H:m:s").format(nowDate);
      var timeSend = '"' + time + '"';

    print(timeSend);
Map<String, String> headers = {HttpHeaders.authorizationHeader: "Bearer $accessToken","Content-Type": "application/json"};
 //String json = '{"Datetime": "2019-11-10T13:10:44", "TrackingEvents": ["Speed","SuddenAcceleration","Emergency","GShock","UserRequest","EnterArea","SuddenTurn"], "Severity": [1,2,3],"Take":120,"Skip":0}';
  
   
  String json = '{"Datetime": $dateSend,"TimeZone":"","Take":120,"Skip":0, "DeviceIdentifier":""}';
  
  // make POST request
  //Response res = await post('https://api-qa.fleetly.tech/api/GetEvents', headers: headers, body: json);
 

    //Response res = await post('https://api-qa.fleetly.tech/api/GetEvents', headers: headers, body: json);

// var events =  ['Speed','SuddenAcceleration','Emergency','GShock','UserRequest','EnterArea','SuddenTurn'];
// var severity = [1,2,3];
      // var body = {'Datetime': reportTime, 'TrackingEvents':events,'Severity':severity,"Take":120,"Skip":0};
      Response res = await post('https://api-qa.fleetly.tech/api/GetEvents', headers: headers,body: json);
      // await httpClient.post('https://trackany-qa.azurewebsites.net//api/users/login?=',body);
      print(res);
      if (res.statusCode == 200) {
         //final data = res.body;
     //final resourcesList = loginFromJson(res.body);
      final events = newEventsListFromJson(res.body);
       getEventsList = events;
       if  (getEventsList.length == 0){
                saveEventCount();


       }
       Navigator.of(context).push(new MaterialPageRoute(
                       builder: (BuildContext context) => new Homepage(str:accessToken,userData:userDetails, reportTime: reportTime,getEventsList :getEventsList)));

      }else  if (res.statusCode == 401){
         alertText = "Token Expired";

         _showDialogAlert();
     }else{
        alertText = "Something went wrong, please try again.";

         _showDialogAlert();
     }
    //      final eventsResponse = await getEventsData(accessToken,reportTime);  
    //    print(eventsResponse.body);
    //    if (eventsResponse.statusCode == 200) {
    //    print(eventsResponse);
    //    final events = newEventsListFromJson(eventsResponse.body);
    //    getEventsList = events;
    //    Navigator.of(context).push(new MaterialPageRoute(
    //                    builder: (BuildContext context) => new Homepage(str:accessToken,userData:userDetails, reportTime: reportTime,getEventsList :getEventsList)));

    //    }else  if (eventsResponse.statusCode == 401){
    //      alertText = "Token Expired";

    //      _showDialogAlert();
    //  }else{
    //     alertText = "Something went wrong, please try again.";

    //      _showDialogAlert();
    //  }
       }
    
   
      //new DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
  //    final driverresponse = await getDriversData(accessToken);  
  //      print(driverresponse.body);
  //    if (driverresponse.statusCode == 200) {
  //      print(driverresponse);
  //      final resourcesList = getDriversFromJson(driverresponse.body);
  //        getDriversListResultData = resourcesList;
  //        print(getDriversListResultData.lastReportedTime);
  //        var time = getDriversListResultData.lastReportedTime;
  //        if (time.contains(' AM') || time.contains(' PM')){
  //          var lastRepTime;

  //          if (time.contains(' AM')){
  //          lastRepTime = time.replaceAll(' AM', '');

  //          }else{
  //          lastRepTime = time.replaceAll(' PM', '');

  //          }
  //        DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
  //        DateTime dateTime = dateFormat.parse(lastRepTime);
  //        print(dateTime);
  //         print(dateTime.toString());
  //         String date = dateTime.toString();
  //         date.split('T');
  //         date = date[0];
  //        }else{
  //       DateFormat dateFormat = DateFormat("dd-MMM-yyyy HH:mm");
  //        DateTime dateTime = dateFormat.parse(getDriversListResultData.lastReportedTime);
  //        print(dateTime);
  //         print(dateTime.toString());
  //         String date = dateTime.toString();
  //         date.split('T');
  //         date = date[0];
  //        }
         



  // //        DateTime todayDate = DateTime.parse(getDriversListResultData.lastReportedTime);
  // // print(todayDate);
  // // print(formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));

  //     //    var newDateTimeObj2 = new DateFormat("dd/MM/yyyy HH:mm:ss").parse("10/02/2000 15:13:09");

  //     //    DateTime reporteddate = DateTime.parse(getDriversListResultData.lastReportedTime);
  //     // //var nowDate = new DateTime.now();
  //     // var formatter = new DateFormat('yyyy-MM-dd');

  //     // String formattedReportedDate = formatter.format(reporteddate);
  //     // print(formattedReportedDate); 
  //   // final http.Response response =
  //   // await http.post(Uri.encodeFull(url), body: activityData);

  //        final eventsResponse = await getEventsData(accessToken,getDriversListResultData.deviceIdentifier,date,userDetails.userName);  
  //      print(eventsResponse.body);
  //      if (eventsResponse.statusCode == 200) {
  //      print(eventsResponse);
  //      final events = getEventsFromJson(eventsResponse.body);
  //      getEventsList = events;
  //      Navigator.of(context).push(new MaterialPageRoute(
  //                     builder: (BuildContext context) => new Homepage(str:accessToken,userData:userDetails, reportTime: date,getDriversListResultData: getDriversListResultData,getEventsList :getEventsList)));

  //      }else  if (eventsResponse.statusCode == 401){
  //        alertText = "Toke Expired";

  //        _showDialogAlert();
  //    }
       
  //    }else  if (driverresponse.statusCode == 401){
  //        alertText = "Toke Expired";

  //        _showDialogAlert();
  //    }

       // var token = 'K-4fZozwL5snw9j6tyoRfk3VwxT2MNydsIehwVFMVt73fFUMtfzxZtZvu6vU__ff2uccnw1-R0gqZHJiWgHtoGj76GOEsvT40UmAa3dW03RNQ49acbT0BRxxR8k-0x07Th3-4i-JnJLrtbOMnLk3vfgNgNwpRRBvn1U3Ec12Lq5JKSBoZny62lQA4-oVWdi9ymeAulVSMkZqKC8kbrtiQRBlOI_S8vrqJZGw2LFiT1gUANE2rMXtdhGTAQvRJl8bp2Hhd3um4jr0h64bB0unwzROC-Q3BiQkSP_FTgzxcePBxqzZpo8XdcXUJ_1zLHjEthWWpD64m-mvOWL2zaSEMDOlt1-Mu1NJ_SEv-DjdSCtMbq9ydKswHIgvl6c-9MBXxHdWB7sAGa_5pd1iJ9cPUgAex2LB4RKg96ES7m-zKj6-H-m9nCxxhOn1_uiD2_IsNdIx4zFkWasldh-5UDMNiqH7QhsmuRjYLhDzuIlvlCXz-AoBCMSp3_iA0joy1Px-';
//  final webResponse = await webViewData(accessToken);  
//        print(webResponse.body);
//      if (webResponse.statusCode == 200) {
//        print(webResponse..body);
//      }
//Navigator.of(context).push(new MaterialPageRoute(
                  //    builder: (BuildContext context) => new Homepage(str:accessToken, htmlText:webResponse.body)));
 
     }
     else  if (response.statusCode == 401){
         alertText = "Token Expired";

         _showDialogAlert();
     }
     }
     } else if (res.statusCode == 400){ 
       alertText = "Please enter valid Email ID";

         _showDialogAlert();
     }else { 
       alertText = "Something went wrong, please try again";

         _showDialogAlert();
     }
        }else{
        alertText = "Please enter valid Email ID";

         _showDialogAlert();

        }

       }
     }
     
   
  } 
  
  Widget checkForNewSharedLists(){
    
  }
bool isEmail(String em) {

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
void saveEventCount() async {
    final storage = new FlutterSecureStorage();
      await storage.write(key: "EventCount", value: "00");
       await storage.write(key: "currentTime", value: "0");

}
  @override
  void initState() {
    _errorMessage = "";
     _isLoading = false;
    super.initState();
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
    saveEventCount();
    checkTime();
     checkUserExists();
   
  //   flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  //  var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  //  var ios = new IOSInitializationSettings();
  //  var initSettings = new InitializationSettings(android, ios);
  //  flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification: selectNotification );
  }
//  Future selectNotification(String payload){
//     debugPrint('print payload : $payload');
//     showDialog(context: context, builder: (_) => AlertDialog(
//       title: new Text('Notification'),
//       content: new Text(payload),
//     ));
//   }
//   showNotification() async {
//     var android = new AndroidNotificationDetails('channelId', 'channelName', 'channelDescription', priority: Priority.High, importance: Importance.Max);
//     var iOS = new IOSNotificationDetails();
//     var platform = new NotificationDetails(android, iOS);
//     await flutterLocalNotificationsPlugin.show(0, 'title', 'body', platform,payload: 'this is my name');
//   }
  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    checkTime();
    
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text('Fleetly login'),
        //   backgroundColor: Colors.green,
        // ),
        body: Stack(
          children: <Widget>[
           Container(
             
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ), 
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress(){
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } return Container(height: 0.0, width: 0.0,);

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
                pr.hide();
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showBody(){
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: _formKey,
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                _showLogo(),
                _showEmailInput(),
                _showPasswordInput(),
               // Example(),
                _showPrimaryButton(),
                _forgotPasswordButton(),
                //_showSecondaryButton(),
                _showErrorMessage(),
              ],
            ),
          )),
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showLogo() {
    return new Container(
                    height: 150.0,
                    color: Colors.transparent,
                    child: new Column(
                      children: <Widget>[
                        // Padding(
                        //     padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        //     child: new Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[],
                        //     )),
                        Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                   decoration: new BoxDecoration(
          image: new DecorationImage(
            
              image: new AssetImage("assets/loginlogo.png"),
              fit: BoxFit.fill,
          )
        ),
                                  
                                  width: 300,
                                  height: 100,
                                  
                                ),
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),
                  );
  
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
      child: new TextFormField(
        cursorColor: Colors.white,
        maxLines: 1,
        controller: _emailTextController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(
        color: Colors.white,
    ),
        decoration: new InputDecoration(
            hintText: 'Username or Email',
            hintStyle: TextStyle( color: Colors.white60),
                enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.white),   
                      ),
            prefixIcon: new Icon(
              Icons.mail,
              color: Colors.green,
            )
            
            // icon: new Icon(
            //   Icons.mail,
            //   color: Colors.grey,
            // )
            ),
        validator: (value) => value.isEmpty ? 'Username or Email can\'t be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        controller: _passwordTextController,
        obscureText: true,
        autofocus: false,
           style: TextStyle(
        color: Colors.white,
    ),
        decoration: new InputDecoration(
          
            hintText: 'Password',
             hintStyle: TextStyle( color: Colors.white60),
                 enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.white),   
                      ),
            prefixIcon:  new Icon(
              Icons.lock,
              color: Colors.green,
            )
            // icon: new Icon(
            //   Icons.lock,
            //   color: Colors.grey,
            // )
            ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  // Widget _showSecondaryButton() {
  //   return new FlatButton(
  //     child: _formMode == FormMode.LOGIN
  //         ? new Text('Create an account',
  //             style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
  //         : new Text('Have an account? Sign in',
  //             style:
  //                 new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
  //     onPressed: _formMode == FormMode.LOGIN
  //         ? _changeFormToSignUp
  //         : _changeFormToLogin,
  //   );
  // }
Widget _forgotPasswordButton() {
    return new FlatButton(
      child: new Text('Forgot Password',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white)),
          
      onPressed: (){
         Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ForgotPasswordPage()));

      }
    );
  }
  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 50.0,
          child: new RaisedButton(
            
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
                 child:  new Text('SUBMIT',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                splashColor: Colors.grey,
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
}

