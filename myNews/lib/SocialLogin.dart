import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:myNews/Components/CommonSocialLogin.dart';
import 'package:myNews/HomePage.dart';
import 'package:myNews/SignupPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Components/AppTextFormField.dart';
import 'Components/Socialbtn.dart';
import 'note_list.dart';
import 'utils/sharedpreferences.dart';
class SocialLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SocialLogin();
  }

}

class _SocialLogin extends State<SocialLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey=GlobalKey<FormState>();
  bool IsSignIn=true;
  bool IsSignOut=false;
  String name="";
  String email="";
  String Profile="";
  String password="";
  sharedpreferences spv=new sharedpreferences();
  CommonSocialLogin cm=new CommonSocialLogin();

  Future<Null> signInWithGoogle() async {

    cm.GoogleLogin().then((isLoginUser) {
      if(isLoginUser)
        {

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) => note_list()
              )
          );
        }
      else{
        _showScaffoldRed("Something went wrong!");
      }
    });
//    final GoogleSignInAccount googleSignInAccount = await spv.googleSignIn.signIn();
//    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.credential(
//      accessToken: googleSignInAuthentication.accessToken,
//      idToken: googleSignInAuthentication.idToken,
//    );
//    final UserCredential authResult = await _auth.signInWithCredential(credential);
//    final User user = authResult.user;
//
//    if (user != null) {
//      assert(!user.isAnonymous);
//      assert(await user.getIdToken() != null);
//
//      final User currentUser = _auth.currentUser;
//      assert(user.uid == currentUser.uid);
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      print('signInWithGoogle succeeded: $user');
//      prefs.setBool("IsLogin", true);
//      prefs.setBool("IsSocialLogin", true);
//      prefs.setString("email", user.email);
//      prefs.setString("name", user.displayName);
//      prefs.setString("profile", user.photoURL);
//      setState(() {
//        Profile=user.photoURL;
//        name=user.displayName;
//        email=user.email;
//
//      });
//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder:
//              (context) => note_list()
//          )
//      );

  }
  Future<Null> _login() async {
    final FacebookLoginResult result =
    await spv.facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:


        cm.FacebookLogin(result).then((isLoginUser) {
          if(isLoginUser)
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => note_list()
                )
            );
          }
          else{
            _showScaffoldRed("Something went wrong!");
          }
        });

//        final FacebookAccessToken accessToken = result.accessToken;
//        final graphResponse = await http.get(
//            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${result.accessToken.token}');
//        final profile = jsonDecode(graphResponse.body);
//        final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
//
//        final UserCredential authResult = await _auth.signInWithCredential(credential);
//        final User user = authResult.user;
//        print(user.email);
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//        prefs.setBool("IsLogin", true);
//        prefs.setBool("IsSocialLogin", true);
//        prefs.setString("email", profile["email"]);
//        prefs.setString("name", profile["name"]);
//        prefs.setString("profile", profile["picture"]["data"]["url"]);
//        Navigator.pushReplacement(context,
//            MaterialPageRoute(builder:
//                (context) => note_list()
//            )
//        );

        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  void _BtnLoginClick() async{
    if(_formKey.currentState.validate()){
      try{
        _formKey.currentState.save();
        print(email+"  "+password+"  ");

        var user= await _auth.signInWithEmailAndPassword(email: email, password: password);

        if(user!=null){
          print("User ${user.user.email}");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("IsLogin", true);
          prefs.setBool("IsSocialLogin", false);
          prefs.setString("email", user.user.email);
          //prefs.setString("name", profile["name"]);
          //prefs.setString("profile", profile["picture"]["data"]["url"]);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) => note_list()
              )
          );
          _formKey.currentState.reset();
        }
        else{
          _showScaffoldRed("Email id and password is wrong!");
        }

      }
      catch(e){
        print(e.email);
        _showScaffoldRed("Email id and password is wrong!");

      }
    }
  }

  String _message = 'Log in/out by pressing the buttons below.';



  Future<Null> _logOut() async {
    await spv.facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[ Color(0xff68C6FF),Colors.blueAccent],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }


  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
        key: _scaffoldKey,
        body:
        SafeArea(child: GestureDetector(
          onTap: () {

            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child:  Form(
            key: _formKey,
          child: Center(
              child:  SingleChildScrollView(child:
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Welcome",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,foreground: Paint()..shader = linearGradient),),
                    SizedBox(height: 30,),

                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter Email",

                      ),
                      onSaved: (value)=>email=value,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Please enter Email";
                        }
                      },
                      keyboardType:TextInputType.emailAddress,
              ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open),
                        hintText: "Enter Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _togglevisibility();
                          },
                          child: Icon(
                            _showPassword ? Icons.visibility : Icons
                                .visibility_off, color: Colors.grey,),
                        ),

                      ),
                      onSaved: (value)=>password=value,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Please enter Password";
                        }
                        else if(value.length<6){
                          return "Password more than 5 characters";
                        }
                      },
                      obscureText: !_showPassword,
                      keyboardType:TextInputType.text,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment(1.0,0),
                      child: InkWell(child:
                      Text("Forgot Password",style: TextStyle(color: Colors.blue),textAlign: TextAlign.end,)
                        ,),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _BtnLoginClick();
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.blueAccent, Color(0xff68C6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Login Now",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

//                  InkWell(
//                    child: Container(
//                        width: MediaQuery.of(context).size.width,
//                        height: 50,
//                        margin: EdgeInsets.only(top: 10),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(20),
//                            border: Border.all(color: Colors.black)
//                        ),
//                        child: Center(
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                Container(
//                                  height: 30.0,
//                                  width: 30.0,
//                                  decoration: BoxDecoration(
//                                    image: DecorationImage(
//                                        image:
//                                        AssetImage('assets/images/google.jpg'),
//                                        fit: BoxFit.cover),
//                                    shape: BoxShape.circle,
//                                  ),
//                                ),
//                                Padding(padding: EdgeInsets.only(left: 10)),
//                                Text('Sign in with Google',
//                                  style: TextStyle(
//                                      fontSize: 16.0,
//                                      fontWeight: FontWeight.bold,
//                                      color: Colors.black
//                                  ),
//                                ),
//                              ],
//                            )
//                        )
//                    ),
//                    onTap: ()
//                    async{
//                        signInWithGoogle().then((result) {
//                                        if (result != null) {
//                                      Navigator.of(context).push(
//                                        MaterialPageRoute(
//                                          builder: (context) {
//                                            return ;
//                                          },
//                                        ),
//                                        );
//                                        }});
//                    },
//                  ),
//                  InkWell(
//                    child:
//                    Container(
//                        width: MediaQuery.of(context).size.width,
//                        height: 50,
//                        margin: EdgeInsets.only(top: 10),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(20),
//                            border: Border.all(color: Colors.black)
//                        ),
//                        child: Center(
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                Container(
//                                  height: 30.0,
//                                  width: 30.0,
//                                  decoration: BoxDecoration(
//                                    image: DecorationImage(
//                                        image:
//                                        AssetImage('assets/images/fblogo.png'),
//                                        fit: BoxFit.cover),
//                                    shape: BoxShape.circle,
//                                  ),
//                                ),
//                                Padding(padding: EdgeInsets.only(left: 10)),
//                                Text('Sign in with Facebook',
//                                  style: TextStyle(
//                                      fontSize: 16.0,
//                                      fontWeight: FontWeight.bold,
//                                      color: Colors.black
//                                  ),
//                                ),
//                              ],
//                            )
//                        )
//                    ),
//                    onTap: ()
//                    async{
//                      _login;
//                    },
//                  ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Enter Via Social Networks",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
//                    Container(
//                      height: 35.0,
//                      width: 35.0,
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image:
//                            AssetImage('assets/images/google.png'),
//                            fit: BoxFit.cover),
//                        shape: BoxShape.circle,
//                      ),
//                    ),
                        Socialbtn(
                          onPress: (){
                            signInWithGoogle().then((result) {
                              if (result != null) {
//                              Navigator.of(context).push(
//                                MaterialPageRoute(
//                                  builder: (context) {
//                                    return HomePage();
//                                  },
//                                ),
//                              );

                              }});
                          },
                          icon: "assets/images/google.png",
                          width: 35.0,
                          height: 35.0,
                        ),
                        Container(height: 40, child: VerticalDivider(color: Colors.black)),
//                    Container(
//                      height: 40.0,
//                      width: 40.0,
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image:
//                            AssetImage('assets/images/facebook.png'),
//                            fit: BoxFit.cover),
//                        shape: BoxShape.circle,
//                      ),
//                    ),
                        Socialbtn(
                          onPress: _login,
                          icon: "assets/images/facebook.png",
                          width: 42.0,
                          height: 42.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.bold),),
                        GestureDetector(
                          onTap: () {
                            _formKey.currentState.reset();
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) => new SignupPage()));
                          },
                          child: Text(" Sign up",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                        ),
                      ],),
//            Visibility(
//              child:
//              ConstrainedBox(
//                constraints: const BoxConstraints(minWidth: double.infinity),
//                child: MaterialButton(onPressed: (){
//                  signInWithGoogle().then((result) {
//                    if (result != null) {
////                  Navigator.of(context).push(
////                    MaterialPageRoute(
////                      builder: (context) {
////                        return FirstScreen();
////                      },
////                    ),
////                    );
//                    }},);},
//                  height: 40,
//                  textColor: Colors.white,
//                  color: Colors.blue,
//                  child: new Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 18)),
//                ),
//              ),
//
//              visible: IsSignIn,
//            ),
//            Visibility(
//              child:
//              ConstrainedBox(
//                constraints: const BoxConstraints(minWidth: double.infinity),
//                child: MaterialButton(onPressed: (){
//                  signOutGoogle();
//                  setState(() {
//                    IsSignIn=true;
//                    IsSignOut=false;
//                  });},
//                  height: 40,
//                  textColor: Colors.white,
//                  color: Colors.red,
//                  child: new Text("Sign Out",style: TextStyle(color: Colors.white,fontSize: 18)),
//                ),
//              ),
//              visible: IsSignOut,
//            ),
//            Padding(padding: EdgeInsets.only(top: 10)),
//            Visibility(child:
//
//            Column(
//              children: [
//                Center(child: Image(image: NetworkImage(Profile)),),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Padding(padding: EdgeInsets.only(top: 50)),
//                    Text("Name : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
//                    Text(name,style: TextStyle(fontSize: 18)),
//                  ],
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Padding(padding: EdgeInsets.only(top: 20)),
//                    Text("Email : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
//                    Text(email,style: TextStyle(fontSize: 18)),
//                  ],
//                ),
//
//              ],
//            ),
//              visible: IsSignOut,
//            ),
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                new Text(_message),
//                new RaisedButton(
//                  onPressed: _login,
//                  child: new Text('Log in with Facebook'),
//                ),
//                new RaisedButton(
//                  onPressed: _logOut,
//                  child: new Text('Logout'),
//                ),
//              ],
//            ),
                  ],

                ),)

              )
          ),),),
        )
    );

  }
  void _showScaffoldRed(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(duration: const Duration(seconds: 1),
      content: Text(
          message, textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18)),
      backgroundColor: Colors.red,
    ));
  }


}
