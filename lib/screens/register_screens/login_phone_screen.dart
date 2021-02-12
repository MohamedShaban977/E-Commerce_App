import 'package:e_commerce/constans.dart';
import 'package:e_commerce/widgets/costum_text_form.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:e_commerce/widgets/weve.dart';
import 'package:flutter/material.dart';

class LoginPhone extends StatelessWidget {
  static String id = 'LoginPhone';

  String _phoneNumber;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          Form(
            key: _globalKey,
            child: Column(
              children: [
                CustomWeve(
                  size: height * 0.0033,
                ),
                CustomLogoWidget(height: height, width: width),
                SizedBox(height: height * 0.15),
                CustomTextFormWidget(
                  hint: 'enter Phone Number',
                  iconData: Icons.phone,
                  obscureText: false,
                  onChanged: (value) {
                    _phoneNumber = value;
                  },
                  backgroundColor: Colors.white,
                  textColor: Color(0xFFFF9592),
                  iconColor: Color(0xFFFF9592),
                ),
                SizedBox(height: height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ButtonCustomWidget(
                    textColor: Colors.white,
                    backgroundColor: Colors.pinkAccent,
                    textbutton: 'Login ',
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                        ///
                        /// do something
                        ///
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Login Phone  ',
                style: TextStyle(
                    fontFamily: 'pacifico', fontSize: 50, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height * 0.03),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('images/loginImage.png'),
            ),
          ],
        ),
        SizedBox(
          width: width * 0.1,
        ),
      ],
    );
  }
}
