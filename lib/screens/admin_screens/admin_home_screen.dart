import 'package:e_commerce/constans.dart';
import 'add/add_producr_screen.dart';
import 'edit/List_product_screen.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:flutter/material.dart';

import 'order/order_screen.dart';

class AdminScreen extends StatelessWidget {
  static String id = 'AdminScreen';
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, con) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final heightLocal = con.maxHeight;
      final widthLocal = con.maxWidth;
      return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black87),
          elevation: 0.0,
          title: Text(
            ' Admin ',
            style:
                TextStyle(fontSize: widthLocal * 0.04, color: Colors.black87),
          ),
        ),
        // backgroundColor: Color(0xff020D4D),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustomWidget(
                fontSize: widthLocal * 0.04,
                onPressed: () {
                  Navigator.pushNamed(context, AddProduct.id);
                },
                textbutton: 'Add Product',
                backgroundColor: kMainColor,
                textColor: kScandColor,
              ),
              SizedBox(height: heightLocal * 0.08),
              ButtonCustomWidget(
                fontSize: widthLocal * 0.04,
                onPressed: () {
                  Navigator.pushNamed(context, ListProductScreen.id);
                },
                textbutton: 'List Product',
                backgroundColor: kMainColor,
                textColor: kScandColor,
              ),
              SizedBox(height: heightLocal * 0.08),
              ButtonCustomWidget(
                fontSize: widthLocal * 0.04,
                onPressed: () {
                  Navigator.pushNamed(context, OrderScreen.id);
                },
                textbutton: 'View Orders',
                backgroundColor: kMainColor,
                textColor: kScandColor,
              ),
            ],
          ),
        ),
      );
    });
  }
}
