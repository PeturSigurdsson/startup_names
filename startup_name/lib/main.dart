import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:startup_name/nameList.dart';
import 'package:startup_name/settings.dart';
import 'package:startup_name/company.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CompanyController cc = CompanyController();

  // This widget is the root of your application.
  Future<Widget> initializeUser(Widget r) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    var password = await storage.read(key: "password");
    if (password == null) {
      r = Settings(cc: cc);
    }
    return r;
  }

  Widget resolveRoute() {
    Widget result = NameList(cc: cc);
    initializeUser(result).then((res) {
      result = res;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Names',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        accentColor: Colors.purple,
        hoverColor: Colors.pink,
        cardTheme: CardTheme(
          elevation: 10,
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      home: resolveRoute(),
      routes: {
        "/nameList": (context) => NameList(cc: cc),
        "/settings": (context) => Settings(cc: cc),
      },
    );
  }
}
