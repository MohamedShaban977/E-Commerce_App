import 'package:e_commerce/constans.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/screens/register_screens/sign_up_screen.dart';
import 'package:e_commerce/screens/user_screens/home_screen.dart';
import 'package:e_commerce/services/auth.dart';
import '../../constans.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:e_commerce/widgets/show_massage_toast_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'login_user_screen.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';

  final auth = Auth();
  final showMassage = ShowMassageInUser();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int randomNumber = random.nextInt(10000); // f

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      // appBar: AppBar(
      //   backgroundColor: kScandColor,
      //   elevation: 0.0,
      //   // shadowColor: Colors.transparent,
      // ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: LayoutBuilder(builder: (context, con) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          final heightLocal = con.maxHeight;
          final widthLocal = con.maxWidth;
          return Container(
            // height: height * 0.9,
            decoration: BoxDecoration(
              color: kScandColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(heightLocal, heightLocal),
                bottomRight: Radius.elliptical(heightLocal, heightLocal),
              ),
            ),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: heightLocal * 0.05),

                    Image.asset(
                      'images/logo4.png',
                    ),
                    SizedBox(height: heightLocal * 0.05),

                    ///button login
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthLocal * 0.1),
                      child: ButtonCustomWidget(
                        fontSize: widthLocal * 0.04,
                        textColor: Colors.black,
                        backgroundColor: kMainColor,
                        textbutton: 'Login ',
                        onPressed: () {
                          Navigator.pushNamed(context, LoginUserScreen.id);
                        },
                      ),
                    ),
                    SizedBox(height: heightLocal * 0.05),
                    // SizedBox(height: height * 0.015),

                    ///  'Don\'t have an account ?
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ? ',
                            style: TextStyle(
                                fontSize: widthLocal * 0.04,
                                color: Colors.white),
                          ),
                          Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: widthLocal * 0.04, color: kMainColor),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: heightLocal * 0.05),

                    ///Login Phone
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                    //   child: ButtonCustomWidget(
                    //     textColor: Colors.white,
                    //     backgroundColor: Colors.pinkAccent,
                    //     textbutton: 'Login Phone',
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, LoginPhone.id);
                    //     },
                    //   ),
                    // ),
                    // SizedBox(height: height * 0.015),

                    /// Login Guest User
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthLocal * 0.2),
                      child: ButtonCustomWidget(
                        fontSize: widthLocal * 0.04,
                        textColor: Colors.black,
                        backgroundColor: kMainColor,
                        textbutton: 'Login Guest User ',
                        onPressed: () async {
                          auth.signUpGuest();
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setString(
                              kUserEmail, 'guest_user$randomNumber@guest.com');

                          preferences.setString(
                              kUserName, 'guestUser$randomNumber');
                          preferences.setBool(kUserChecked, true);

                          print('preferences Login Email' +
                              preferences.getString(kUserEmail));
                          print('preferences Login Name' +
                              preferences.getString(kUserName));

                          Navigator.pushNamed(context, HomeScreen.id);
                        },
                      ),
                    ),
                    SizedBox(height: heightLocal * 0.05),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///  google &facebook
                        IconButton(
                            icon: Image.asset(
                              'images/google.png',
                            ),
                            iconSize: widthLocal * 0.06,
                            onPressed: () async {
                              final modelHud =
                                  Provider.of<ModelHud>(context, listen: false);
                              modelHud.changeIsLoading(true);

                              try {
                                final user = await auth.signInWithGoogle();
                                if (user == null) {
                                  modelHud.changeIsLoading(false);

                                  return showMassage.show_toast(
                                      'Please select Google Email', 5);
                                } else if (user != null) {
                                  isChecked = true;
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setBool(kUserChecked, isChecked);
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.id);
                                }
                              } catch (ex) {
                                modelHud.changeIsLoading(false);
                                return showMassage.show_toast(ex.toString(), 5);
                              }
                              modelHud.changeIsLoading(false);
                            }),
                        SizedBox(width: widthLocal * 0.05),
                        IconButton(
                            icon: Image.asset(
                              'images/facebook.png',
                            ),
                            iconSize: widthLocal * 0.06,
                            onPressed: () async {
                              final modelHud =
                                  Provider.of<ModelHud>(context, listen: false);
                              modelHud.changeIsLoading(true);

                              try {
                                final user = await auth.signInWithFacebook();
                                if (user == null) {
                                  modelHud.changeIsLoading(false);

                                  return showMassage.show_toast(
                                      'Please Enter Facebook Email', 5);
                                } else if (user != null) {
                                  isChecked = true;
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setBool(kUserChecked, isChecked);
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.id);
                                }
                              } catch (ex) {
                                modelHud.changeIsLoading(false);
                                return showMassage.show_toast(ex.toString(), 5);
                              }
                              modelHud.changeIsLoading(false);
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
