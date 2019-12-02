import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class BasicDateField extends StatefulWidget {
  @override
  _SearchListExampleState createState() => new _SearchListExampleState();
}

class _SearchListExampleState extends State<BasicDateField> {
  DateTime _date = new DateTime.now();
   var nowDate = new DateTime.now();
   var formatter = new DateFormat('yyyy-MM-dd');

  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async{

    final DateTime picked = await showDatePicker(
      context: context,initialDate: _date,firstDate: new DateTime(2016),
      lastDate: new DateTime(2020)
    );
    if (picked != null && picked != _date){
      print('date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
   String formattedReportedDate = formatter.format(_date);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('data'),
      ),
        //backgroundColor: Colors.white,
        body: new Container(
          padding: EdgeInsets.all(32.0),
          child: new Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[

           new Text('date selected: ${formattedReportedDate}'),
           new RaisedButton(
             child: new Text('select date'),
             onPressed: (){
               _selectDate(context);
             },
           )
            ],
          ),
        ));
  }

 
}