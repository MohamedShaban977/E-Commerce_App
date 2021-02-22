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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: kScandColor,
        // iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: LayoutBuilder(builder: (context, con) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          final heightLocal = con.maxHeight;
          final widthLocal = con.maxWidth;
          return ListView(
            children: [
              Form(
                key: _globalKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: kScandColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(heightLocal, heightLocal),
                      bottomRight: Radius.elliptical(heightLocal, heightLocal),
                    ),
                  ),
                  height: heightLocal,
                  //     myAppBar.preferredSize.height -
                  //     MediaQuery.of(context).padding.top,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: widthLocal * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.s,
                      children: [
                        SizedBox(height: heightLocal * 0.03),

                        Text(
                          'Login  ',
                          style: TextStyle(
                            fontFamily: 'pacifico',
                            fontSize: widthLocal * 0.1,
                            color: Color(0xffE5B669),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        /// Email
                        CustomTextFormWidget(
                          fontSize: widthLocal * 0.04,
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
                        // SizedBox(height: heightLocal * 0.02),

                        /// Password
                        CustomTextFormWidget(
                          fontSize: widthLocal * 0.04,

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
                        Row(
                          children: [
                            Transform.scale(
                              // height: heightLocal * 0.04,
                              // width: widthLocal * 0.04,
                              scale: widthLocal * 0.0025,
                              child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: Checkbox(
                                    checkColor: kScandColor,
                                    activeColor: Colors.white,
                                    hoverColor: Colors.white,
                                    value: checkBox,
                                    onChanged: (value) {
                                      setState(() {
                                        checkBox = value;
                                      });
                                    }),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widthLocal * 0.04),
                              child: Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: widthLocal * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: heightLocal * 0.03),
                        ButtonCustomWidget(
                            fontSize: widthLocal * 0.04,
                            textColor: Colors.black,
                            backgroundColor: Color(0xffE5B669),
                            textbutton: 'Login',
                            onPressed: () {
                              if (checkBox == true) {
                                savePrefUser();
                              }
                              _validate(context);
                            }),
                        // SizedBox(height: height * 0.03),
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
                                    fontSize: widthLocal * 0.04,
                                    color: Color(0xffFFC66D)),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(height: height * 0.04),

                        Row(
                          children: [
                            Expanded(
                              child: FlatButton(
                                // color: Color(0xffE5B669),
                                onPressed: () {
                                  Provider.of<AdminMode>(context, listen: false)
                                      .changeIsAdmin(true);
                                },
                                child: Text(
                                  'I\'m an Admin',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: widthLocal * 0.04,
                                      color: Provider.of<AdminMode>(context)
                                              .isAdmin
                                          ? kScandColor.withOpacity(0.0)
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
                                  'I\'m an User',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: widthLocal * 0.04,
                                      color: Provider.of<AdminMode>(context)
                                              .isAdmin
                                          ? Color(0xffE5B669)
                                          : kScandColor.withOpacity(0.0)),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.04),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
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
