import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uuid/uuid.dart';
import 'product_detail_screen.dart';
import 'widgets/homeCard.dart';

// ignore: must_be_immutable
class CategoryProductsScreen extends StatefulWidget {
  CategoryProductsScreen({super.key, required this.title, required this.products});

  String title;
  final List<Map<String, dynamic>> products;
  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool isTrue = true;
  // final List _products = [];
  // final _firestoreInstance = FirebaseFirestore.instance;
  // bool _isLoading = false;

  // fetchProducts() async {
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     QuerySnapshot qn = await _firestoreInstance.collection('products').get();
  //     setState(() {
  //       for (int i = 0; i < qn.docs.length; i++) {
  //         _products.add({
  //           'id': qn.docs[i]['id'],
  //           'sellerId': qn.docs[i]['sellerId'],
  //           'imageUrl': qn.docs[i]['imageUrl'],
  //           'title': qn.docs[i]['title'],
  //           'price': qn.docs[i]['price'],
  //           'salePrice': qn.docs[i]['salePrice'],
  //           'detail': qn.docs[i]['detail'],
  //           'weight': qn.docs[i]['weight'],
  //         });
  //       }
  //     });
  //     return qn.docs;
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  void addToCart(String img, String title, String dPrice, String sellerId,
      String productId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Utils.toastMessage('Please SignUp first');
      return;
    }

    final userId = currentUser.uid;
    // Get the collection reference for the user's cart
    CollectionReference cartCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    // Check if the product is already in the cart
    QuerySnapshot cartSnapshot = await cartCollectionRef
        .where('imageUrl', isEqualTo: img)
        .limit(1)
        .get();

    if (cartSnapshot.docs.isNotEmpty) {
      // Product is already in the cart, show a popup message
      Utils.toastMessage('Product is already in the cart');
    } else {
      // Product is not in the cart, add it
      var uuid = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(uuid)
          .set({
        'sellerId': sellerId,
        'id': productId,
        'imageUrl': img,
        'title': title,
        'salePrice': dPrice,
        'deleteId': uuid,
        // Add other product details as needed
      });
      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  initState() {
    super.initState();
    // fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: widget.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          return HomeCard(
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductDetailScreen(
                      title: widget.products[index]['title'].toString(),
                      productId: widget.products[index]['id'].toString(),
                      sellerId: widget.products[index]['sellerId'].toString(),
                      imageUrl: widget.products[index]['imageUrl'],
                      price: widget.products[index]['price'].toString(),
                      salePrice: widget.products[index]['price'],
                      weight: widget.products[index]['weight'].toString(),
                      detail: widget.products[index]['detail'].toString(),
                    );
                  },
                ),
              );
            },
            productId: widget.products[index]['id'],
            sellerId: widget.products[index]['sellerId'],
            name: widget.products[index]['title'].toString(),
            price: widget.products[index]['price'].toString(),
            dPrice: "${widget.products[index]['price']}₹",
            borderColor: AppColor.buttonBgColor,
            fillColor: AppColor.appBarButtonColor,
            cartBorder: true
                ? AppColor.appBarButtonColor
                : const Color.fromRGBO(203, 1, 102, 1),
            img: widget.products[index]['imageUrl'],
            iconColor: AppColor.buttonBgColor,
            addCart: () {
              addToCart(
                widget.products[index]['imageUrl'],
                widget.products[index]['title'],
                widget.products[index]['price'],
                widget.products[index]['sellerId'],
                widget.products[index]['id'],
              );
            },
          );
        },
      ),
    );
  }
}
