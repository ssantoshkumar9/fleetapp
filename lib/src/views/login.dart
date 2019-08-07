
    
import 'dart:io';

import 'package:fleetly/src/login_api.dart';
import 'package:fleetly/src/user_profile.dart';
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
    // setState(() {
    //   _errorMessage = "";
    //   _isLoading = true;
    // });
    // if (_validateAndSave()) {
    //   String userId = "";
    //   try {
        // if (_formMode == FormMode.LOGIN) {
        //   userId = await widget.auth.signIn(_email, _password);
        //   print('Signed in: $userId');
        // } else {
        //   userId = await widget.auth.signUp(_email, _password);
        //   widget.auth.sendEmailVerification();
        //   _showVerifyEmailSentDialog();
        //   print('Signed up user: $userId');
        // }
        print(_emailTextController.text,);
        print( _password);
        var body = {'username': _emailTextController.text, 'password': _passwordTextController.text,'grant_type':'password'};
      Response res = await post('https://trackanyqa-webapi.azurewebsites.net/api/users/login?=',body: body);
      // await httpClient.post('https://trackany-qa.azurewebsites.net//api/users/login?=',body);
      print(res);
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
     }
     }
        // setState(() {
        //   _isLoading = false;
        // });

        // if (userId.length > 0 && userId != null && _formMode == FormMode.LOGIN) {
        //   widget.onSignedIn();
        // }

    //   } catch (e) {
    //     print('Error: $e');
    //     setState(() {
    //       _isLoading = false;
    //       if (_isIos) {
    //         _errorMessage = e.details;
    //       } else
    //         _errorMessage = e.message;
    //     });
    //   }
    // }
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
          title: new Text('Flutter login demo'),
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


// import 'package:flutter/material.dart';

// class Login extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final logo = Hero(
//       tag: 'hero',
//       child: Image(
//         width: 150,
//         height: 150,
//         image: AssetImage('assets/lphh-logo.png'),
//       ),
//     );

//     final email = TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       autofocus: false,
//       // initialValue: 'alucard@gmail.com',
//       decoration: InputDecoration(
//          fillColor: Colors.white,
//       filled: true,
//         hintText: 'Email',
//         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
      
//       ),
//       style: new TextStyle(
//         height: 2.0,
//       )
//     );

//     final password = TextFormField(
//       autofocus: false,
//       // initialValue: 'some password',
//       obscureText: true,
//       decoration: InputDecoration(
//          fillColor: Colors.white,
//       filled: true,
//         hintText: 'Password',
//         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//       ),
//       style: new TextStyle(
//         height: 2.0,
//       ),
//     );

//     final loginButton = Padding(
//       padding: EdgeInsets.symmetric(vertical: 16.0),
//       child: RaisedButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(6.0),
//         ),
//         onPressed: () {
//           //  Navigator.of(context).push(new MaterialPageRoute(
//           //             builder: (BuildContext context) => new VolunteerRetreatsListData(str:'participant', title : 'PARTICIPANT RETREAT DETAILS')));  
//                 },
//         padding: EdgeInsets.all(12),
//         color: Colors.green,
//         child: Text('SUBMIT', style: TextStyle(color: Colors.white,height: 2.0)),
//       ),
//     );


//     return Scaffold(
//       //backgroundColor: const Color(0xFFEC9BBC),
//       appBar: AppBar(title: Text('Login',
//           style: new TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.green),
//         ),
//         backgroundColor: Colors.white,),
//       body: 
//          Padding(
//            padding: const EdgeInsets.only(top: 60.0),
//            child: ListView(
//             shrinkWrap: true,
//             padding: EdgeInsets.only(left: 24.0, right: 24.0),
//             children: <Widget>[
//               logo,
//               SizedBox(height: 20.0),
//               email,
//               SizedBox(height: 12.0),
//               password,
//               SizedBox(height: 15.0),
//               loginButton,
//             ],
//         ),
//          ),
//     );
//   }
// }