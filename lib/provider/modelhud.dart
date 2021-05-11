import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier {
  bool isLoading = false;

  ChangeisLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
