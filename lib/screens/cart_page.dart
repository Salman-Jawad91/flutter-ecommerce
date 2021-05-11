//import 'dart:js';

import 'package:ecommerce_arabic/constants.dart';
import 'package:ecommerce_arabic/models/product.dart';
import 'package:ecommerce_arabic/provider/cartItem.dart';
import 'package:ecommerce_arabic/screens/productinfo_page.dart';
import 'package:ecommerce_arabic/services/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Column(children: [
        LayoutBuilder(
          builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight -
                    (screenHeight * .08) -
                    appBarHeight -
                    statusBarHeight,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        color: ksecondaryColor,
                        height: screenHeight * .15,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: screenHeight * .15 / 2,
                              backgroundImage: AssetImage("images/buy.png"),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(products[index].pCategory,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(products[index].pPrice,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(products[index].pQty.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Provider.of<CartItem>(context,
                                                  listen: false)
                                              .deleteProduct(products[index]);
                                          Navigator.pushNamed(
                                              context, ProductInfoScreen.id,
                                              arguments: products[index]);
                                        },
                                        child: Text('Edit',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Delete',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                height: screenHeight -
                    (screenHeight * .08) -
                    appBarHeight -
                    statusBarHeight,
                child: Center(
                  child: Text('Cart is Empty'),
                ),
              );
            }
          },
        ),
        Builder(
          builder: (context) => ButtonTheme(
            buttonColor: kmainColor,
            minWidth: screenWidth,
            height: screenHeight * .08,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              onPressed: () {
                showCustomDialg(products, context);
              },
              child: Text('Confirm'),
            ),
          ),
        )
      ]),
    );
  }

  void showCustomDialg(List<Product> products, context) async {
    var price = getTotalPrice(products);
    AlertDialog alertDialog = AlertDialog(
      title: Text('Total Price : \$ $price'),
      actions: <Widget>[
        MaterialButton(
          onPressed: () async {
            try {
              StoreProduct _store = StoreProduct();
              await _store.addOrders(products);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Added Orders Successfully!')));
              Navigator.pop(context);
            } catch (ex) {
              print(ex.message);
            }
          },
          child: Text('Confirm'),
        )
      ],
      content: TextField(
        decoration: InputDecoration(hintText: 'Enter your Address'),
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  int getTotalPrice(List<Product> products) {
    var total = 0;
    for (var prod in products) {
      total += prod.pQty;
    }
    return total;
  }
}
