import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teaTimer/data/tea_data.dart';
import 'package:teaTimer/icons/app_icons_icons.dart';
import 'package:teaTimer/pages/timer.dart';

class FavoritePage extends StatefulWidget {
  final List<Tea> favouriteList;

  const FavoritePage({required this.favouriteList, Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Tea> favorList = [];

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