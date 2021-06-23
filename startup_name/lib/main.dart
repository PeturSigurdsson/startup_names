import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:startup_name/nameList.dart';
import 'package:startup_name/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      home: MyHomePage(title: 'Startup Naming Engine'),
      routes: {
        "/nameList": (context) => NameList(),
        "/settings": (context) => Settings(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _error = false;
  bool _initialized = false;
  Widget next = NameList();

  void initializeFF() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        print("Initialized");
      });
    } catch (error) {
      print("An error occured: $error");
      setState(() {
        _error = true;
      });
    }
    if (_error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading firebase")),
      );
    } else if (!_initialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Loading...")),
      );
    }
  }

  initializeUser() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    var password = await storage.read(key: "password");
    if (password == null) {
      setState(() {
        next = Settings();
      });
    }
  }

  @override
  void initState() {
    initializeFF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return next;
  }
}
