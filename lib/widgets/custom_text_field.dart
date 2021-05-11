import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  String errorMsg() {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty';
      case 'Enter your email':
        return 'Email is empty';
      case 'Enter your password':
        return 'Password is empty';
    }
  }

  CustomTextField(
      {@required this.onClick, @required this.hint, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return errorMsg();
          }
        },
        onSaved: onClick,
        cursorColor: kmainColor,
        obscureText: hint == 'Enter your password' ? true : false,
        decoration: InputDecoration(
            filled: true,
            fillColor: ksecondaryColor,
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: kmainColor,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
