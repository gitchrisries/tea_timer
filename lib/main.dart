import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teaTimer/icons/app_icons_icons.dart';
import 'pages/timer.dart';
import 'widgets/sideMenu.dart';

void main() => runApp(new MyApp());

// Tee Objekt
class Tee<a, b> {
  a name;
  b duration;

  Tee(this.name, this.duration);
}

// Zur Speicherung der Favoriten
// TODO: Mit File oder Datenbank realisieren
List<Tee> favouriteList = [];

// Teeliste
// TODO: Evtl auch mit File oder Datenbank realisieren -> parsen
var teeList = [
  Tee("Grüner Tee", "5 Minuten"),
  Tee("Schwarzer Tee", "3 Minuten"),
  Tee("Rooibos Tee", "4 Minuten"),
  Tee("Kamille Tee", "2 Minuten"),
  Tee("Marokanische Minze", "5 Minuten"),
  Tee("Limonen Tee", "2 Minuten"),
  Tee("Apfel Tee", "2 Minuten")
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new start(),
    );
  }
}

// Start Widget - Gerüst (appBar, bottomNavigationbar, Drawer)
// Mit flexiblen Body
class start extends StatefulWidget {
  const start({Key? key}) : super(key: key);

  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {
  var pages = [home(favouriteList: favouriteList), favourites()];
  String appBarText = "Home";
  int _selectedPage = 0;
  int _selectedItem = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      _selectedPage = index;
      if (index == 0) {
        pages[0] = home(favouriteList: favouriteList);
        appBarText = "Home";
      }
      if (index == 1) appBarText = "Set Favorites";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: sideMenu(),
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
          title: Text(appBarText),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedItem,
          backgroundColor: Colors.blueGrey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Icon(Icons.home))),
            BottomNavigationBarItem(
                label: "Favorite",
                icon: Container(
                    padding: EdgeInsets.only(right: 25),
                    child: Icon(Icons.favorite))),
          ],
        ),
        body: IndexedStack(
          index: _selectedPage,
          children: pages,
        ));
  }
}

// Set Favourites Page
class favourites extends StatefulWidget {
  const favourites({Key? key}) : super(key: key);

  @override
  _favouritesState createState() => _favouritesState();
}

class _favouritesState extends State<favourites> {
  // Map für die Speicherung der Favourites mit Index der Liste
  Map<int, bool> itemSelected = Map();

  // TODO: Mit File oder Datenbank speichern/auslesen

  // Initialisierung von itemSelected mit False
  void fillItemSelected() {
    for (int i = 0; i < teeList.length; i++) {
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
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    child: ListTile(
                        // Hier wird der Tee in der favouriteListe gespeichert
                        onTap: () {
                          setState(() {
                            if (itemSelected[index] == false) {
                              itemSelected[index] = true;
                              favouriteList.add(teeList[index]);
                            } else {
                              itemSelected[index] = false;
                              favouriteList.remove(teeList[index]);
                            }
                          });
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        leading: Container(
                          padding: EdgeInsets.only(top: 5, left: 5),
                          child: Icon(
                              itemSelected[index] == true
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Colors.blueAccent),
                        ),
                        title: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              teeList[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                        subtitle: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  size: 15,
                                ),
                                Text("  Dauer: " + teeList[index].duration),
                              ],
                            ))),
                  ));
            },
          ),
        ));
  }
}

// Home Body-Widget (Favoriten landen hier)
class home extends StatefulWidget {
  final List<Tee> favouriteList;

  const home({required this.favouriteList, Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  List<Tee> favorList = [];

  @override
  void initState() {
    favorList = widget.favouriteList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1),
        body: Theme(
          data: ThemeData(canvasColor: Colors.transparent),
          child: ReorderableListView.builder(
            padding: EdgeInsets.only(top: 10),
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex = newIndex - 1;
                }
                final element = favorList.removeAt(oldIndex);
                favorList.insert(newIndex, element);
              });
            },
            scrollDirection: Axis.vertical,
            itemCount: favorList.length,
            itemBuilder: (BuildContext context, int index) {
              return (Card(
                  key: Key('$index'),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    child: ListTile(
                      // Hier wird das TimerWidget aufgerufen
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          new CupertinoPageRoute<bool>(
                            builder: (BuildContext context) =>
                                timerPage(teeData: favorList[index]),
                          ),
                        );
                      },
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: Container(
                        padding: EdgeInsets.only(top: 5, left: 5),
                        child: Icon(AppIcons.coffee, color: Colors.blueAccent),
                      ),
                      title: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            favorList[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      subtitle: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.alarm,
                                size: 15,
                              ),
                              Text("  Dauer: " + favorList[index].duration),
                            ],
                          )),
                      trailing: Icon(Icons.menu),
                    ),
                  )
              ));
            },
          ),
        )
    );
  }
}
