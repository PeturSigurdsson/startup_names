import 'dart:convert';

import 'package:english_words/english_words.dart' as Word;
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:math';

class CompanyController {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Function reload = (Company company) {};

  Map<String, Company> list = {};
  CompanyController();

  saveList() async {
    String encoded = jsonEncode(list);
    await storage.write(key: "list", value: encoded);
  }

  loadList() async {
    var encoded = await storage.read(key: "list");
    if (encoded != null) {
      Map<String, dynamic> decoded = jsonDecode(encoded);
      for (Map<String, dynamic> unit in decoded.values) {
        Company c = Company.fromJson(unit);
        list[c.getName()] = c;
      }
    }
  }

  deleteList() async {
    storage.delete(key: "list");
    list = {};
  }

  createCompany() {
    Random ran = Random();
    Company company = Company(
        avatar: ran.nextInt(994), name: createCompanyName(), id: list.length);
    createFounderName(company);
    createDirt(company.getName());
    list[company.getName()] = company;
  }

  String createCompanyName() {
    final wp = WordPair.random();
    return wp.asPascalCase;
  }

  createFounderName(Company company) {
    Uri url = Uri.parse("https://boredhumans.com/api_babynames.php");

    http.post(url).then((res) {
      List<String> names = res.body.split(RegExp("(<br>|<br./>)"));
      if (names.isNotEmpty) {
        names.removeLast();
      }
      Random r = Random();
      int first = r.nextInt(names.length);
      int last = r.nextInt(names.length);

      String name = names[first] + " " + names[last];
      name = name.replaceAll("\n", "");
      company.setFounderName(name);
      reload(company);
    });
  }

  createDirt(name) async {
    List<String> adjectives = Word.adjectives;
    List<String> nouns = Word.nouns;
    String adjective = adjectives[Random().nextInt(adjectives.length)];
    String noun = nouns[Random().nextInt(nouns.length)];
    String dirt = "I am a $adjective $noun";
    await storage.write(key: name, value: dirt);
  }

  Future<bool> unlockDirt(Company company, String password) async {
    String? secret = await storage.read(key: "password");
    if (password == secret.toString()) {
      storage.read(key: company.getName()).then((res) {
        company.setDirt(res.toString());
        reload(company);
      });
      return true;
    }
    return false;
  }

  lockDirt(Company company) {
    storage.write(key: company.getName(), value: company.getDirt()).then((res) {
      company.setDirt("");
      reload(company);
    });
  }

  setReload(Function r) {
    reload = r;
  }
}

class Company {
  String name;
  num avatar;
  int id;
  String avatarURL;

  String founderName = "";
  String dirt = "";

  Company({this.avatar = 0, this.name = "", this.id = 0})
      : avatarURL = 'https://boredhumans.b-cdn.net/faces2/$avatar.jpg';

  Map<String, dynamic> toJson() {
    return {
      "avatar": avatar,
      "name": name,
      "id": id,
      "avatarURL": avatarURL,
      "founderName": founderName,
    };
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    Company c =
        Company(avatar: json["avatar"], name: json["name"], id: json["id"]);
    c.setUrl(json["avatarURL"]);
    c.setFounderName(json["founderName"]);
    return c;
  }

  void setFounderName(name) {
    founderName = name;
  }

  void setDirt(String d) {
    dirt = d;
  }

  void setUrl(url) {
    avatarURL = url;
  }

  String getUrl() {
    return avatarURL;
  }

  String getName() {
    return name;
  }

  int getID() {
    return id;
  }

  String getDirt() {
    return dirt;
  }

  String getFounderName() {
    return founderName;
  }
}
