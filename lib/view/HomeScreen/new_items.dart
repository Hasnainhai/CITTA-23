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
class NewItemsScreen extends StatefulWidget {
  NewItemsScreen({super.key, required this.title});

  String title;

  @override
  State<NewItemsScreen> createState() => _NewItemsScreenState();
}

class _NewItemsScreenState extends State<NewItemsScreen> {
  bool isTrue = true;
  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;
  bool _isLoading = false;

  fetchProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      QuerySnapshot qn = await _firestoreInstance.collection('products').get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          _products.add({
            'id': qn.docs[i]['id'],
            'sellerId': qn.docs[i]['sellerId'],
            'imageUrl': qn.docs[i]['imageUrl'],
            'title': qn.docs[i]['title'],
            'price': qn.docs[i]['price'],
            'salePrice': qn.docs[i]['salePrice'],
            'detail': qn.docs[i]['detail'],
            'weight': qn.docs[i]['weight'],
          });
        }
      });
      return qn.docs;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void addToCart(String img, String title, String dPrice, String sellerId,
      String productId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
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
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.fontColor,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.fontColor,
          ),
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, index) {
                // Check if _products is not empty and index is within valid range
                if (_products.isNotEmpty && index < _products.length) {
                  return HomeCard(
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(
                          title: _products[index]['title'].toString(),
                          imageUrl: _products[index]['imageUrl'],
                          price: _products[index]['price'].toString(),
                          salePrice: _products[index]['salePrice'].toString(),
                          weight: _products[index]['weight'].toString(),
                          detail: _products[index]['detail'].toString(),
                          productId: _products[index]['id'].toString(),
                          sellerId: _products[index]['sellerId'].toString(),
                        );
                      }));
                    },
                    productId: _products[index]['id'].toString(),
                    sellerId: _products[index]['sellerId'].toString(),
                    name: _products[index]['title'].toString(),
                    price: _products[index]['price'].toString(),
                    dPrice: _products[index]['salePrice'].toString(),
                    borderColor: AppColor.buttonBgColor,
                    fillColor: AppColor.appBarButtonColor,
                    cartBorder: isTrue
                        ? AppColor.appBarButtonColor
                        : AppColor.buttonBgColor,
                    img: _products[index]['imageUrl'],
                    iconColor: AppColor.buttonBgColor,
                    addCart: () {
                      if (_products.isNotEmpty &&
                          index >= 0 &&
                          index < _products.length) {
                        addToCart(
                          _products[index]['imageUrl'],
                          _products[index]['title'],
                          _products[index]['salePrice'],
                          _products[index]['sellerId'],
                          _products[index]['id'],
                        );
                      }
                    },
                  );
                } else if (_products.isEmpty) {
                  return const Center(
                    child: Text('No Products...'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Shimmer(
                      duration: const Duration(seconds: 3), //Default value
                      interval: const Duration(
                          seconds: 5), //Default value: Duration(seconds: 0)
                      color:
                          AppColor.grayColor.withOpacity(0.2), //Default value
                      colorOpacity: 0.2, //Default value
                      enabled: true, //Default value
                      direction:
                          const ShimmerDirection.fromLTRB(), //Default Value
                      child: Container(
                        height: 100,
                        width: 150,
                        color: AppColor.grayColor.withOpacity(0.2),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
