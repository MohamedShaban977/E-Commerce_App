import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constans.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<UserCredential> signUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<UserCredential> signUpGuest() async {
    final authResult = await _auth.signInAnonymously();

    print(authResult.user);

    return authResult;
  }

  Future<UserCredential> signOut() async {
    // await _googleSignIn.disconnect();
    // await _facebookLogin.logOut();

    await _auth.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(kUserName);
    preferences.remove(kUserEmail);
    preferences.remove(kUserImage);
  }

  Future signInWithGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return;
    } else {
      GoogleSignInAuthentication signInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: signInAuthentication.idToken,
          accessToken: signInAuthentication.accessToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(authCredential);

      savePrefUser(userCredential.user.displayName, userCredential.user.email,
          userCredential.user.photoURL);

      return userCredential;
    }
  }

  // signOutGoogle() async {
  //   await _googleSignIn.disconnect();
  //   _auth.signOut();
  // }
  Future signInWithFacebook() async {
    // _facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

    var result = await _facebookLogin.logIn(['email', 'public_profile']);
    FacebookAccessToken myToken = result.accessToken;
    AuthCredential credential = FacebookAuthProvider.credential(myToken.token);
    var firebaseUser =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // createProfile(user);
    return firebaseUser;
    // savePrefUser(userCredential.user.displayName, userCredential.user.email,
    //     userCredential.user.photoURL);
    // print(userCredential);
    // return userCredential;
  }

  savePrefUser(name, email, image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(kUserName, name);
    preferences.setString(kUserEmail, email);
    preferences.setString(kUserImage, image);

    print('preferences Name' + preferences.getString(kUserName));
    print('preferences Email' + preferences.getString(kUserEmail));
  }

  Future<User> getUser() async {
    return await _auth.currentUser;
  }

// class SignInGoogleProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   bool _isSignIn;
//   bool get isSignIn => _isSignIn;
//
//   set isSignIn(bool value) {
//     _isSignIn = value;
//     notifyListeners();
//   }
//
//   Future signInWithGoogle() async {
//     isSignIn = true;
//     final googleSignInAccount = await googleSignIn.signIn();
//     if (googleSignInAccount == null) {
//       isSignIn = false;
//       return;
//     } else {
//       GoogleSignInAuthentication signInAuthentication =
//           await googleSignInAccount.authentication;
//
//       AuthCredential authCredential = GoogleAuthProvider.credential(
//           idToken: signInAuthentication.idToken,
//           accessToken: signInAuthentication.accessToken);
//       UserCredential userCredential =
//           await _auth.signInWithCredential(authCredential);
//       print(userCredential.user.email);
//
//       isSignIn = false;
//     }
//   }
//
//   signUotGoogle() async {
//     await googleSignIn.disconnect();
//     _auth.signOut();
//   }
// }
}
