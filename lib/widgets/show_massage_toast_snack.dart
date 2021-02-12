import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowMassageInUser {
  void showSnackBar(BuildContext context, String text, int durationSecond) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: durationSecond),
    ));
  }

  Future<bool> show_toast(String massage, int time) {
    var showToast = Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        timeInSecForIosWeb: time,
        fontSize: 18);
    return showToast;
  }
}
