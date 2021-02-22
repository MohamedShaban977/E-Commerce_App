import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/favorite_itme.dart';
import 'package:e_commerce/screens/user_screens/product_info_screen.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/storeDataBase.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constans.dart';
import 'cart_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'store_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = Auth();
  User _loggedUser;
  int index = 0;
  final tabs = [
    StoreScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrenUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavyBar(context),
      backgroundColor: Color(0xffF5E2C3),
      body: tabs[index],
    );
  }

  getCurrenUser() async {
    _loggedUser = (await _auth.getUser());
    // print(_loggedUser.email);
  }

  Widget CustomNavyBar(context) {
    return LayoutBuilder(builder: (context, con) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final heightLocal = con.maxHeight;
      final widthLocal = con.maxWidth;
      return BottomNavyBar(
        backgroundColor: Color(0xffF5E2C3),
        selectedIndex: index,
        showElevation: true,
        itemCornerRadius: widthLocal * 0.03,
        onItemSelected: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.storefront_sharp,
              color: Colors.orangeAccent,
            ),
            title: Text(
              'Store',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: widthLocal * 0.03,
                  fontWeight: FontWeight.bold),
            ),
            activeColor: Colors.orange,
            // inactiveColor: Colors.black87.withOpacity(0.8),
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.favorite),
              title: Text(
                'favorite',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: widthLocal * 0.03,
                    fontWeight: FontWeight.bold),
              ),
              activeColor: Color(0xffDB5758)),
          BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(
                'Cart',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: widthLocal * 0.03,
                    fontWeight: FontWeight.bold),
              ),
              activeColor: Colors.orange),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: widthLocal * 0.03,
                    fontWeight: FontWeight.bold),
              ),
              activeColor: Colors.black54),
        ],
      );
    });
  }
}
