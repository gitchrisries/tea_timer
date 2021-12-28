import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teaTimer/data/tea_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Map für die Speicherung der Favourites mit Index der Liste
  Map<Tea, bool> itemSelected = Map();

  // TODO: Mit File oder Datenbank speichern/auslesen

  // Initialisierung von itemSelected mit False
  void fillItemSelected() {
    for (int i = 0; i < teaList.length; i++) {
      itemSelected[teaList[i]] = false;
    }
  }

  List<Tea> searchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: CupertinoSearchTextField(
                onChanged: (value) {
                  setState(() {
                    searchList = [];
                    for (var tea in teaList) {
                      if (tea.name.toLowerCase().contains(value)) {
                        searchList.add(tea);
                      }
                    }
                  });
                },
                backgroundColor: Colors.white,
              )),
          Expanded(
              child: ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                scrollDirection: Axis.vertical,
                itemCount:
                    searchList.isEmpty ? teaList.length : searchList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (itemSelected.isEmpty) fillItemSelected();
                  return Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      margin:
                          new EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Container(
                        child: ListTile(
                            // Hier wird der Tee in der favouriteListe gespeichert
                            onTap: () {
                              setState(() {
                                if (searchList.isEmpty){
                                  if (itemSelected[teaList[index]] == false) {
                                    itemSelected[teaList[index]] = true;
                                    favouriteList.add(teaList[index]);
                                  } else {
                                    itemSelected[teaList[index]] = false;
                                    favouriteList.remove(teaList[index]);
                                  }
                                }else{
                                  if (itemSelected[searchList[index]] == false) {
                                    itemSelected[searchList[index]] = true;
                                    favouriteList.add(searchList[index]);
                                  } else {
                                    itemSelected[searchList[index]] = false;
                                    favouriteList.remove(searchList[index]);
                                  }
                                }
                              });
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            leading: Container(
                              padding: EdgeInsets.only(top: 5, left: 5),
                              child: Icon(
                                  itemSelected[searchList.isEmpty ? teaList[index] : searchList[index]] == true
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Colors.blueAccent),
                            ),
                            title: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  searchList.isEmpty
                                      ? teaList[index].name
                                      : searchList[index].name,
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
                                    searchList.isEmpty
                                        ? Text(
                                            "  Dauer: " + teaList[index].duration)
                                        : Text("  Dauer: " +
                                            searchList[index].duration),
                                  ],
                                ))),
                      ));
                },
              ),
            ),
        ],
      ),
    );
  }
}
