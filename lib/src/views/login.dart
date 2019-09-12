
    
import 'dart:io';
import 'package:fleetly/src/views/forgot_password.dart';
import 'package:intl/intl.dart';
import 'package:fleetly/src/models/getdriver_model.dart';
import 'package:fleetly/src/models/getevents_model.dart';
import 'package:fleetly/src/models/userdetails_model.dart';
import 'package:fleetly/src/user_profile.dart';
import 'package:fleetly/src/views/homepage.dart';
import 'package:fleetly/src/views/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

//import 'package:flutter_login_demo/services/authentication.dart';

class LoginSignUpPage extends StatefulWidget {
     LoginSignUpPage({this.getDriversListResultData,this.eventsList});

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
  List userDataList;
   BuildContext _context;
   String alertText;
GetDrivers getDriversListResultData;
  GetEvents getEventsList;
 var httpClient = new HttpClient();
  final TextEditingController _emailTextController = TextEditingController();
    final TextEditingController _passwordTextController = TextEditingController();


  final _formKey = new GlobalKey<FormState>();
  // final loginAPi = LoginApiClient(); 
  String _email;
  String _password;
  String _errorMessage;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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
     
       if ((_emailTextController.text.isNotEmpty) && (_passwordTextController.text.isNotEmpty) ) {
        bool isVerifiedEmail = isEmail(_emailTextController.text);
        if (isVerifiedEmail){
var userDetails;
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
        var body = {'username': _emailTextController.text, 'password': _passwordTextController.text,'grant_type':'password'};
      Response res = await post('https://qa.fleetly.live/api/users/login?=',body: body);
      // await httpClient.post('https://trackany-qa.azurewebsites.net//api/users/login?=',body);
      print(res);
      if (res.statusCode == 200) {
         //final data = res.body;
     final resourcesList = loginFromJson(res.body);
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


      
     final driverresponse = await getDriversData(accessToken);  
       print(driverresponse.body);
     if (driverresponse.statusCode == 200) {
       print(driverresponse);
       final resourcesList = getDriversFromJson(driverresponse.body);
         getDriversListResultData = resourcesList;
         print(getDriversListResultData.lastReportedTime);
         DateFormat dateFormat = DateFormat("dd-MMM-yyyy HH:mm");
         DateTime dateTime = dateFormat.parse(getDriversListResultData.lastReportedTime);
         print(dateTime);

  //        DateTime todayDate = DateTime.parse(getDriversListResultData.lastReportedTime);
  // print(todayDate);
  // print(formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));

      //    var newDateTimeObj2 = new DateFormat("dd/MM/yyyy HH:mm:ss").parse("10/02/2000 15:13:09");

      //    DateTime reporteddate = DateTime.parse(getDriversListResultData.lastReportedTime);
      // //var nowDate = new DateTime.now();
      // var formatter = new DateFormat('yyyy-MM-dd');

      // String formattedReportedDate = formatter.format(reporteddate);
      // print(formattedReportedDate); 
    // final http.Response response =
    // await http.post(Uri.encodeFull(url), body: activityData);
         final eventsResponse = await getEventsData(accessToken,getDriversListResultData.deviceIdentifier,'22019-08-12',getDriversListResultData.email);  
       print(eventsResponse.body);
       if (eventsResponse.statusCode == 200) {
       print(eventsResponse);
       final events = getEventsFromJson(eventsResponse.body);
       getEventsList = events;
       Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new Homepage(str:accessToken,userData:userDetails, getDriversListResultData: getDriversListResultData,getEventsList :getEventsList)));

       }
       
     }

       // var token = 'K-4fZozwL5snw9j6tyoRfk3VwxT2MNydsIehwVFMVt73fFUMtfzxZtZvu6vU__ff2uccnw1-R0gqZHJiWgHtoGj76GOEsvT40UmAa3dW03RNQ49acbT0BRxxR8k-0x07Th3-4i-JnJLrtbOMnLk3vfgNgNwpRRBvn1U3Ec12Lq5JKSBoZny62lQA4-oVWdi9ymeAulVSMkZqKC8kbrtiQRBlOI_S8vrqJZGw2LFiT1gUANE2rMXtdhGTAQvRJl8bp2Hhd3um4jr0h64bB0unwzROC-Q3BiQkSP_FTgzxcePBxqzZpo8XdcXUJ_1zLHjEthWWpD64m-mvOWL2zaSEMDOlt1-Mu1NJ_SEv-DjdSCtMbq9ydKswHIgvl6c-9MBXxHdWB7sAGa_5pd1iJ9cPUgAex2LB4RKg96ES7m-zKj6-H-m9nCxxhOn1_uiD2_IsNdIx4zFkWasldh-5UDMNiqH7QhsmuRjYLhDzuIlvlCXz-AoBCMSp3_iA0joy1Px-';
//  final webResponse = await webViewData(accessToken);  
//        print(webResponse.body);
//      if (webResponse.statusCode == 200) {
//        print(webResponse..body);
//      }
//Navigator.of(context).push(new MaterialPageRoute(
                  //    builder: (BuildContext context) => new Homepage(str:accessToken, htmlText:webResponse.body)));
 
     }
     }
     }
        }else{
        alertText = "Please enter valid Email ID";

         _showDialogAlert();

        }

       }
     }
     
   
  }
bool isEmail(String em) {

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

  @override
  void initState() {
    _errorMessage = "";
     _isLoading = false;
    super.initState();
  }

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
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Fleetly login'),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: <Widget>[
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
    return new Container(
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
        ));
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
                    height: 170.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        // Padding(
                        //     padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        //     child: new Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[],
                        //     )),
                        Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                   decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/logo.png"),
              fit: BoxFit.fill,
          )
        ),
                                  
                                  width: 260,
                                  height: 80,
                                  
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
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        controller: _emailTextController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            prefixIcon: new Icon(
              Icons.mail,
              color: Colors.green,
            )
            // icon: new Icon(
            //   Icons.mail,
            //   color: Colors.grey,
            // )
            ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        controller: _passwordTextController,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
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
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
          
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
                
            // child: _formMode == FormMode.LOGIN
            //     ? new Text('SUBMIT',
            //         style: new TextStyle(fontSize: 20.0, color: Colors.white))
            //     : new Text('Create account',
            //         style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}

