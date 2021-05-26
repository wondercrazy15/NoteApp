import 'package:flutter/material.dart';
import 'package:myNews/utils/sharedpreferences.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }

}

class _HomePage extends State<HomePage>{
  bool IsSignIn=true;
  bool IsSignOut=false;
  String name="";
  String email="";
  String Profile="";
  sharedpreferences sp=new sharedpreferences();
  void _signOut() {

    sp.googleSignIn.signOut();
    sp.facebookSignIn.logOut();
    print("User Signed out");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      email=await sp.getStringValuesSF("email");
      name=await sp.getStringValuesSF("name");
      Profile=await sp.getStringValuesSF("profile");
      setState(() {

      });
    })();

    //setData();

  }
  Future<void> setData() async {
    setState(() async {
      email=await sp.getStringValuesSF("email");
      name=await sp.getStringValuesSF("name");
      Profile=await sp.getStringValuesSF("profile");
    });
    print(email+"  "+name+"  "+Profile);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
              children: [
                SizedBox(height: 100,),
                 Center(child: Image(image: NetworkImage(Profile)),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 50)),
                    Text("Name : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    Text(name,style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text("Email : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    Text(email,style: TextStyle(fontSize: 18)),
                  ],
                ),
      ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: MaterialButton(onPressed: (){
                  _signOut();
                  sp.removeValues("name");
                  sp.removeValues("IsLogin");
                  sp.removeValues("email");
                  sp.removeValues("profile");

                  Navigator.of(context).pushReplacementNamed('/SocialLogin');
                  },
                  height: 40,
                  textColor: Colors.white,
                  color: Colors.red,
                  child: new Text("Sign Out",style: TextStyle(color: Colors.white,fontSize: 18)),
                ),
              ),
              ],
            ),

    );
  }

}