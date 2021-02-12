import 'package:device_preview/device_preview.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/provider/adminMode.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'file:///F:/Android/FlutterProjects/e_commerce/lib/screens/admin_screens/add/add_producr_screen.dart';
import 'package:e_commerce/screens/admin_screens/admin_home_screen.dart';
import 'package:e_commerce/screens/admin_screens/order/order_details_screen.dart';
import 'file:///F:/Android/FlutterProjects/e_commerce/lib/screens/admin_screens/edit/edit_product_screen.dart';
import 'file:///F:/Android/FlutterProjects/e_commerce/lib/screens/admin_screens/edit/List_product_screen.dart';
import 'package:e_commerce/screens/register_screens/login_phone_screen.dart';
import 'package:e_commerce/screens/register_screens/sign_up_screen.dart';
import 'package:e_commerce/screens/user_screens/product_info_screen.dart';
import 'package:e_commerce/services/storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro_screen.dart';
import 'provider/favorite_itme.dart';
import 'screens/admin_screens/order/order_screen.dart';
import 'screens/register_screens/login_screen.dart';
import 'screens/register_screens/login_user_screen.dart';
import 'screens/user_screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    builder: (context) => MyApp(),
  )
      // MyApp()
      );
}

class MyApp extends StatelessWidget {
  bool userIsLogin = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Row(
                    children: [
                      Text('Loading...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            userIsLogin = snapshot.data.getBool(kUserChecked) ?? false;

            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(
                    create: (context) => ModelHud()),
                ChangeNotifierProvider<AdminMode>(
                    create: (context) => AdminMode()),
                ChangeNotifierProvider<StorageImage>(
                    create: (context) => StorageImage()),
                ChangeNotifierProvider<CartItem>(
                    create: (context) => CartItem()),
                ChangeNotifierProvider<FavoriteItem>(
                    create: (context) => FavoriteItem()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Real Art',
                initialRoute: userIsLogin ? HomeScreen.id : LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  LoginUserScreen.id: (context) => LoginUserScreen(),
                  SignUpScreen.id: (context) => SignUpScreen(),
                  LoginPhone.id: (context) => LoginPhone(),
                  HomeScreen.id: (context) => HomeScreen(),
                  AdminScreen.id: (context) => AdminScreen(),
                  AddProduct.id: (context) => AddProduct(),
                  ListProductScreen.id: (context) => ListProductScreen(),
                  EditProductScreen.id: (context) => EditProductScreen(),
                  ProductInfo.id: (context) => ProductInfo(),
                  IntroScreen.id: (context) => IntroScreen(),
                  OrderScreen.id: (context) => OrderScreen(),
                  OrderDetailsScreen.id: (context) => OrderDetailsScreen(),
                },
              ),
            );
          }
        });
  }
}
