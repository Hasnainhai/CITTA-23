import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/products_model.dart';

class Products {
  static List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts {
    return _productsList;
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      // _productsList.clear();
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              // productCategoryName: element.get('productCategoryName'),
              price: double.parse(
                element.get('price'),
              ),
              salePrice: element.get('salePrice'),
            ));
      });
    });
  }
}
