import 'package:ecommerce_arabic/provider/adminMode.dart';
import 'package:ecommerce_arabic/provider/cartItem.dart';
import 'package:ecommerce_arabic/provider/modelhud.dart';
import 'package:ecommerce_arabic/screens/add_product_page.dart';
import 'package:ecommerce_arabic/screens/admin_home_page.dart';
import 'package:ecommerce_arabic/screens/cart_page.dart';
import 'package:ecommerce_arabic/screens/edit_product_page.dart';
import 'package:ecommerce_arabic/screens/home_page.dart';
import 'package:ecommerce_arabic/screens/login_page.dart';
import 'package:ecommerce_arabic/screens/order_page.dart';
import 'package:ecommerce_arabic/screens/productinfo_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_arabic/screens/signup_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          OrderScreen.id: (context) => OrderScreen(),
          CartScreen.id: (context) => CartScreen(),
          ProductInfoScreen.id: (context) => ProductInfoScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          AdminHomeScreen.id: (context) => AdminHomeScreen(),
          AddProductScreen.id: (context) => AddProductScreen(),
          EditScreen.id: (context) => EditScreen()
        },
      ),
    );
  }
}
