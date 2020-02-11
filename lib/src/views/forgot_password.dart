import 'package:fleetly/src/common/common_colors.dart';
import 'package:fleetly/src/models/userdetails_model.dart';
import 'package:fleetly/src/user_profile.dart';
import 'package:fleetly/src/views/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  CountryCode _selected;
  bool _status = true;
     BuildContext _context;
      String dialogText;
String otpType;
String otpTypeValue;
String userName;
String countryCodeVal;
  var _isOTPSent = false;

  final FocusNode myFocusNode = FocusNode();
  List<UserDetails> userData;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
    final TextEditingController _otpTextController = TextEditingController();

  final TextEditingController _phoneNumberTextController =
      TextEditingController();

  List<String> _otpType = ['Email Address', 'Mobile Number']; // Option 2
  String _selectedOtpType;

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
                          padding: EdgeInsets.only(top: 10.0),
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
        //   title: new Text('Forgot Password'),
        //   backgroundColor: Colors.green,
        // ),
        body:
        Stack(children: <Widget>[ 
          
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
                  new Column(
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
                              _showLogo()
        //                       Container(
        //                          decoration: new BoxDecoration(
        //   image: new DecorationImage(
        //       image: new AssetImage("assets/logo.png"),
        //       fit: BoxFit.fill,
        //   )
        // ),
                                
        //                         width: 260,
        //                         height: 80,
                                
        //                       ),
                            ],
                          ),
                        ]),
                      )
                    ],
                  ),
                 
                   _isOTPSent ?  Container(color: Color(0xffFFFFFF),
                    child: Padding(
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
                                        'Verify OTP',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          _enterOTP(),
                           GestureDetector(
                                                        child: Padding(
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
                                          'Resend OTP?',
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                                onTap: (){
                                  _getOTPFromDetails();
                                },
                           ),
                           _verifyButton(),

                        ],),),) : 
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 5.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Password Recovery',
                                      style: TextStyle(
                                        color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        _showUserNameInput(),
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
                                      'Verification Method',
                                      style: TextStyle(
                                        color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        showDropdown(),
                        emailPhoneFields()

                       
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ],),
        );
  }
  Widget _verifyButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                     new Text('Verify',
                        style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                        Icon(Icons.touch_app,color: Colors.white,)
                   ],
                 ),
               ),
              
         
          onPressed: verifyOTP,
        ),
      ),
    );
  }
  void verifyOTP() async {
    final storage = new FlutterSecureStorage();
  String value = await storage.read(key:"OTP");
  print(value);
  final otp = value.replaceAll(RegExp('"'), ''); // abc

  print(_otpTextController.text);
  if (otp == _otpTextController.text){
    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new ResetPasswordPage(userName:userName)));

  }else{
   dialogText = "Entered incorrect OTP";        
       _showDialogAlert();
  }
  }
  Widget emailPhoneFields() {
    if (_selectedOtpType == "Mobile Number") {
     
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 25.0, top: 8.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    color: CommonColors.greyColor,
                    width: 80,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: CountryCodePicker(
                        showFlag: false,
                        //showName: false,
                        //showDialingCode: true,
                        onChanged: (CountryCode country) {
                          setState(() {
                            _selected = country;
                            countryCodeVal = _selected.dialCode;
                          });
                        },

                        // selectedCountry: _selected,
                      ),
                    ),
                  ),
                  flex: 1,
                ),


    
                Flexible(
                child:   Padding(
           padding: const EdgeInsets.only(left: 8,top: 22),
          child: new TextFormField(
            maxLines: 1,
            controller: _phoneNumberTextController,
             keyboardType: TextInputType.phone,
    autofocus: false,
    maxLength: 12,
    style: TextStyle(fontSize: 16.0, color: Colors.white),
           
            decoration: new InputDecoration(
                hintText: 'Enter Phone number',
                hintStyle: TextStyle(color: Colors.white60),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon: new Icon(
                  Icons.phone,
                  color: Colors.green,
                )
               
                ),
           
          ),
        ),
 
                  flex: 2,
                ),
              ],
            ),
          ),

          
            GestureDetector(
                          child: Padding(
               padding: const EdgeInsets.only(top: 20,right: 10),
               child: Container(                
                    alignment: Alignment.topRight,
                    child: new Container(
                width: 150,
                height: 50,
                        decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: new BorderRadius.circular(20)
                        ),
                      child: new Center(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                              child: Text("GET OTP",style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),),
                            ),
                         Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: Icon( Icons.phonelink_lock, color: Colors.white, ),
                         ),
                          ],
                        ),
                      )

                  ),
        
                  ),
           ),
           onTap: (){
            if ((_usernameTextController.text.isNotEmpty) && (_phoneNumberTextController.text.isNotEmpty)){
        otpType = "mobilenumber";
        otpTypeValue = countryCodeVal + '-' + _phoneNumberTextController.text;
        userName  = _usernameTextController.text;
        print(otpTypeValue);
        print(userName);
        _getOTPFromDetails();
        

             }else{
                if (_usernameTextController.text.isEmpty){
               dialogText = "Please enter User name";

                }else{
               dialogText = "Please enter Phone number";

                }
               _showDialogAlert();
             }
           },
            ),


         
        ],
      );
    } else if (_selectedOtpType == "Email Address") {
     
      return Container(child: _showEmailInput());
    } else {
      return Container();
    }
  }
    void _getOTPFromDetails() async { 
      print(otpTypeValue);
     final response = await fetchOTP(otpType,otpTypeValue,userName);  
       print(response.body);
       if (response.statusCode == 404){
         dialogText = "Please enter valid details";
        _showDialogAlert();
       }else{
        if (response.body.isEmpty){
         dialogText = "Please enter valid details";
          _showDialogAlert();

        }else{
          final storage = new FlutterSecureStorage();

      await storage.write(key: "OTP", value: response.body.toString());
        setState(() {
      _isOTPSent = true;
    });


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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //  Widget _showPasswordInput() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
  //     child: new TextFormField(
  //       maxLines: 1,
  //       controller: _passwordTextController,
  //       obscureText: true,
  //       autofocus: false,
  //       style: TextStyle(
  //         color: Colors.white,
  //       ),
  //       decoration: new InputDecoration(
  //           hintText: 'Password',
  //           hintStyle: TextStyle(color: Colors.white60),
  //           enabledBorder: UnderlineInputBorder(
  //             borderSide: BorderSide(color: Colors.white),
  //           ),
  //           prefixIcon: new Icon(
  //             Icons.lock,
  //             color: Colors.green,
  //           )
           
  //           ),
       
  //     ),
  //   );
  // }
  Widget showDropdown() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
            color: CommonColors.greyColor,
            borderRadius: BorderRadius.circular(10)
          
        ),
       // color: Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton(
              underline: Container(height: 0,),
              isExpanded: true,
              hint: Text('Select Type'), // Not necessary for Option 1
              value: _selectedOtpType,
              onChanged: (newValue) {
                setState(() {
                  _selectedOtpType = newValue;
                });
              },
              items: _otpType.map((location) {
                return DropdownMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(location),
                  ),
                  value: location,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
   Widget _showEmailInput() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new TextFormField(
            maxLines: 1,
            controller: _emailTextController,
            obscureText: true,
            autofocus: false,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: new InputDecoration(
                hintText: 'Enter Email address',
                hintStyle: TextStyle(color: Colors.white60),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon: new Icon(
                  Icons.email,
                  color: Colors.green,
                )
               
                ),
           
          ),
        ),
             GestureDetector(
                    child: Padding(
               padding: const EdgeInsets.only(top: 20,right: 10),
               child: Container(                
                    alignment: Alignment.topRight,
                    child: new Container(
                width: 150,
                height: 40,
                        decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: new BorderRadius.circular(40)
                        ),
                      child: new Center(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 8,bottom: 8),
                              child: Text("GET OTP",style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),),
                            ),
                         Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: Icon( Icons.phonelink_lock, color: Colors.white, ),
                         ),
                          ],
                        ),
                      )

                  ),
        
                  ),
             ),
              onTap: (){
            if ((_usernameTextController.text.isNotEmpty) && (_emailTextController.text.isNotEmpty)){
             otpType = "email";
           bool isValidEmail =  isEmail(_emailTextController.text);
           if (isValidEmail){
       otpTypeValue =  _emailTextController.text;
        userName  = _usernameTextController.text;
        print(otpTypeValue);
        print(userName);
               _getOTPFromDetails();
           }else{
           dialogText = "Please enter valid Email";
           _showDialogAlert();
           }
             
       
             }else{
                if (_usernameTextController.text.isEmpty){
               dialogText = "Please enter User name";

                }else{
                  
               dialogText = "Please enter Email";

                }
               _showDialogAlert();
             }
           },
         ),
      ],
      
    );
     
  }
//   Widget _showEmailInput() {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextFormField(
//      keyboardType: TextInputType.emailAddress,
//    controller: _emailTextController,
//     autofocus: false,
//     style: TextStyle(fontSize: 18.0, color: Colors.black),
//     decoration: InputDecoration(
//       filled: true,
//       fillColor: CommonColors.greyColor,
//       hintText: 'Enter Email address',
//                prefixIcon: new Icon(
//                 Icons.email,
//                 color: Colors.green,
//               ),
//       contentPadding:
//             const EdgeInsets.only(left: 14.0, bottom: 18.0, top: 15.0),
//       focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(10),
//       ),
//       enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(10),
//       ),
//     ),
//    // validator: _validateEmail,
//  ),
//   //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,

//   ),
  
     
//          GestureDetector(
//                     child: Padding(
//                padding: const EdgeInsets.only(top: 20,right: 10),
//                child: Container(                
//                     alignment: Alignment.topRight,
//                     child: new Container(
//                 width: 150,
//                 height: 40,
//                         decoration: new BoxDecoration(
//                             color: Colors.green,
//                             borderRadius: new BorderRadius.circular(40)
//                         ),
//                       child: new Center(
//                         child: Row(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(left: 15,top: 8,bottom: 8),
//                               child: Text("GET OTP",style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),),
//                             ),
//                          Padding(
//                            padding: const EdgeInsets.only(left: 10),
//                            child: Icon( Icons.phonelink_lock, color: Colors.white, ),
//                          ),
//                           ],
//                         ),
//                       )

//                   ),
        
//                   ),
//              ),
//               onTap: (){
//             if ((_usernameTextController.text.isNotEmpty) && (_emailTextController.text.isNotEmpty)){
//              otpType = "email";
//            bool isValidEmail =  isEmail(_emailTextController.text);
//            if (isValidEmail){
//        otpTypeValue =  _emailTextController.text;
//         userName  = _usernameTextController.text;
//         print(otpTypeValue);
//         print(userName);
//                _getOTPFromDetails();
//            }else{
//            dialogText = "Please enter valid Email";
//            _showDialogAlert();
//            }
             
       
//              }else{
//                 if (_usernameTextController.text.isEmpty){
//                dialogText = "Please enter User name";

//                 }else{
                  
//                dialogText = "Please enter Email";

//                 }
//                _showDialogAlert();
//              }
//            },
//          ),
//       ],
      
//     );
//   }
bool isEmail(String em) {

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
 Widget _enterOTP() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: TextFormField(
    keyboardType: TextInputType.number,
   controller: _otpTextController,
    obscureText: true,
    autofocus: false,
    style: TextStyle(fontSize: 16.0, color: Colors.black),
    decoration: InputDecoration(
      filled: true,
      fillColor: CommonColors.greyColor,
      hintText: 'Enter OTP',
             prefixIcon: new Icon(
              Icons.vpn_key,
              color: Colors.green,
            ),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 18.0, top: 15.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
     
      ),
    );
  }
  Widget _showUserNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: new TextFormField(
        cursorColor: Colors.white,
        maxLines: 1,
        controller: _usernameTextController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
            hintText: 'User Name',
            hintStyle: TextStyle(color: Colors.white60),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: new Icon(
              Icons.person,
              color: Colors.green,
            )

            ),
        // validator: (value) =>
        //     value.isEmpty ? 'Username or Email can\'t be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }
  
  // Widget _showUserNameInput() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
  //     child: TextFormField(
      
  //  controller: _usernameTextController,
  //   autofocus: false,
  //   style: TextStyle(fontSize: 18.0, color: Colors.black),
  //   decoration: InputDecoration(
  //     filled: true,
  //     fillColor: CommonColors.greyColor,
  //     hintText: 'User Name',
  //            prefixIcon: new Icon(
  //             Icons.person,
  //             color: Colors.green,
  //           ),
  //     contentPadding:
  //         const EdgeInsets.only(left: 14.0, bottom: 18.0, top: 15.0),
  //     focusedBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: Colors.white),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     enabledBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(color: Colors.white),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //   ),
  //     // child: new TextFormField(
  //     //   maxLines: 1,
  //     //   controller: _usernameTextController,
  //     //   keyboardType: TextInputType.emailAddress,
  //     //   autofocus: false,
  //     //   decoration: new InputDecoration(
  //     //       hintText: 'User Name',
  //     //       prefixIcon: new Icon(
  //     //         Icons.person,
  //     //         color: Colors.green,
  //     //       )
  //     //       // icon: new Icon(
  //     //       //   Icons.mail,
  //     //       //   color: Colors.grey,
  //     //       // )
  //     //       ),
  //     //   validator: (value) =>
  //     //       value.isEmpty ? 'User Name can\'t be empty' : null,
  //     //   // onSaved: (value) => _email = value.trim(),
  //     // ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
