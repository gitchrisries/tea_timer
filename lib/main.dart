import 'package:flutter/material.dart';
import 'package:teaTimer/pages/discover.dart';
import 'package:teaTimer/pages/favorites.dart';
import 'package:teaTimer/pages/search.dart';
import 'pages/discover.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'data/tea_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Start(),
    );
  }
}

// Start Widget - Gerüst (appBar, bottomNavigationbar, Drawer)
// Mit flexiblen Body
class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  var pages = [
    discover(),
    FavoritePage(favouriteList: favouriteList),
    SearchPage()
  ];
  String appBarText = "Discover";
  int _selectedPage = 0;
  int _selectedItem = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      _selectedPage = index;
      switch (index) {
        case 0:
          appBarText = "Discover";
          break;
        case 1:
          {
            pages[1] = FavoritePage(favouriteList: favouriteList);
            appBarText = "Favorites";
          }
          break;
        case 2:
          appBarText = "Set Favorites";
          break;
        case 3:
          appBarText = "Account";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 5,
          backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
          title: Text(
            appBarText,
            style: TextStyle(fontSize: 30),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.15),
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
                  onTabChange: _onItemTapped),
            ),
          ),
        ),
        body: IndexedStack(
          index: _selectedPage,
          children: pages,
        ));
  }
}
