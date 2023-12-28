import 'package:flutter/material.dart';

class IndexModel extends ChangeNotifier {
  int _index = 0;

  int get items => _index;

  void updateIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
