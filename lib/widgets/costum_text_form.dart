import 'package:flutter/material.dart';

class CustomTextFormWidget extends StatelessWidget {
  final String hint, label;
  final IconData iconData;
  final bool obscureText;
  final Function onChanged;
  final Function onSaved;
  final Color backgroundColor, textColor, iconColor;
  final String initialText;
  final TextEditingController controller;
  const CustomTextFormWidget(
      {Key key,
      @required this.hint,
      @required this.label,
      @required this.iconData,
      @required this.obscureText,
      @required this.onChanged,
      @required this.onSaved,
      @required this.initialText,
      @required this.backgroundColor,
      @required this.textColor,
      this.iconColor,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onChanged: onChanged,
        onSaved: onSaved,
        validator: (value) {
          if (hint == 'enter your Email') {
            if (value.isEmpty) {
              return 'Email is Empty';
            }
          } else if (hint == 'enter your Password') {
            if (value.isEmpty) {
              return 'Password is Empty';
            } else if (value.length + 1 <= 6) {
              return 'Password is less than 6 items';
            }
          } else if (hint == 'enter your name') {
            if (value.isEmpty) {
              return 'Name is Empty';
            }
          } else if (hint == 'Product Name') {
            if (value.isEmpty) {
              return 'Product Name is Empty';
            }
          } else if (hint == 'Product Price') {
            if (value.isEmpty) {
              return 'Product Price is Empty';
            }
          } else if (hint == 'Product Description') {
            if (value.isEmpty) {
              return 'Product Description is Empty';
            }
          } else if (hint == 'Product Category') {
            if (value.isEmpty) {
              return 'Product Category is Empty';
            }
          }
          return null;
          // if (value.isEmpty) {
          //   return 'Value is Empty';
          // } else {
          //   return null;
          // }
        },
        keyboardType:hint =='Product Description\n'? TextInputType.multiline:null,
        // maxLines: hint =='Product Description'?null:,
        obscureText: obscureText,
        // cursorColor: ,
        initialValue: initialText,
        controller: controller,
        decoration: InputDecoration(
          fillColor: backgroundColor,
          filled: true,
          labelText: label,
          labelStyle: TextStyle(color: textColor),
          hintText: hint,
          hintStyle: TextStyle(color: textColor),
          prefixIcon: Icon(
            iconData,
            color: iconColor,
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColor),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColor),
            borderRadius: BorderRadius.circular(20),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColor),
            borderRadius: BorderRadius.circular(20),
          ),

          ///error border
          border: OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColor),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
