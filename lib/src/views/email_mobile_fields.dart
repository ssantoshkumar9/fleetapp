import 'package:fleetly/src/views/homepage.dart';
import 'package:fleetly/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EmailMobilePage extends StatefulWidget {
     EmailMobilePage({this.emailPhoneStr});
String emailPhoneStr;
String value = "Something";

  @override
  State<StatefulWidget> createState() => _EmailMobilePageState();
  
}

class _EmailMobilePageState extends State<EmailMobilePage> {
 // Option 2
String emailPhoneStr;
String value = "Something" ;
Widget checkUser(){
  if (value == "Something" ){
     checkUserExist();

  }else{
    if (value == "" ){
 setState(() {
        LoginSignUpPage();
    });
    }else{
 setState(() {
       Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Homepage()));
    });
    }
    
  }
// Navigator.of(context).push(new MaterialPageRoute(
//                     builder: (BuildContext context) => new Homepage()));

//   }
}
  Future <String> checkUserExist() async {
     
  final storage = new FlutterSecureStorage();
   value = await storage.read(key: "token");
    if (["", null].contains(value)) { 
       deleteKeys();
         Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginSignUpPage()));
      return  "";
      
     } else{
         Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginSignUpPage()));
      return  value;
     }
    }
     void deleteKeys() async{
  FlutterSecureStorage storage = FlutterSecureStorage();

  await storage.deleteAll();

   }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child:checkUser(),
        ),
      );
    
  }
}