import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:citta_23/models/search_model.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  bool _isSearch = false;
  Timer? _debounce;

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
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _isSearch = query.isNotEmpty;
      _filteredProducts = [];
      if (query.isNotEmpty) {
        for (var product in _products) {
          if (product.title.toLowerCase().contains(query.toLowerCase())) {
            _filteredProducts.add(product);
          }
        }
      } else {
        _filteredProducts = _products;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
