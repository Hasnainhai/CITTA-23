import 'package:citta_23/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  bool _isSearch = false;

  List<Product> get products => _isSearch ? _filteredProducts : _products;
  bool get isLoading => _isLoading;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    QuerySnapshot fashionSnapshot =
        await _firestore.collection('fashion').get();
    QuerySnapshot productsSnapshot =
        await _firestore.collection('products').get();

    _products = _processSnapshot(fashionSnapshot, true);
    _products.addAll(_processSnapshot(productsSnapshot, false));
    _filteredProducts = _products;

    _isLoading = false;
    notifyListeners();
  }

  List<Product> _processSnapshot(QuerySnapshot snapshot, bool isFashion) {
    return snapshot.docs.map((doc) {
      return Product.fromFirestore(
          doc.data() as Map<String, dynamic>, isFashion);
    }).toList();
  }

  void filterProducts(String query) {
    _isSearch = query.isNotEmpty;
    _filteredProducts = _products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
