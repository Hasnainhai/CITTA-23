import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRepository extends ChangeNotifier {
  String _productType = 'food';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('products');
  Query _categoryReference = FirebaseFirestore.instance
      .collection('fashion')
      .where('category', isEqualTo: 'Paints');
  String get productType => _productType;
  CollectionReference get collectionReference => _collectionReference;
  Query get categoryReference => _categoryReference;

  void handleFoodButton() {
    _productType = 'food';
    setProductType(_productType);
    _collectionReference = FirebaseFirestore.instance.collection('products');
    notifyListeners();
  }

  void handleFashionButton() {
    _productType = 'fashion';
    setProductType(_productType);

    _collectionReference = FirebaseFirestore.instance.collection('fashion');
    notifyListeners();
  }

  void _updateCollectionReference() {
    _collectionReference =
        _firestore.collection(_productType == 'food' ? 'products' : 'fashion');
  }

  void setProductType(String type) {
    _productType = type;
    _updateCollectionReference();
    notifyListeners();
  }

  void fetchItems(String relatedValue) {
    _categoryReference =
        _collectionReference.where('releated', isEqualTo: relatedValue);
    notifyListeners();
  }
}
