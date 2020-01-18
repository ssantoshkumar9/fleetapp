import 'package:fleetly/src/views/homepage.dart';
import 'package:fleetly/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
String value = "";
checkIfAuthenticated() async {
  // await Future.delayed(Duration(seconds: 0)); 
   // could be a long running task, like a fetch from keychain
       final storage = new FlutterSecureStorage();

     value = await storage.read(key: "token");
    print(value);
   //value = await storage.read(key: "token");
    if (value == null) { 
      return  false;
     } else{
      return  true;
     }
    }   

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
             debugShowCheckedModeBanner: false,

      title: 'MyApp',
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginSignUpPage(),
        '/home': (context) => Homepage(str: value,),
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkIfAuthenticated().then((success) {
      if (success) {
                Navigator.pushReplacementNamed(context, '/home');

      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return Center(
      child: CircularProgressIndicator(),
    );
  }
 


}
