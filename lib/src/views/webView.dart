import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FleetlyWebview extends StatefulWidget{
    createState() => _FleetlyWebviewState();
  FleetlyWebview({this.htmlText});
   String htmlText;
 
}



class _FleetlyWebviewState extends State<FleetlyWebview> {
   String htmlText;
  
  @override
  Widget build(BuildContext context) {
    print(widget.htmlText);
    var token = widget.htmlText;
    return Scaffold(
    //   body:          const WebView(
    //     initialUrl: 'https://trackany-qa.azurewebsites.net/Account/AccountLogin?token=',
    //     javascriptMode: JavascriptMode.unrestricted,
    //   ) ,
    // );
 
      // appBar: AppBar(
      //     // iconTheme: IconThemeData(
      //     //   color: Colors.green,
      //     //    //change your color here
      //     // ),
      //   title:  Text('ejee', textAlign: TextAlign.center,
      //     style: new TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.green),
      //     ),
        
      //   backgroundColor: Colors.white,
      // ),
      // body:
      //     new Container(
      //       height: 1000.0,
      //       color: Colors.red,
      //       child: new WebView(
      //         initialUrl: 'https://www.littlepink.org/retreats/property/application/',
      //       ),
      //     )
         body: new WebviewScaffold
        (
         // https://qa.fleetly.live/Account/AccountLogin?token=$token
          
           // url: 'https://www.littlepink.org/retreats/property/application/',
            url: 'https://www.fleetly.live/Account/AccountLogin?token=$token' ,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                child: const Center(
                 child: CircularProgressIndicator(),
                ),
              ),
              
    ),
     
    );
  }
}