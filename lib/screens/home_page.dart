import 'package:ecommerce_arabic/constants.dart';
import 'package:ecommerce_arabic/function.dart';
import 'package:ecommerce_arabic/models/product.dart';
import 'package:ecommerce_arabic/screens/productinfo_page.dart';
import 'package:ecommerce_arabic/services/store.dart';
import 'package:ecommerce_arabic/widgets/productview.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabarindex = 0;
  int _bottombarindex = 0;
  final _store = StoreProduct();
  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  fixedColor: kmainColor,
                  unselectedItemColor: kUnActiveColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _bottombarindex,
                  onTap: (value) {
                    setState(() {
                      _bottombarindex = value;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                        title: Text(
                          'Test',
                          style: TextStyle(color: kUnActiveColor),
                        ),
                        icon: Icon(Icons.person)),
                    BottomNavigationBarItem(
                        title: Text(
                          'Test',
                          style: TextStyle(color: kUnActiveColor),
                        ),
                        icon: Icon(Icons.person)),
                    BottomNavigationBarItem(
                        title: Text(
                          'Test',
                          style: TextStyle(color: kUnActiveColor),
                        ),
                        icon: Icon(Icons.person)),
                  ]),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                bottom: TabBar(
                  onTap: (value) {
                    setState(() {
                      _tabarindex = value;
                    });
                  },
                  indicatorColor: kmainColor,
                  tabs: [
                    Text(
                      'Jackets1',
                      style: TextStyle(
                          color:
                              _tabarindex == 0 ? Colors.black : kUnActiveColor,
                          fontSize: _tabarindex == 0 ? 16 : null),
                    ),
                    Text(
                      'Jackets2',
                      style: TextStyle(
                          color:
                              _tabarindex == 1 ? Colors.black : kUnActiveColor,
                          fontSize: _tabarindex == 1 ? 16 : null),
                    ),
                    Text(
                      'Jackets3',
                      style: TextStyle(
                          color:
                              _tabarindex == 2 ? Colors.black : kUnActiveColor,
                          fontSize: _tabarindex == 2 ? 16 : null),
                    ),
                    Text(
                      'Jackets4',
                      style: TextStyle(
                          color:
                              _tabarindex == 3 ? Colors.black : kUnActiveColor,
                          fontSize: _tabarindex == 3 ? 16 : null),
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                jacketView(),
                productView(_products),
                Text('Test 3'),
                Text('Test 4'),
              ])),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.shopping_basket)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget jacketView() {
    return StreamBuilder<List<Product>>(
        stream: Stream.fromFuture(_store.loadPatient()),
        builder: (context, snapshot) {
          print(snapshot.toString());
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data) {
              products.add(Product(
                  pNme: doc.pNme,
                  pCategory: doc.pCategory,
                  pPrice: doc.pPrice));
            }
            _products = [...products];
            products.clear();
            products = getProductByCategory('Test', _products);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .7, crossAxisCount: 2),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index].pNme,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
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
          } else {
            return Center(child: Text('Loading..'));
          }
        });
  }
}
