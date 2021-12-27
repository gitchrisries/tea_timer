import 'package:flutter/material.dart';

class timerPage extends StatefulWidget {
  const timerPage({Key? key}) : super(key: key);

  @override
  _timerPageState createState() => _timerPageState();
}

class _timerPageState extends State<timerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
        title: Text("Timer"),
      ),
      backgroundColor:  Color.fromRGBO(58, 66, 86, 1),
      body: Center(
        child: Text("timer here",
        style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold, color: Colors.white),)
      ),
    );
  }
}
