import 'package:ecommerce_arabic/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_arabic/services/auth.dart';
import 'package:odoo_api/odoo_api_connector.dart';

import '../constants.dart';
import 'login_page.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'SignupScreen';
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  String _email, _password;
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: kmainColor,
        body: Form(
          key: _globalkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: Image(
                        image: AssetImage('images/buy.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Text(
                        'Buy it',
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              CustomTextField(
                  onClick: (value) {},
                  hint: 'Enter your name',
                  icon: Icons.perm_identity),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                  onClick: (value) {
                    _email = value;
                  },
                  hint: 'Enter your email',
                  icon: Icons.email),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                  onClick: (value) {
                    _password = value;
                  },
                  hint: 'Enter your password',
                  icon: Icons.lock),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.18),
                child: FlatButton(
                  onPressed: () async {
                    if (_globalkey.currentState.validate()) {
                      // do something
                      _globalkey.currentState.save();
                      print(_email);
                      print(_password);
                      bool ret = await _auth.signup(_email, _password);
                      print('test111');
                      print(ret);
                    }
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Do have an account ',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
