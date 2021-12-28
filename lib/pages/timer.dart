import 'package:flutter/material.dart';
import 'package:teaTimer/data/tea_data.dart';
import 'package:teaTimer/main.dart';

class timerPage extends StatefulWidget {
  final Tea teeData;

  const timerPage({required this.teeData,Key? key}) : super(key: key);

  @override
  _timerPageState createState() => _timerPageState();
}

class _timerPageState extends State<timerPage> {
  var teeData;

  @override
  void initState(){
    teeData = widget.teeData;
  }

  //TODO: Timer implementieren
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
        title: Text("Timer"),
      ),
      backgroundColor:  Color.fromRGBO(58, 66, 86, 1),
      body: Container( // Placeholder!
        padding: EdgeInsets.only(bottom: 100),
        child: Center(
            child: Text("${teeData.name} Timer \n"
                "Duration: ${teeData.duration}",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.white),)
        ),
      )
    );
  }
}
