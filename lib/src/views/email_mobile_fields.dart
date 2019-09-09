import 'package:flutter/material.dart';

class EmailMobilePage extends StatefulWidget {
     EmailMobilePage({this.emailPhoneStr});
String emailPhoneStr;
  @override
  State<StatefulWidget> createState() => _EmailMobilePageState();
  
}

class _EmailMobilePageState extends State<EmailMobilePage> {
 // Option 2
String emailPhoneStr;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child:Text("data")
        ),
      );
    
  }
}