import 'package:ecommerce_arabic/constants.dart';
import 'package:ecommerce_arabic/screens/add_product_page.dart';
import 'package:ecommerce_arabic/screens/edit_product_page.dart';
import 'package:ecommerce_arabic/screens/order_page.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  static String id = 'AdminHomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmainColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddProductScreen.id);
                },
                child: Text('Add Product')),
            RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditScreen.id);
                },
                child: Text('Edit Product')),
            RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, OrderScreen.id);
                },
                child: Text('Load Product'))
          ],
        ),
      ),
    );
  }
}
