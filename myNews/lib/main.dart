import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myNews/MainHomePage.dart';
import 'package:myNews/SignupPage.dart';
import 'package:myNews/note_list.dart';
import 'package:myNews/utils/sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'Calculator.dart';
import 'DemoText.dart';
import 'SimpleInterest.dart';
import 'SocialLogin.dart';
import 'FbLogin.dart';
//void main() async
//{
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//  runApp(new MyApp());
//
//}

//Future<void> main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  var isLogin = prefs.getBool("IsLogin");
//  print(isLogin);
//  runApp(MaterialApp(home: isLogin == null ? SocialLogin() : HomePage()));
//}
//
//class MyApp extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() {
//    return _MyApp();
//  }
//
//}
//
//class _MyApp extends State<MyApp> {
//
//  bool IsLogin=false;
//
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    loadPreference() async {
//      sp = await SharedPreferences.getInstance();
//    }
//    Timer(Duration(seconds: 3),
//            (){
//    if(sp.containsKey("IsLogin") ? sp.getBool("IsLogin"):false){
//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder:
//              (context) => HomePage()
//          )
//      );
//    }else{
//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder:
//              (context) =>
//              SocialLogin()
//          )
//      );
//    }
//    });
//
////    (() async {
////      SharedPreferences prefs = await SharedPreferences.getInstance();
////      //Return double
////      bool CheckValue = prefs.containsKey('IsLogin');
////      if(CheckValue)
////        IsLogin=sp.getboolValuesSF("IsLogin");
////    })();
//
//    //setData();
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: "Simple Interest Calculator",
//      debugShowCheckedModeBanner: false,
//      theme: new ThemeData(
//
//        primarySwatch: Colors.blue,
////        accentColor: Colors.blueAccent,
////        brightness: Brightness.light,
//      ),
//      home: IsLogin?HomePage():SocialLogin(),
//
//    );
//  }
//}
//
//
//
//
//
//
//




Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  var isLogin = prefs.getBool("IsLogin");
  runApp(MaterialApp(home: isLogin == null ? SocialLogin() : MainHomePage()));
  //runApp(MaterialApp(home: isLogin == null ? SocialLogin() : note_list()));
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text("Home"),
//        ),
//        body: new Center(child: new Text("Welcome"),),
//      ),
//    );
//  }
//}
