import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:myNews/SignupPage.dart';
import 'package:myNews/note_list.dart';
import 'package:myNews/utils/sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Components/AppTextFormField.dart';
import 'Components/CommonSocialLogin.dart';
import 'Components/Socialbtn.dart';

class SignupPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignupPage();
  }

}

class _SignupPage extends State<SignupPage> {
  DatabaseReference ref;

  var _formKey=GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  sharedpreferences spv=new sharedpreferences();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  CommonSocialLogin cm=new CommonSocialLogin();
  bool IsSignIn=true;
  bool IsSignOut=false;
  String name="";
  String email="";
  String password="";
  String Profile="";
  bool isChecked=false;

  TextEditingController _userName=new TextEditingController();
  TextEditingController _email=new TextEditingController();
  TextEditingController _password=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseDatabase _database = FirebaseDatabase.instance;
    ref=_database.reference().child("UserInfo");

  }
  void _BtnSignUpClick() async{
    if(_formKey.currentState.validate()){
      try{
        _formKey.currentState.save();
        print(email+"  "+password+"  "+name);
        var user= await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print("User ${user.user.email}");
        _formKey.currentState.reset();
        Navigator.pop(context);
      }
      catch(e){
        _showScaffoldRed("Email is already in use");
      }
    }
  }

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

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Signed Out");
  }
  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }


  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';



  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
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
    //Firebase.initializeApp();
    return Scaffold(
      key: _scaffoldKey,
        body:
        SafeArea(child: GestureDetector(
          onTap: () {

            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child:  Form(
          key: _formKey,
          child:Center(
              child:  SingleChildScrollView(child:
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text("Sign Up",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,foreground: Paint()..shader = linearGradient),),
                    SizedBox(height: 30,),

                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_box),
                        hintText: "Enter Username",
                      ),
                      validator: (String value){
                        if(value.isEmpty){
                          return "Please enter UserName";
                        }
                      },
                      onSaved: (value)=>name=value,
                      keyboardType:TextInputType.name,
                    ),
                    SizedBox(height: 15,),
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
                    SizedBox(height: 15,),
                    TextFormField(
                      validator: (String value){
                        if(value.isEmpty){
                          return "Please enter Password";
                        }
                        else if(value.length<6){
                          return "Password more than 5 characters";
                        }
                      },
                      onSaved: (value)=>password=value,
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

                      obscureText: !_showPassword,
                      keyboardType:TextInputType.text,
                    ),
//                    SizedBox(height: 10,),
//                    Row(
//
//                      children: [
//                        Checkbox(
//                          activeColor: Colors.blue,
//                          value: isChecked,
//                          onChanged: (bool value) {
//                            setState(() {
//                              this.isChecked = value;
//                            });
//                          },
//                        ),
//                        Text("I agree with privacy policy"),
//
//                      ],
//                    ),
                    SizedBox(height: 30,),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _BtnSignUpClick();
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
                              "Sign Up",
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

                        Socialbtn(
                          onPress: (){
                            signInWithGoogle();
                            },
                          icon: "assets/images/google.png",
                          width: 35.0,
                          height: 35.0,
                        ),
                        Container(height: 40, child: VerticalDivider(color: Colors.black)),

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
                        Text("You already have an account?",style: TextStyle(fontWeight: FontWeight.bold),),
                        GestureDetector(
                          onTap: () {
                            _formKey.currentState.reset();
                            Navigator.pop(context);
                          },
                          child: Text(" Login",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                        ),
                      ],),

                  ],

                ),)

              )
          ),),)
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
