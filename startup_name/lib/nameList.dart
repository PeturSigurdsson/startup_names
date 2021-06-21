import 'package:flutter/material.dart';
import 'package:startup_name/company.dart';
import 'package:startup_name/customDrawer.dart';
import 'package:startup_name/expandableRow.dart';

class NameList extends StatefulWidget {
  NameList({Key? key}) : super(key: key);

  final String title = "Companies";

  @override
  _NameListState createState() => _NameListState();
}

class _NameListState extends State<NameList> {
  final CompanyController cc;
  _NameListState() : cc = CompanyController();

  _addCompany() {
    setState(() {
      int index = cc.list.length;
      cc.createCompany((l) => setState(() => l[index] = l[index]));
    });
  }

  ExpandableRow _mappingFunction(company) {
    return ExpandableRow(company: company, cc: cc);
  }

  saveState() {
    cc.saveList();
  }

  loadState() {
    cc.loadList();
    for (Company c in cc.list) {
      c.setReload((l) => setState(() => l[c.id] = l[c.id]));
    }
    setState(() {
      cc.list = cc.list;
    });
  }

  @override
  void initState() {
    loadState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(saveState: saveState),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.vertical -
                  MediaQuery.of(context).viewInsets.vertical,
              child: Card(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  children: cc.list
                      .map<ExpandableRow>(
                        (e) => _mappingFunction(e),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCompany,
        tooltip: 'Create new Company',
        child: Icon(Icons.add),
      ),
    );
  }
}
