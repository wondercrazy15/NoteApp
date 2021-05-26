import 'package:firebase_database/firebase_database.dart';

class UserInfo{
  String key;
  String username;
  String email;
  String password;

  UserInfo(this.username, this.email, this.password);

  UserInfo.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        username = snapshot.value["username"],
        email = snapshot.value["email"],
        password = snapshot.value["password"];

  toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
    };
  }

}