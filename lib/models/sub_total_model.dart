import 'package:flutter/foundation.dart';

class SubTotalModel extends ChangeNotifier {
  int _subTotal = 0;

  int get subTotal => _subTotal;

  void updateSubTotal(int newSubTotal) {
    _subTotal = newSubTotal;
    notifyListeners();
  }
}
