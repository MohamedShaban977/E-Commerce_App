import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
  final String textbutton;
  final Function onPressed;
  final Color backgroundColor, textColor;
  const ButtonCustomWidget(
      {@required this.textbutton,
      @required this.onPressed,
      @required this.backgroundColor,
      @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          textbutton,
          style: TextStyle(color: textColor, fontSize: 20, letterSpacing: 1),
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: backgroundColor,
      ),
    );
  }
}
