import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myNews/utils/sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommonSocialLogin{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  sharedpreferences spv=new sharedpreferences();
  CommonSocialLogin(){

  }

  Future<bool> GoogleLogin() async{
    final GoogleSignInAccount googleSignInAccount = await spv.googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('signInWithGoogle succeeded: $user');
    prefs.setBool("IsLogin", true);
    prefs.setBool("IsSocialLogin", true);
    prefs.setString("email", googleSignInAccount.email);
    prefs.setString("name", user.displayName);
    prefs.setString("profile", user.photoURL);
    print(googleSignInAccount.email);
    return true;
    }
    return false;
  }

  Future<bool> FacebookLogin(FacebookLoginResult result) async{
    try{
      final FacebookAccessToken accessToken = result.accessToken;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${result.accessToken.token}');
      final profile = jsonDecode(graphResponse.body);
      final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;
      print(user.email);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("IsLogin", true);
      prefs.setBool("IsSocialLogin", true);
      prefs.setString("email", profile["email"]);
      prefs.setString("name", profile["name"]);
      prefs.setString("profile", profile["picture"]["data"]["url"]);
      return true;
    }catch(e){
      return false;
    }
  }
}