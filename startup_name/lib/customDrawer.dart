import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({required this.saveState});
  final Function saveState;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Row(
              children: <Widget>[
                Text(
                  "Navigate",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
              title: Text("Settings"),
              onTap: () {
                saveState();
                Navigator.pop(context);
                Navigator.pushNamed(context, "/settings");
              }),
          ListTile(
              title: Text("Companies"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/nameList");
              }),
        ],
      ),
    );
  }
}
