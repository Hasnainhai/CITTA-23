import 'package:flutter/foundation.dart';

class SubTotalModel extends ChangeNotifier {
  int _subTotal = 0;

  int get subTotal => _subTotal;

  void updateSubTotal(int newSubTotal) {
    _subTotal = newSubTotal;
    notifyListeners();
  }
}

class DiscountSum extends ChangeNotifier {
  int _dis = 0;

  int get dis => _dis;

  void updateDisTotal(int dis) {
    _dis = dis;
    notifyListeners();
  }
}

class TotalPriceModel with ChangeNotifier {
  int _totalPrice = 0;

  int get totalPrice => _totalPrice;

  void updateTotalPrice(int subTotal, int discount) {
    _totalPrice = subTotal - discount;
    notifyListeners();
  }
}
