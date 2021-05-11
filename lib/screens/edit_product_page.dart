import 'package:ecommerce_arabic/models/product.dart';
import 'package:ecommerce_arabic/services/store.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  static String id = 'EditScreen';

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _store = StoreProduct();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<Product>>(
            stream: Stream.fromFuture(_store.loadPatient()),
            builder: (context, snapshot) {
              print(snapshot.toString());
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .7, crossAxisCount: 2),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                                      snapshot.data[index].pNme,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text('\$ ${snapshot.data[index].pCategory}')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: snapshot.data.length,
                );

                // return ListView.builder(
                //   itemBuilder: (context, index) =>
                //       Text(snapshot.data[index].pNme),
                //   itemCount: snapshot.data.length,
                // );
              } else {
                return Center(child: Text('Loading..'));
              }
            }));
  }

//  @override
  // void initState() {
  //   // TODO: implement initState
  //   getPatients();
  //   super.initState();
  // }

  // void getPatients() async {
  //   _patients = await _store.loadPatient();
  //   print(_patients.toString());
  // }
}

class SilverGridDelegateWithFixedCrossAxisCount {}
