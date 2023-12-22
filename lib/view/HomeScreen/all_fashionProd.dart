// ignore_for_file: unused_field
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
import 'package:citta_23/view/HomeScreen/popular_pack_screen.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
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
 void addToCart(String img, String title, String dPrice) async {
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
      await cartCollectionRef.add({
        'imageUrl': img,
        'title': title,
        'price': dPrice,
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
        title: Text(
          "Fashion",
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
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
                              title:
                                  _fashionProducts[index]['title'].toString(),
                              imageUrl: _fashionProducts[index]['imageUrl'],
                              // price: _fashionProducts[index]
                              //         ['price']
                              //     .toString(),
                              salePrice: _fashionProducts[index]['price'],
                              // .toString(),
                              // weight: _products[index]['weight']
                              //     .toString(),
                              detail:
                                  _fashionProducts[index]['detail'].toString());
                        }));
                      },
                      name: _fashionProducts[index]['title'].toString(),
                      price: '',
                      dPrice: _fashionProducts[index]['price'].toString(),
                      borderColor: AppColor.buttonBgColor,
                      fillColor: AppColor.appBarButtonColor,
                      cartBorder: isTrue
                          ? AppColor.appBarButtonColor
                          : AppColor.buttonBgColor,
                      img: _fashionProducts[index]['imageUrl'],
                      iconColor: AppColor.buttonBgColor,  // add to cart logic
                                      addCart: () {
                                        if (_fashionProducts.isNotEmpty &&
                                            index >= 0 &&
                                            index < _fashionProducts.length) {
                                          addToCart(
                                            _fashionProducts[index]['imageUrl'],
                                            _fashionProducts[index]['title'],
                                            _fashionProducts[index]['price'],
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
