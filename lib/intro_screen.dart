import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/register_screens/login_screen.dart';
import 'screens/user_screens/home_screen.dart';

class IntroScreen extends StatefulWidget {
  static String id = 'IntroScreen';
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _firebaseAuth.authStateChanges().listen((User user) {
      if (user == null) {
        print('OnUser');
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      } else {
        print("user");
        // final name= user.displayName('');
        print(user);

        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
