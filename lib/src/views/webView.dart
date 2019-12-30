import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FleetlyWebview extends StatefulWidget{
    createState() => _FleetlyWebviewState();
  FleetlyWebview({this.htmlText});
   String htmlText;
 
}



class _FleetlyWebviewState extends State<FleetlyWebview> with AutomaticKeepAliveClientMixin<FleetlyWebview>{
   String htmlText;
 
   @override
  Widget build(BuildContext context) {
    print(widget.htmlText);
    var token = widget.htmlText;
    return Scaffold(
   
         body: new WebviewScaffold
        (
         // https://qa.fleetly.live/Account/AccountLogin?token=$token
          
            url: 'https://qa.fleetly.live/Account/AccountLogin?token=$token' ,
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
   @override
  bool get wantKeepAlive => true;
}