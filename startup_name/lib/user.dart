import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  final FlutterSecureStorage storage;
  bool passwordSet = false;

  User({required this.storage});
  
  bool setPassword(String password, newPassword) {
    String secret = "";
    storage.read(key: "password").then((res) {
      secret = res.toString();
    });

    if (secret == password) {
      storage.write(key: "password", value: newPassword);
      passwordSet = true;
      return true;
    }
    return false;
  }
}
