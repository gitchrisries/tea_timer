import 'package:flutter/material.dart';

class timerPage extends StatefulWidget {
  final List<String> teeData;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
        title: Text("Timer"),
      ),
      backgroundColor:  Color.fromRGBO(58, 66, 86, 1),
      body: Container(
        padding: EdgeInsets.only(bottom: 100),
        child: Center(
            child: Text("${teeData[0]} Timer \n"
                "Duration: ${teeData[1]}",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.white),)
        ),
      )
    );
  }
}
