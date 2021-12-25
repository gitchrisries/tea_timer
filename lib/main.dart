import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a,this.b);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: new ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final topAppBar = AppBar(
    elevation: 5,
    backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
    title: Text("Set Favourites"),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      )
    ],
  );

  final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite, color: Colors.white)),
            ],
          )));


  Map<int,bool> itemSelected = Map();

  var teeList = [Pair("Grüner Tee", "5 Minuten"),Pair("Schwarzer Tee", "3 Minuten"),
    Pair("Gelber Tee", "4 Minuten"),Pair("Kamille Tee", "2 Minuten"),
    Pair("Weißer Tee", "5 Minuten"),Pair("Limonen Tee", "2 Minuten"),Pair("Apfel Tee", "2 Minuten")];

  void fillItemSelected(){
    for (int i = 0; i < teeList.length; i++){
      itemSelected[i] = false;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1),
        appBar: topAppBar,
        bottomNavigationBar: makeBottom,
        body: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: teeList.length,
            itemBuilder: (BuildContext context, int index) {
              if (itemSelected.isEmpty) fillItemSelected();
              return Card(
                  elevation: 8.0,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          if (itemSelected[index] == false){
                            itemSelected[index] = true;
                          }else{
                            itemSelected[index] = false;
                          }
                        });
                      },
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          itemSelected[index] == true ? Icons.favorite :
                          Icons.favorite_outline,
                          color: Colors.blueAccent
                        ),
                      ),
                      title: Text(
                        teeList[index].a,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.only(left: 0),
                          child: Row(
                            children: [
                              Icon(Icons.alarm, size: 15,),
                              Text("  Dauer: " + teeList[index].b),
                            ],
                          )
                      )
                    ),
                  ));
            },
          ),
        )
    );
  }
}
