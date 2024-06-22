import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRepository extends ChangeNotifier {
  String _productType = 'food';
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('products');

  String get productType => _productType;
  CollectionReference get collectionReference => _collectionReference;

  void handleFoodButton() {
    _productType = 'food';
    _collectionReference = FirebaseFirestore.instance.collection('products');
    notifyListeners();
  }

  void handleFashionButton() {
    _productType = 'fashion';
    _collectionReference = FirebaseFirestore.instance.collection('fashion');
    notifyListeners();
  }
}
