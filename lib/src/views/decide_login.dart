import 'package:fleetly/src/views/homepage.dart';
import 'package:fleetly/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// var isLogin = false;
class VPediaApp extends StatelessWidget {
  Future <String> checkUserExist() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "token");
    if (["", null].contains(value)) { 
      return  "";
     } else{
      return  value;
     }
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: checkUserExist().toString() != "" ? Homepage() : LoginSignUpPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Homepage(),
        '/login' : (BuildContext context) => LoginSignUpPage(),
        
      },
    );
  }
}
