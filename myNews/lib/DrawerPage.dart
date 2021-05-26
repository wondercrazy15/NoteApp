import 'package:flutter/material.dart';
import 'package:myNews/ProfilePage.dart';
import 'package:myNews/models/note.dart';
import 'package:myNews/TabLayoutDemo.dart';
import 'package:myNews/MyTab.dart';
import 'package:myNews/note_detail.dart';
import 'package:myNews/utils/sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CurrenLocation.dart';
import 'SocialLogin.dart';

class DrawerPage extends StatefulWidget{
  PageController _pageController;
  DrawerPage(this._pageController);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DrawerPage(this._pageController);
  }

}

class _DrawerPage extends State<DrawerPage>{
  PageController _pageController;
  _DrawerPage(this._pageController);

  String name="";
  String email="";
  String Profile="";
  sharedpreferences spv=new sharedpreferences();

  void _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("IsSocialLogin")) {
      spv.googleSignIn.signOut();
      spv.facebookSignIn.logOut();
    }else{

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs!=null) {
        email = await prefs.getString("email");
        name = await prefs.getString("name");
        Profile = await prefs.getString("profile");
        setState(() {
        });
        print(email);
      }
    })();

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Colors.blue,

            child: DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Profile!=null?NetworkImage(Profile):AssetImage("assets/images/note1.jpg"),
                      fit: BoxFit.cover
                  )
              ),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
////                      CircleAvatar(
////                        radius: 50,
////                        backgroundColor: Colors.transparent,
////                        child: ClipOval(
////                          child:Image.asset("assets/images/jasminprofile.jpg",width: 150,height: 150),),
////                      ),
//
////                Container(
////                  color: Colors.blue,
////                  child: Row(
////                    children: <Widget>[
////                      Expanded(
////                        child: Center(child: Text(email,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:15 )),),
////                      )
////                    ],
////                  ),
////                ),
//              ],
//
//            ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8.0),
            color: Colors.blue,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(email==null?"":email,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:15 )),
                  ),

                )
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.list,color: Colors.black54),
            title: Text('Note List',style: TextStyle(fontSize:18,color: Colors.black54 )),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              this._pageController.jumpToPage(0);
            },
          ),
//          ListTile(
//            leading:  Icon(Icons.note_add, color: Colors.black54,),
//            title: Text('Add Note',style: TextStyle(fontSize:18 ,color: Colors.black54)),
//            onTap: () {
//              Navigator.pop(context);
//              Navigator.push(context,
//              new MaterialPageRoute(builder: (context) => new note_detail(Note('', '', 2),"Add Note")));
//              //Navigator.pop(context);
//
//            },
//          ),
          ListTile(
            leading:  Icon(Icons.perm_identity, color: Colors.black54,),
            title: Text('Profile',style: TextStyle(fontSize:18 ,color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              this._pageController.jumpToPage(1);
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (context) => new ProfilePage()));
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading:  Icon(Icons.import_contacts, color: Colors.black54,),
            title: Text('MyTabPage',style: TextStyle(fontSize:18 ,color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyTab()),
              );

            },
          ),
          ListTile(
            leading:  Icon(Icons.settings, color: Colors.black54,),
            title: Text('TabPage',style: TextStyle(fontSize:18 ,color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TabLayoutDemo()),
              );

            },
          ),
          ListTile(
            leading:  Icon(Icons.location_on, color: Colors.black54,),
            title: Text('Location',style: TextStyle(fontSize:18 ,color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new CurrenLocation()));
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading:  Icon(Icons.exit_to_app, color: Colors.black54,),
            title: Text('Logout',style: TextStyle(fontSize:18 ,color: Colors.black54)),
            onTap: () async{
              _signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("name");
              prefs.remove("IsLogin");
              prefs.remove("email");
              prefs.remove("profile");
              prefs.remove("IsSocialLogin");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder:
                      (context) => SocialLogin()
                  )
              );
            },
          ),
//            ListTile(
//              leading:  Icon(Icons.settings, color: Colors.black54,),
//              title: Text('Setting',style: TextStyle(fontSize:18 ,color: Colors.black54)),
//              onTap: () {
//
//                Navigator.pop(context);
//              },
//            ),
        ],
      ),
    );
  }

}