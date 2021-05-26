
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sharedpreferences{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<bool> CheckValue(value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey(value);
    return CheckValue;
  }
  addStringToSF(key,value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  addBoolToSF(key,value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key,value);
  }
  getStringValuesSF(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(key);
    return stringValue;
  }
  getboolValuesSF(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    bool boolValue = prefs.getBool(key);
    return boolValue;
  }
  removeValues(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(value);

  }
}