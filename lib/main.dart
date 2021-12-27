import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teaTimer/icons/app_icons_icons.dart';
import 'pages/timer.dart';
import 'widgets/sideMenu.dart';

void main() => runApp(new MyApp());

List<Pair> favouriteList = [];

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
      home: new start(),
    );
  }
}



class start extends StatefulWidget {
  const start({Key? key}) : super(key: key);

  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {

  var pages = [home(favouriteList: favouriteList,),favourites()];
  String appBarText = "Home";
  Color _iconColorHome = Colors.indigo;
  Color _iconColorFav = Colors.white;
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: sideMenu(),
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
          title: Text(appBarText),
        ),
        bottomNavigationBar: Container(
            height: 55.0,
            child: BottomAppBar(
                color: Colors.blueGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            pages[0] = home(favouriteList: favouriteList,);
                            _selectedPage = 0;
                            appBarText = "Home";
                            _iconColorHome = Colors.indigo;
                            _iconColorFav = Colors.white;
                          });
                        },
                        icon: Icon(Icons.home, color: _iconColorHome,size: 30,)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedPage = 1;
                            appBarText = "Set Favourites";
                            _iconColorFav = Colors.indigo;
                            _iconColorHome = Colors.white;
                          });
                        },
                        icon: Icon(Icons.favorite, color: _iconColorFav,size: 27)),
                  ],
                ))),
        body: IndexedStack(
          index: _selectedPage,
          children: pages,
        )
    );
  }
}


class favourites extends StatefulWidget {
  const favourites({Key? key}) : super(key: key);

  @override
  _favouritesState createState() => _favouritesState();
}

class _favouritesState extends State<favourites> {

  Map<int,bool> itemSelected = Map();

  var teeList = [Pair("Grüner Tee", "5 Minuten"),Pair("Schwarzer Tee", "3 Minuten"),
    Pair("Rooibos Tee", "4 Minuten"),Pair("Kamille Tee", "2 Minuten"),
    Pair("Marokanische Minze", "5 Minuten"),Pair("Limonen Tee", "2 Minuten"),Pair("Apfel Tee", "2 Minuten")];

  void fillItemSelected(){
    for (int i = 0; i < teeList.length; i++){
      itemSelected[i] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1),
        body: Container(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            scrollDirection: Axis.vertical,
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
                            favouriteList.add(teeList[index]);
                          }else{
                            itemSelected[index] = false;
                            favouriteList.remove(teeList[index]);
                          }
                        });
                      },
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: Container(
                        padding: EdgeInsets.only(top: 5,left: 5),
                        child: Icon(
                          itemSelected[index] == true ? Icons.favorite :
                          Icons.favorite_outline,
                          color: Colors.blueAccent
                        ),
                      ),
                      title: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                            teeList[index].a,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          )
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.only(left: 20),
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

class home extends StatefulWidget {
  final List<Pair> favouriteList;

  const home({required this.favouriteList, Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1),
        body: Container(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            scrollDirection: Axis.vertical,
            itemCount: favouriteList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 8.0,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    child: ListTile(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).push(
                            new CupertinoPageRoute<bool>(
                              builder: (BuildContext context)
                              => timerPage(teeData: [favouriteList[index].a,favouriteList[index].b]),
                            ),
                          );
                        },
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        leading: Container(
                          padding: EdgeInsets.only(top: 5,left: 5),
                          child: Icon(AppIcons.coffee,
                              color: Colors.blueAccent
                          ),
                        ),
                        title: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              favouriteList[index].a,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            )
                        ),
                        subtitle: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(Icons.alarm, size: 15,),
                                Text("  Dauer: " + favouriteList[index].b),
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


