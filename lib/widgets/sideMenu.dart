import 'package:flutter/material.dart';

class sideMenu extends StatelessWidget {
  const sideMenu({Key? key}) : super(key: key);

  //TODO: SideMenu implementieren - evtl stateful??
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: Container(
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
