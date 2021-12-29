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

  List<Tea> _foundTea = [];

  // Initialisierung von itemSelected mit False
  void fillItemSelected() {
    for (int i = 0; i < teaList.length; i++) {
      itemSelected[teaList[i]] = false;
    }
  }

  @override
  void initState() {
    _foundTea = teaList;
    super.initState();
  }

  void _runFilter(String keyWord) {
    List<Tea> results = [];
    if (keyWord.isEmpty) {
      results = teaList;
    } else {
      for (var tea in teaList) {
        if (tea.name.toLowerCase().contains(keyWord.toLowerCase())) {
          results.add(tea);
        }
      }
    }
    setState(() {
      _foundTea = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (itemSelected.isEmpty) fillItemSelected();
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: CupertinoSearchTextField(
                    padding: EdgeInsets.all(10),
                    onChanged: (value) => _runFilter(value),
                    backgroundColor: Colors.white,
                  )),
              _foundTea.isNotEmpty ? Expanded(
                      child: ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        scrollDirection: Axis.vertical,
                        itemCount: _foundTea.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.white,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Container(
                                child: ListTile(
                                    // Hier wird der Tee in der favouriteListe gespeichert
                                    onTap: () {
                                      setState(() {
                                        if (itemSelected[_foundTea[index]] ==
                                            false) {
                                          itemSelected[_foundTea[index]] = true;
                                          favouriteList.add(_foundTea[index]);
                                        } else {
                                          itemSelected[_foundTea[index]] =
                                              false;
                                          favouriteList
                                              .remove(_foundTea[index]);
                                        }
                                      });
                                    },
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    leading: Container(
                                      padding: EdgeInsets.only(top: 5, left: 5),
                                      child: Icon(
                                          itemSelected[_foundTea[index]] == true
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: Colors.blueAccent),
                                    ),
                                    title: Container(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          _foundTea[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                    subtitle: Container(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.alarm,
                                              size: 15,
                                            ),
                                            Text("  Dauer: " +
                                                _foundTea[index].duration),
                                          ],
                                        ))),
                              ));
                        },
                      ),
                    )
                  : Expanded(
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              },
                              child: Container(
                                alignment: Alignment(0,0),
                                color: Color.fromRGBO(58, 66, 86, 1),
                                child: Text("No results found",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blueGrey),),
                              ),
                            )
                        ),
                      
            ],
          ),
        ));
  }
}
