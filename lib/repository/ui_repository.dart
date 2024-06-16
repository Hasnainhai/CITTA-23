import 'package:citta_23/res/consts/ui_enums.dart';
import 'package:flutter/material.dart';

class HomeUiSwithchRepository extends ChangeNotifier {
  UIType _selectedType = UIType.DefaultSection;

  UIType get selectedType => _selectedType;

  void switchToType(UIType type) {
    _selectedType = type;
    notifyListeners();
  }

  void switchToDefaultSection() {
    switchToType(UIType.DefaultSection);
    notifyListeners();
  }
}
