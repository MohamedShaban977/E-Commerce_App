import 'package:e_commerce/constans.dart';
import 'package:e_commerce/screens/register_screens/login_screen.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Auth _auth = Auth();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //
  // getUserDataIsSherPerf() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     perfName = preferences.getString(kUserName);
  //     perfEmail = preferences.getString(kUserEmail);
  //   });
  // }
  //
  // getUserDataIsFirebase() {
  //   _firebaseAuth.authStateChanges().listen((User user) {
  //     if (user == null) {
  //       print('OnUser');
  //     } else {
  //       print("user");
  //       // final name= user.displayName('');
  //       setState(() {
  //         email = user.email;
  //         name = user.displayName;
  //         image = user.photoURL;
  //       });
  //
  //       print(user.email);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        // appBar: AppBar(),
        body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Row(
                  children: [CircularProgressIndicator(), Text('Loading...')],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              snapshot.data.getString(kUserImage) != null
                                  ? NetworkImage(
                                      snapshot.data.getString(kUserImage))
                                  : null,
                          backgroundColor: kScandColor,
                          radius: 60,
                          child: Center(
                            child: snapshot.data.getString(kUserImage) == null
                                ? Icon(
                                    Icons.person,
                                    size: 110,
                                    color: kMainColor,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kScandColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                snapshot.data.getString(kUserName) != null
                                    ? snapshot.data.getString(kUserName)
                                    : '',
                                style:
                                    TextStyle(color: kMainColor, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kScandColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                snapshot.data.getString(kUserEmail) ?? '',
                                style:
                                    TextStyle(color: kMainColor, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 55,
                        width: 200,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: kScandColor,
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Logout',
                                style:
                                    TextStyle(color: kMainColor, fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.logout,
                                size: 30,
                                color: kMainColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
