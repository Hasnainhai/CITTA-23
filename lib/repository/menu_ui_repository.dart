import 'package:citta_23/res/consts/menu_enums.dart';
import 'package:flutter/material.dart';

class MenuUiRepository with ChangeNotifier {
  MenuEnums _selectedType = MenuEnums.DefaultSection;

  MenuEnums get selectedType => _selectedType;

  void switchToType(MenuEnums type) {
    _selectedType = type;
    notifyListeners();
  }
}
