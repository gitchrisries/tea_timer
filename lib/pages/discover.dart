import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class discover extends StatefulWidget {
  const discover({Key? key}) : super(key: key);

  @override
  _discoverState createState() => _discoverState();
}

class _discoverState extends State<discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, top: 25),
                  child: const Text(
                    "Tee of the day",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,),
                  )),
              Container(
                  padding: const EdgeInsets.only(left: 20, top: 10,right: 20),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/test.jpg',
                          ))),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 15,right: 20),
                child: Text("Grüner Tee", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 5,right: 20),
                child: const Text("Der wichtigste Inhaltsstoff des Tees ist das anregende Koffein, "
                    "das früher im Zusammenhang mit Tee auch als Tein, Teein oder "
                    "Thein bezeichnet wurde. Der Koffeingehalt variiert je nach Grünteesorte sehr "
                    "deutlich. Grundsätzlich weisen die japanischen Sorten Gyokuro und Sencha im "
                    "Teewasser die höchsten und Kukicha und Bancha die niedrigsten Werte auf. "
                    "Weitere Bestandteile der Teeblätter sind Catechine, die wichtigsten Vertreter "
                    "sind Epicatechin (EC), Epicatechingallat (ECG), Epigallocatechin (EGC) und "
                    "Epigallocatechingallat (EGCG). Die meisten gesundheitsfördernden Wirkungen des"
                    " Grüntees werden den Catechinen zugeschrieben. Allerdings sind die Catechine auch "
                    "die Stoffe, die dem Tee den bitteren Geschmack verleihen.")
              )
            ])));
  }
}
