import 'package:e_commerce/provider/adminMode.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/screens/admin_screens/admin_home_screen.dart';
import 'package:e_commerce/screens/user_screens/home_screen.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widgets/costum_text_form.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:e_commerce/widgets/weve.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constans.dart';
import 'sign_up_screen.dart';

class LoginUserScreen extends StatefulWidget {
  static String id = 'LoginUserScreen';

  @override
  _LoginUserScreenState createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  String _email, _password;
  bool checkBox = false;

  final adminPassword = 'admin1234';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: ListView(
          children: [
            CustomLogoWidget(height: height, width: width),
            Form(
              key: _globalKey,
              child: Container(
                child: Column(
                  children: [
                    // CustomWeve(
                    //   size: height * 0.0033,
                    // ),

                    SizedBox(height: height * 0.03),

                    /// Email
                    CustomTextFormWidget(
                      backgroundColor: Color(0xffF5E2C3),
                      textColor: Colors.black45,
                      iconColor: Color(0xffE5B669),
                      onChanged: (value) {
                        _email = value;
                      },
                      obscureText: false,
                      // label: 'enter your name',
                      hint: 'enter your Email',
                      iconData: Icons.email,
                    ),
                    SizedBox(height: height * 0.02),

                    /// Password
                    CustomTextFormWidget(
                      backgroundColor: Color(0xffF5E2C3),
                      textColor: Colors.black45,
                      iconColor: Color(0xffE5B669),
                      onChanged: (value) {
                        _password = value;
                      },
                      obscureText: true,
                      // label: 'enter your name',
                      hint: 'enter your Password',
                      iconData: Icons.lock,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Checkbox(
                              checkColor: kMainColor,
                              activeColor: kScandColor,
                              value: checkBox,
                              onChanged: (value) {
                                setState(() {
                                  checkBox = value;
                                });
                              }),
                          Text('Remember me  ')
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ButtonCustomWidget(
                          textColor: Colors.black,
                          backgroundColor: Color(0xffE5B669),
                          textbutton: 'Login',
                          onPressed: () {
                            if (checkBox == true) {
                              savePrefUser();
                            }
                            _validate(context);
                          }

                          //     () async {
                          //   final modelHud =
                          //       Provider.of<ModelHud>(context, listen: false);
                          //
                          //   modelHud.changeIsLoading(true);
                          //
                          //   if (_globalKey.currentState.validate()) {
                          //     try {
                          //       /// do something
                          //       final authResult =
                          //           await auth.signIn(_email, _password);
                          //
                          //       modelHud.changeIsLoading(false);
                          //
                          //       print('sign in ' + authResult.user.uid);
                          //       print('sign in ' + authResult.user.email);
                          //
                          //       Navigator.pushNamed(context, HomeScreen.id);
                          //
                          //       ///
                          //     } catch (ex) {
                          //       modelHud.changeIsLoading(false);
                          //
                          //       var showToast = Fluttertoast.showToast(
                          //           msg: ex.message.toString(),
                          //           toastLength: Toast.LENGTH_LONG,
                          //           gravity: ToastGravity.BOTTOM,
                          //           backgroundColor: Colors.white,
                          //           textColor: Colors.black,
                          //           timeInSecForIosWeb: 5,
                          //           fontSize: 18);
                          //       return showToast;
                          //     }
                          //   }
                          //   modelHud.changeIsLoading(false);
                          // },
                          ),
                    ),
                    SizedBox(height: height * 0.03),
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
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                          Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xffFFC66D)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.04),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              // color: Color(0xffE5B669),
                              onPressed: () {
                                Provider.of<AdminMode>(context, listen: false)
                                    .changeIsAdmin(true);
                              },
                              child: Text(
                                'i\'m an Admin ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        Provider.of<AdminMode>(context).isAdmin
                                            ? Colors.white
                                            : Color(0xffE5B669)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                Provider.of<AdminMode>(context, listen: false)
                                    .changeIsAdmin(false);
                              },
                              child: Text(
                                'i\'m an User ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        Provider.of<AdminMode>(context).isAdmin
                                            ? Color(0xffE5B669)
                                            : Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  savePrefUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(kUserEmail, _email);
    preferences.setString(kUserPassword, _password);
    preferences.setBool(kUserChecked, checkBox);

    print('preferences Login Email' + preferences.getString(kUserEmail));
    print('preferences Login Password' + preferences.getString(kUserPassword));
  }

  _validate(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);

    if (_globalKey.currentState.validate()) {
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminScreen.id);
          } catch (ex) {
            print(ex);
            modelHud.changeIsLoading(false);
            var showToast = Fluttertoast.showToast(
                msg: ex.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                timeInSecForIosWeb: 5,
                fontSize: 18);
            return showToast;
          }
        } else {
          modelHud.changeIsLoading(false);

          Fluttertoast.showToast(
              msg: 'Something Went Wrong ! ',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5,
              fontSize: 18);
        }
      } else {
        try {
          await auth.signIn(_email, _password);
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        } catch (ex) {
          print(ex);
          modelHud.changeIsLoading(false);
          var showToast = Fluttertoast.showToast(
              msg: ex.message.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5,
              fontSize: 18);
          return showToast;
        }
      }
    }
    modelHud.changeIsLoading(false);
  }
}

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(500, 500),
          bottomRight: Radius.elliptical(500, 500),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Login  ',
            style: TextStyle(
              fontFamily: 'pacifico',
              fontSize: 50,
              color: Color(0xffE5B669),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.01),
          CircleAvatar(
              child: Image.asset(
                'images/led.png',
                height: 150,
                color: Colors.black87,
              ),
              backgroundColor: Colors.white,
              radius: 90
              // backgroundImage: AssetImage('images/led.png'),
              ),
        ],
      ),
    );
  }
}
