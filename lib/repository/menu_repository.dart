import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRepository extends ChangeNotifier {
  String _productType = 'food';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('products');

  String get productType => _productType;
  CollectionReference get collectionReference => _collectionReference;

  void handleFoodButton() {
    _productType = 'food';
    setProductType();
    _collectionReference = FirebaseFirestore.instance.collection('products');
    notifyListeners();
  }

  void handleFashionButton() {
    _productType = 'fashion';
    setProductType();

    _collectionReference = FirebaseFirestore.instance.collection('fashion');
    notifyListeners();
  }

  void _updateCollectionReference() {
    _collectionReference =
        _firestore.collection(_productType == 'food' ? 'products' : 'fashion');
  }

  void setProductType() {
    _updateCollectionReference();
    notifyListeners();
  }

  Future<QuerySnapshot> fetchItems(String relatedValue) {
    return _collectionReference
        .where('releated', isEqualTo: relatedValue)
        .get();
  }
}
