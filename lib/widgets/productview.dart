import 'package:ecommerce_arabic/function.dart';
import 'package:ecommerce_arabic/models/product.dart';
import 'package:ecommerce_arabic/screens/productinfo_page.dart';
import 'package:flutter/material.dart';

Widget productView(List<Product> allProducts) {
  List<Product> products;
  products = getProductByCategory('Test2', allProducts);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: .7, crossAxisCount: 2),
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductInfoScreen.id,
              arguments: products[index]);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image(image: AssetImage('images/buy.png')),
            ),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: .6,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].pNme,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text('\$ ${products[index].pCategory}')
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    itemCount: products.length,
  );

  // return ListView.builder(
  //   itemBuilder: (context, index) =>
  //       Text(snapshot.data[index].pNme),
  //   itemCount: snapshot.data.length,
  // );
}
