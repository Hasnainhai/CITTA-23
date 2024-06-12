// ignore_for_file: file_names

import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';
import '../../res/components/loading_manager.dart';

class AllFashionProd extends StatefulWidget {
  const AllFashionProd({super.key});

  @override
  State<AllFashionProd> createState() => _AllFashionProdState();
}

class _AllFashionProdState extends State<AllFashionProd> {
  final _firestoreInstance = FirebaseFirestore.instance;
  final List _fashionProducts = [];
  bool _isLoading = false;
  fetchFashionProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      QuerySnapshot qn = await _firestoreInstance.collection('fashion').get();

      setState(() {
        _fashionProducts.clear();
        for (int i = 0; i < qn.docs.length; i++) {
          _fashionProducts.add({
            'id': qn.docs[i]['id'],
            'sellerId': qn.docs[i]['sellerId'],
            'imageUrl': qn.docs[i]['imageUrl'],
            'title': qn.docs[i]['title'],
            'price': qn.docs[i]['price'],
            // 'salePrice': qn.docs[i]['salePrice'],
            'detail': qn.docs[i]['detail'],
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
  void initState() {
    super.initState();
    fetchFashionProducts();
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
        title: const Text(
          "Fashion",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.fontColor,
          ),
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: _fashionProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (_, index) {
                  // Check if _products is not empty and index is within valid range
                  if (_fashionProducts.isNotEmpty &&
                      index < _fashionProducts.length) {
                    return HomeCard(
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FashionDetail(
                            title: _fashionProducts[index]['title'].toString(),
                            imageUrl: _fashionProducts[index]['imageUrl'],
                            salePrice: _fashionProducts[index]['price'],
                            detail:
                                _fashionProducts[index]['detail'].toString(),
                            sellerId: _fashionProducts[index]['sellerId'],
                            productId: _fashionProducts[index]['id'],
                            colors:
                                _fashionProducts[index]['color'].cast<String>(),
                            sizes:
                                _fashionProducts[index]['size'].cast<String>(),
                          );
                        }));
                      },
                      sellerId: _fashionProducts[index]['sellerId'],
                      productId: _fashionProducts[index]['id'],
                      name: _fashionProducts[index]['title'].toString(),
                      // productRating: _fashionProducts[index]['id'],
                      price: '',
                      dPrice: _fashionProducts[index]['price'].toString(),
                      borderColor: AppColor.buttonBgColor,
                      fillColor: AppColor.appBarButtonColor,
                      img: _fashionProducts[index]['imageUrl'],
                      iconColor: AppColor.buttonBgColor, // add to cart logic
                      addCart: () {
                        if (_fashionProducts.isNotEmpty &&
                            index >= 0 &&
                            index < _fashionProducts.length) {
                          addToCart(
                            _fashionProducts[index]['imageUrl'],
                            _fashionProducts[index]['title'],
                            _fashionProducts[index]['price'],
                            _fashionProducts[index]['sellerId'],
                            _fashionProducts[index]['id'],
                          );
                        }
                      },
                    );
                  } else if (_fashionProducts.isEmpty) {
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
                    ); // or some default widget
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
