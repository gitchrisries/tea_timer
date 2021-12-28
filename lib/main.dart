import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teaTimer/icons/app_icons_icons.dart';
import 'package:teaTimer/pages/discover.dart';
import 'pages/timer.dart';
import 'widgets/sideMenu.dart';
import 'pages/discover.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
  var pages = [discover(), home(favouriteList: favouriteList), favourites()];
  String appBarText = "Discover";
  int _selectedPage = 0;
  int _selectedItem = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      _selectedPage = index;
      switch(index){
        case 0: appBarText = "Discover"; break;
        case 1: {
          pages[1] = home(favouriteList: favouriteList);
          appBarText = "Favorites";
        }break;
        case 2: appBarText = "Set Favorites";break;
        case 3: appBarText = "Account";break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: sideMenu(),
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 5,
          backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
          title: Text(
            appBarText,
            style: TextStyle(fontSize: 40),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.blueAccent[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: Icons.explore,
                    text: 'Discover',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favorites',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.account_circle,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedItem,
                onTabChange: _onItemTapped
              ),
            ),
          ),
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
                  )));
            },
          ),
        ));
  }
}
