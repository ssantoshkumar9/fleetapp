import 'package:flutter/material.dart';

class ImagesPage extends StatefulWidget {
     ImagesPage({this.images});
List images;
  @override
  State<StatefulWidget> createState() => _ImagesPageState();
  
}

class _ImagesPageState extends State<ImagesPage> {
 // Option 2
List images;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Images List", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
          centerTitle: true,
        ),
       body: SafeArea(
        child: Container(child: showData()),

       ),
      );
    

  }
  Widget showData(){
    return Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return _listItem(
                              context, index, widget.images);
                        },
                      ),
              );
  }
   Widget _listItem(BuildContext context, int index, data) {
     return new Container(
       child: Card(
                child: Column(
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Image' + " " + index.toString()),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 8,left:10 ,right:10 ),
               child: Image.network(
                                data[index].blobUrl,
                                fit: BoxFit.cover,
                                //height: 150,
                               // width: 150
                              ),
             ),
           ],
         ),
       ),
                    width: 150.0,
                    height: 300.0,
                 
                        );
    
  }

}