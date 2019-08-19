
    
import 'dart:io';

import 'package:fleetly/src/login_api.dart';
import 'package:fleetly/src/user_profile.dart';
import 'package:fleetly/src/views/homepage.dart';
import 'package:fleetly/src/views/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:flutter_login_demo/services/authentication.dart';

class LoginSignUpPage extends StatefulWidget {
  //LoginSignUpPage({this.auth, this.onSignedIn});

  //final BaseAuth auth;
  //final VoidCallback onSignedIn;
 

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
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
   
 

    
 CircularProgressIndicator(backgroundColor: Colors.green,);
        print(_emailTextController.text,);
        print( _password);
        var body = {'username': _emailTextController.text, 'password': _passwordTextController.text,'grant_type':'password'};
      Response res = await post('https://trackanyqa-webapi.azurewebsites.net/api/users/login?=',body: body);
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
       print(response);
       // var token = 'K-4fZozwL5snw9j6tyoRfk3VwxT2MNydsIehwVFMVt73fFUMtfzxZtZvu6vU__ff2uccnw1-R0gqZHJiWgHtoGj76GOEsvT40UmAa3dW03RNQ49acbT0BRxxR8k-0x07Th3-4i-JnJLrtbOMnLk3vfgNgNwpRRBvn1U3Ec12Lq5JKSBoZny62lQA4-oVWdi9ymeAulVSMkZqKC8kbrtiQRBlOI_S8vrqJZGw2LFiT1gUANE2rMXtdhGTAQvRJl8bp2Hhd3um4jr0h64bB0unwzROC-Q3BiQkSP_FTgzxcePBxqzZpo8XdcXUJ_1zLHjEthWWpD64m-mvOWL2zaSEMDOlt1-Mu1NJ_SEv-DjdSCtMbq9ydKswHIgvl6c-9MBXxHdWB7sAGa_5pd1iJ9cPUgAex2LB4RKg96ES7m-zKj6-H-m9nCxxhOn1_uiD2_IsNdIx4zFkWasldh-5UDMNiqH7QhsmuRjYLhDzuIlvlCXz-AoBCMSp3_iA0joy1Px-';
 final webResponse = await webViewData(accessToken);  
       print(webResponse.body);
     if (webResponse.statusCode == 200) {
       print(webResponse..body);
     }
 Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new Homepage(str:accessToken, htmlText:webResponse.body)));

     }
     }
     }else{
 

     }
     
   
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
          title: new Text('Flutter login'),
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

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
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
              _showPrimaryButton(),
              _showSecondaryButton(),
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
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
         // child: Image.asset('assets/flutter_icon.png'),
        ),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
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
        onSaved: (value) => _email = value.trim(),
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

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
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

