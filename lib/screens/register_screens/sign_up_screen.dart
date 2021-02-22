import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/screens/user_screens/home_screen.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widgets/costum_text_form.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constans.dart';
import 'login_user_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name, _email, _password;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final Auth auth = Auth();

  bool checkBox = false;

  savePrefUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(kUserName, _name);
    preferences.setString(kUserEmail, _email);
    preferences.setString(kUserPassword, _password);
    preferences.setBool(kUserChecked, checkBox);

    print('preferences Name' + preferences.getString(kUserName));
    print('preferences Email' + preferences.getString(kUserEmail));
    print('preferences Password' + preferences.getString(kUserPassword));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
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
              Container(
                height: heightLocal,
                decoration: BoxDecoration(
                  color: kScandColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(heightLocal, heightLocal),
                    bottomRight: Radius.elliptical(heightLocal, heightLocal),
                  ),
                ),
                child: Form(
                  key: _globalKey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: widthLocal * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Sign Up  ',
                          style: TextStyle(
                              fontFamily: 'pacifico',
                              fontSize: widthLocal * 0.1,
                              color: Color(0xffE5B669)),
                          textAlign: TextAlign.center,
                        ),
                        // CustomLogoWidget(height: height * 0.2, width: width),
                        // SizedBox(height: height * 0.01),
                        SizedBox(height: height * 0.01),

                        ///' name'
                        CustomTextFormWidget(
                          backgroundColor: kBackgroundColor,
                          fontSize: widthLocal * 0.04,
                          textColor: kScandColor.withOpacity(0.5),
                          iconColor: kScandColor.withOpacity(0.5),
                          onChanged: (value) {
                            _name = value;
                          },
                          obscureText: false,
                          // label: 'enter your name',
                          hint: 'enter your name',
                          iconData: Icons.person,
                        ),
                        // SizedBox(height: height * 0.02),

                        /// ' Email'
                        CustomTextFormWidget(
                          backgroundColor: kBackgroundColor,
                          fontSize: widthLocal * 0.04,
                          textColor: kScandColor.withOpacity(0.5),
                          iconColor: kScandColor.withOpacity(0.5),
                          onChanged: (value) {
                            _email = value;
                          },
                          obscureText: false,
                          // label: 'enter your name',
                          hint: 'enter your Email',
                          iconData: Icons.email,
                        ),
                        // SizedBox(height: height * 0.02),

                        ///Password
                        CustomTextFormWidget(
                          backgroundColor: kBackgroundColor,
                          fontSize: widthLocal * 0.04,
                          textColor: kScandColor.withOpacity(0.5),
                          iconColor: kScandColor.withOpacity(0.5),
                          onChanged: (value) {
                            _password = value;
                          },
                          obscureText: true,
                          // label: 'enter your name',
                          hint: 'enter your Password',
                          iconData: Icons.lock,
                        ),
                        // SizedBox(height: height * 0.02),

                        Row(
                          children: [
                            Transform.scale(
                              scale: widthLocal * 0.0025,
                              child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: Checkbox(
                                    checkColor: kScandColor,
                                    activeColor: Colors.white,
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
                        // SizedBox(height: height * 0.02),

                        /// Sign Up Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ButtonCustomWidget(
                            fontSize: widthLocal * 0.04,
                            textColor: kScandColor,
                            backgroundColor: kMainColor,
                            textbutton: 'Sign Up',
                            onPressed: () async {
                              final modelHud =
                                  Provider.of<ModelHud>(context, listen: false);
                              modelHud.changeIsLoading(true);
                              if (_globalKey.currentState.validate()) {
                                if (checkBox == true) {
                                  await savePrefUser();
                                }

                                ///
                                try {
                                  ///do something
                                  final authResult = await auth.signUp(
                                      _email.trim(), _password.trim());
                                  modelHud.changeIsLoading(false);

                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.id);
                                  print(authResult.user.email);
                                  print(authResult.user.uid);

                                  ///
                                } catch (ex) {
                                  modelHud.changeIsLoading(false);

                                  var showToast = Fluttertoast.showToast(
                                    msg: ex.message.toString(),
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    timeInSecForIosWeb: 5,
                                    fontSize: 18,
                                  );
                                  return showToast;
                                }
                              }
                              modelHud.changeIsLoading(false);
                            },
                          ),
                        ),
                        // SizedBox(height: height * 0.03),

                        ///Text( Do have an account ?)
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginUserScreen.id);
                          },
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Do have an account? ',
                                style: TextStyle(
                                    fontSize: widthLocal * 0.04,
                                    color: Colors.white),
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: widthLocal * 0.04,
                                    color: kMainColor),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.03),
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
        children: [
          Text(
            'Sign Up  ',
            style: TextStyle(
                fontFamily: 'pacifico', fontSize: 50, color: Color(0xffE5B669)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.02),
          CircleAvatar(
              child: Image.asset(
                'images/led.png',
                height: 150,
                color: Colors.black87,
              ),
              backgroundColor: Colors.white,
              radius: 90),
        ],
      ),
    );
  }
}
