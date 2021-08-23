import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:startup_name/company.dart';
import 'package:startup_name/customDrawer.dart';

class Settings extends StatefulWidget {
  Settings({required this.cc});

  final String title = "Settings";
  final CompanyController cc;

  @override
  State<StatefulWidget> createState() => _SettingsState(cc: cc);
}

class _SettingsState extends State<Settings> {
  _SettingsState({required this.cc});

  CompanyController cc;

  @override
  Widget build(BuildContext context) {
    TextEditingController currentPW = TextEditingController();
    TextEditingController newPW = TextEditingController();

    final FlutterSecureStorage storage = FlutterSecureStorage();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(
        saveState: () {
          return;
        },
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: "Current Password"),
                        obscureText: true,
                        controller: currentPW,
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: InputDecoration(labelText: "New Password"),
                        obscureText: true,
                        controller: newPW,
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        var pw = await storage.read(key: "password");
                        if (pw == null || pw == currentPW.text) {
                          storage.write(key: "password", value: newPW.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Password changed")));
                        }
                      },
                      icon: Icon(Icons.add_circle_outline),
                      label: Text("Set new password"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        var pw = await storage.read(key: "password");
                        if (pw == null || pw == currentPW.text) {
                          storage.delete(key: "password");
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Password removed")));
                        }
                      },
                      icon: Icon(Icons.remove_circle_outline),
                      label: Text("Remove password"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        var pw = await storage.read(key: "password");
                        if (pw == null || pw == currentPW.text) {
                          cc.deleteList();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("List is empty")));
                        }
                      },
                      icon: Icon(Icons.remove_circle_outline),
                      label: Text("Empty List"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
