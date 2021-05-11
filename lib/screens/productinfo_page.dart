import 'package:ecommerce_arabic/constants.dart';
import 'package:ecommerce_arabic/models/product.dart';
import 'package:ecommerce_arabic/provider/cartItem.dart';
import 'package:ecommerce_arabic/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfoScreen extends StatefulWidget {
  static String id = 'ProductInfoScreen';
  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  int _qty = 0;
  @override
  Widget build(BuildContext context) {
    Product products = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image(image: AssetImage("images/buy.png"))),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Container(
            height: MediaQuery.of(context).size.height * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios)),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: Icon(Icons.shopping_basket))
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Column(children: [
            Opacity(
              opacity: 0.7,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(products.pNme,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(products.pCategory,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Material(
                              color: kmainColor,
                              child: GestureDetector(
                                onTap: add,
                                child: SizedBox(
                                  child: Icon(Icons.add),
                                  height: 32,
                                  width: 32,
                                ),
                              ),
                            ),
                          ),
                          Text(_qty.toString(),
                              style: TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold)),
                          ClipOval(
                            child: Material(
                              color: kmainColor,
                              child: GestureDetector(
                                onTap: subtract,
                                child: SizedBox(
                                  child: Icon(Icons.remove),
                                  height: 32,
                                  width: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .1,
              child: Builder(
                builder: (context) => RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  onPressed: () {
                    addToCart(context, products);
                  },
                  color: kmainColor,
                  child: Text(
                    'Add to Cart'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ]),
        )
      ]),
    );
  }

  void add() {
    setState(() {
      _qty++;
    });
  }

  void subtract() {
    if (_qty > 0) {
      setState(() {
        _qty--;
      });
    }
  }

  void addToCart(context, Product product) {
    product.pQty = _qty;
    List<Product> cart_products =
        Provider.of<CartItem>(context, listen: false).products;
    bool exists = false;
    for (var prod in cart_products) {
      if (product.pNme == prod.pNme) {
        exists = true;
      }
    }
    if (exists) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Sorry! Already Added to the Cart')));
    } else {
      Provider.of<CartItem>(context, listen: false).addProduct(product);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Added to Cart')));
    }
  }
}
