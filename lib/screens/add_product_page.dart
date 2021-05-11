import 'package:ecommerce_arabic/models/product.dart';
import 'package:ecommerce_arabic/services/store.dart';
import 'package:ecommerce_arabic/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  static String id = 'AddProductScreen';
  String _pName, _pPrice, _pCategory;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  StoreProduct _store = StoreProduct();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              hint: 'Proudct Name',
              onClick: (value) {
                _pName = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Proudct Price',
              onClick: (value) {
                _pPrice = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Proudct Category',
              onClick: (value) {
                _pCategory = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                onPressed: () async {
                  if (_globalKey.currentState.validate()) {
                    _globalKey.currentState.save();
                    // _store.addPatient();
                    print('Start');
                    bool res = await _store.addPatient(Product(
                        pNme: _pName, pPrice: _pPrice, pCategory: _pCategory));
                    print('Finish');
                  }
                },
                child: Text('Add Product'))
          ],
        ),
      ),
    );
  }
}
