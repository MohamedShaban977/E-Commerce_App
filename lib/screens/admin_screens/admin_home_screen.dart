import 'package:e_commerce/constans.dart';
import 'file:///F:/Android/FlutterProjects/e_commerce/lib/screens/admin_screens/add/add_producr_screen.dart';
import 'file:///F:/Android/FlutterProjects/e_commerce/lib/screens/admin_screens/edit/List_product_screen.dart';
import 'file:///F:/Android/FlutterProjects/e_commerce/lib/screens/admin_screens/order/order_screen.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  static String id = 'AdminScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text(' Admin '),
      ),
      // backgroundColor: Color(0xff020D4D),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonCustomWidget(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              textbutton: 'Add Product',
              backgroundColor: Color(0xffC34072),
              textColor: Colors.white,
            ),
            SizedBox(height: 30),
            ButtonCustomWidget(
              onPressed: () {
                Navigator.pushNamed(context, ListProductScreen.id);
              },
              textbutton: 'List Product',
              backgroundColor: Color(0xffC34072),
              textColor: Colors.white,
            ),
            SizedBox(height: 30),
            ButtonCustomWidget(
              onPressed: () {
                Navigator.pushNamed(context, OrderScreen.id);
              },
              textbutton: 'View Orders',
              backgroundColor: Color(0xffC34072),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
