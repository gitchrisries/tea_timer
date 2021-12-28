import 'package:flutter/material.dart';
import 'package:teaTimer/data/tea_data.dart';

class timerPage extends StatefulWidget {
  final Tea teeData;

  const timerPage({required this.teeData, Key? key}) : super(key: key);

  @override
  _timerPageState createState() => _timerPageState();
}

class _timerPageState extends State<timerPage> {
  var teeData;

  @override
  void initState() {
    teeData = widget.teeData;
  }

  //TODO: Timer implementieren
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.93,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Color.fromRGBO(58*2, 66*2, 86*2, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.expand_more, size: 35,),
                  )
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 100),
                child: Text(
              "${teeData.name} Timer \n"
              "Duration: ${teeData.duration}",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ],
        ),
      ),
    );
  }
}
