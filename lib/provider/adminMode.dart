import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier {
  bool isAdminMode = false;

  changeAdminMode(bool value) {
    isAdminMode = value;
    notifyListeners();
  }
}
