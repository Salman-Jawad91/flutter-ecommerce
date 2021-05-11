import 'package:ecommerce_arabic/constants.dart';
import 'package:ecommerce_arabic/models/orders.dart';
import 'package:ecommerce_arabic/services/store.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  StoreProduct _store = StoreProduct();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<Order>>(
      stream: Stream.fromFuture(_store.loadPatientOrders()),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text("There is no orders"),
          );
        } else {
          List<Order> orders = [];
          for (var order in snapshot.data) {
            orders.add(Order(
                name: order.name,
                patient_name: order.patient_name,
                qty: order.qty));
          }
          return Column(children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: ksecondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Qty is ${orders[index].qty.toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Patient Name is : ${orders[index].patient_name} ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: orders.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RaisedButton(
                        onPressed: () {}, child: Text('Confirm Orders')),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: RaisedButton(
                        onPressed: () {}, child: Text('Delete Orders')),
                  ),
                ],
              ),
            )
          ]);
        }
      },
    ));
  }
}
