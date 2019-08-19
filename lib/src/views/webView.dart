import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
// import 'package:html2md/html2md.dart' as html2md;
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class FleetlyWebview extends StatefulWidget{
  FleetlyWebview({this.htmlText});
   String htmlText;
    createState() => _FleetlyWebviewState();

 
}



class _FleetlyWebviewState extends State<FleetlyWebview> {
  @override
  Widget build(BuildContext context) {
       return new Scaffold
//  data: """
//                 <div>Follow<a class='sup'><sup>pl</sup></a> 
//                   Below hr
//                     <b>Bold</b>
//                 <h1>what was sent down to you from your Lord</h1>, 
//                 and do not follow other guardians apart from Him. Little do 
//                 <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
//                 """,
       // return new WebviewScaffold
        (
           body: new Center(
            child: SingleChildScrollView(
              child: Html(
                data: widget.htmlText,
                padding: EdgeInsets.all(8.0),
                onLinkTap: (url) {
                  print("Opening $url...");
                },
               
              ),
            ),
          )
      //      body: new SingleChildScrollView(
      //   child: new Center(
      //     child: new HtmlView(data: html),
      //   ),
      // ),
        // url: new Uri.dataFromString(widget.htmlText, mimeType: 'text/html').toString(),
         // url: 'https://trackany-qa.azurewebsites.net/' ,
          
      // appBar: AppBar(
      //     // iconTheme: IconThemeData(
      //     //   color: Colors.green, //change your color here
      //     // ),
      //   // title:  Text('ejee', textAlign: TextAlign.center,
      //   //   style: new TextStyle(
      //   //         fontSize: 18.0,
      //   //         fontWeight: FontWeight.bold,
      //   //         color: Colors.green),
      //   //   ),
        
      //   backgroundColor: Colors.white,
      // ),
            // withZoom: true,
            // withLocalStorage: true,
            // hidden: true,
            // initialChild: Container(
            //   child: const Center(
            //    child: CircularProgressIndicator(),
            //   ),
            // ),
            
    );
  }
}