import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
  final String textbutton;
  final double fontSize;
  final Function onPressed;
  final Color backgroundColor, textColor;
  const ButtonCustomWidget(
      {@required this.textbutton,
      @required this.onPressed,
      @required this.backgroundColor,
      @required this.textColor,
      @required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      width: double.infinity,
      child: RaisedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textbutton,
            style: TextStyle(
                color: textColor, fontSize: fontSize, letterSpacing: 1),
            textAlign: TextAlign.center,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: backgroundColor,
      ),
    );
  }
}
