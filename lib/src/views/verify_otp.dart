import 'package:fleetly/src/common/common_colors.dart';
import 'package:fleetly/src/models/userdetails_model.dart';
import 'package:fleetly/src/user_profile.dart';
import 'package:fleetly/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ResetPasswordPage extends StatefulWidget {
       ResetPasswordPage({this.userName});
       String userName;

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
 
     BuildContext _context;
      String dialogText;
       String newPassword;
        String userName;
       String sendUserName;
       bool isResetSuccess = false;






  final FocusNode myFocusNode = FocusNode();
  List<UserDetails> userData;
  final TextEditingController _newPasswordTextController = TextEditingController();
  final TextEditingController _confirmPassordTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                          padding: EdgeInsets.only(top: 30.0),
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
  @override
  Widget build(BuildContext context) {
    // print(widget.userDetails);
    _context = context;
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text('Reset Password'),
        //   backgroundColor: Colors.green,
        // ),
        body:Stack(
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
           new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _showLogo(),
        //           new Container(
        //             height: 170.0,
        //             color: Colors.white,
        //             child: new Column(
        //               children: <Widget>[
        //                 // Padding(
        //                 //     padding: EdgeInsets.only(left: 20.0, top: 20.0),
        //                 //     child: new Row(
        //                 //       crossAxisAlignment: CrossAxisAlignment.start,
        //                 //       children: <Widget>[],
        //                 //     )),
        //                 Padding(
        //                   padding: EdgeInsets.only(top: 60.0),
        //                   child:
        //                       new Stack(fit: StackFit.loose, children: <Widget>[
        //                     new Row(
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: <Widget>[
        //                         Container(
        //                            decoration: new BoxDecoration(
        //   image: new DecorationImage(
        //       image: new AssetImage("assets/logo.png"),
        //       fit: BoxFit.fill,
        //   )
        // ),
                                  
        //                           width: 260,
        //                           height: 80,
                                  
        //                         ),
        //                       ],
        //                     ),
        //                   ]),
        //                 )
        //               ],
        //             ),
        //           ),
                 
                   Padding(
                     padding: EdgeInsets.only(bottom: 10.0),
                     child: new Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                             padding: EdgeInsets.only(
                                 left: 8.0, right: 8.0, top: 25.0),
                             child: new Row(
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                 new Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                     new Text(
                                       'New Password',
                                       style: TextStyle(
                                         color: Colors.white,
                                           fontSize: 17.0,
                                           fontWeight: FontWeight.w500),
                                     ),
                                   ],
                                 ),
                               ],
                             )),
                         _enterNewPassword(),
                             Padding(
                             padding: EdgeInsets.only(
                                 left: 8.0, right: 8.0, top: 25.0),
                             child: new Row(
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                 new Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                     new Text(
                                       'Confirm Password',
                                       style: TextStyle(
                                         color: Colors.white,
                                           fontSize: 17.0,
                                           fontWeight: FontWeight.w500),
                                     ),
                                   ],
                                 ),
                               ],
                             )),
                         _confirmNewPassword(),
                         
                          _verifyButton(),

                       ],),)
                ],
              ),
            ],
          ),
          ]));
  }
  Widget _verifyButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20, top: 20),
      child: Container(
        height: 50.0,
        width:MediaQuery.of(context).size.width,
        child: new RaisedButton(
          
          elevation: 5.0,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.green,
               child:  Center(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     new Text('Reset Passowrd',
                        style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                      //  Icon(Icons.lock,color: Colors.white,)
                   ],
                 ),
               ),
              
         
          onPressed: resetPassword,
        ),
      ),
    );
  }
  void resetPassword() async {
  
   var str =  validatePassword(_newPasswordTextController.text);
     if(str == 'Please enter password'){
       dialogText = 'Please enter password';
      _showDialogAlert() ;
     }else if(str == 'Enter valid password'){
       dialogText = 'Please enter valid password';
      _showDialogAlert() ;
     }else if (_newPasswordTextController.text == _confirmPassordTextController.text){
   _confirmPassordDetails();
  }else{
   dialogText = "Passwords do not match.";
                
       _showDialogAlert();
  }
  }
 
    void _confirmPassordDetails() async { 

      newPassword = _newPasswordTextController.text;
      sendUserName = widget.userName;
     final response = await confirmPassord(sendUserName,newPassword);  
       print(response.body);
       if (response.statusCode == 404){
         dialogText = "Something went wrong, please try again.";
        _showDialogAlert();
       }else{
        if (response.body.isEmpty){
         dialogText = "Something went wrong, please try again.";
          _showDialogAlert();

        }else{
          dialogText = "Password reset successfull.";
          setState(() {
            isResetSuccess = true;

          });

          _showDialogAlert();

        }
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
          content: new Text(dialogText),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                isResetSuccess ? Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginSignUpPage()))
: Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
 

  

 Widget _enterNewPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: TextFormField(
   // keyboardType: TextInputType.number,
   controller: _newPasswordTextController,
    obscureText: true,
    autofocus: false,
    style: TextStyle(fontSize: 16.0, color: Colors.white),
     decoration: new InputDecoration(
            hintText: 'Enter new password',
            hintStyle: TextStyle(color: Colors.white60),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: new Icon(
              Icons.lock,
              color: Colors.green,
            )

            ),
    // decoration: InputDecoration(
    //   filled: true,
    //   fillColor: CommonColors.greyColor,
    //   hintText: 'Enter new password',
    //          prefixIcon: new Icon(
    //           Icons.lock,
    //           color: Colors.green,
    //         ),
    //   contentPadding:
    //       const EdgeInsets.only(left: 14.0, bottom: 18.0, top: 15.0),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.white),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   enabledBorder: UnderlineInputBorder(
    //     borderSide: BorderSide(color: Colors.white),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // ),
    //  validator: (value){
    //    var str = validatePassword(value);
    //    if (str == "Please enter password"){
   
    //    }
     
    //      return value;
       
    //  },
      ),
    );
  }
  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter valid password';
      else
        return null;
    }
  }
   bool validateStructure(String value){
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }
  Widget _confirmNewPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: TextFormField(
    //keyboardType: TextInputType.number,
   controller: _confirmPassordTextController,
    obscureText: true,
    autofocus: false,
    style: TextStyle(fontSize: 16.0, color: Colors.white),
     decoration: new InputDecoration(
            hintText: 'Confirm password',
            hintStyle: TextStyle(color: Colors.white60),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: new Icon(
              Icons.lock,
              color: Colors.green,
            )

            ),
    // decoration: InputDecoration(
    //   filled: true,
    //   fillColor: CommonColors.greyColor,
    //   hintText: 'Confirm password',
    //          prefixIcon: new Icon(
    //           Icons.lock,
    //           color: Colors.green,
    //         ),
    //   contentPadding:
    //       const EdgeInsets.only(left: 14.0, bottom: 18.0, top: 15.0),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.white),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   enabledBorder: UnderlineInputBorder(
    //     borderSide: BorderSide(color: Colors.white),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // ),
     
      ),
    );
  }
 

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

}
