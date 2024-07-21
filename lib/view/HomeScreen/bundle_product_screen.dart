// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/check_out.dart';
import 'package:citta_23/view/HomeScreen/popular_pack_screen.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/total_reviews.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/widgets/detail_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uuid/uuid.dart';

import '../../res/components/colors.dart';

// ignore: must_be_immutable
class BundleProductScreen extends StatefulWidget {
  BundleProductScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.saleprice,
    required this.detail,
    required this.weight,
    required this.size,
    required this.img1,
    required this.title1,
    required this.amount1,
    required this.img2,
    required this.title2,
    required this.amount2,
    required this.img3,
    required this.title3,
    required this.amount3,
    required this.img4,
    required this.title4,
    required this.amount4,
    required this.img5,
    required this.title5,
    required this.amount5,
    required this.img6,
    required this.title6,
    required this.amount6,
    required this.sellerId,
    required this.productId,
  });
  List<dynamic> imageUrl;
  final String title;
  final String price;
  String saleprice;
  final String detail;
  final String weight;
  final String size;
  final String sellerId;
  final String productId;
  //bundle 1
  final String img1;
  final String title1;
  final String amount1;
  //bundle 2
  final String img2;
  final String title2;
  final String amount2;
  //bundle 3
  final String img3;
  final String title3;
  final String amount3;
  //bundle 4
  final String img4;
  final String title4;
  final String amount4;
  //bundle 5
  final String img5;
  final String title5;
  final String amount5;
  //bundle 6
  final String img6;
  final String title6;
  final String amount6;

  @override
  State<BundleProductScreen> createState() => _BundleProductScreenState();
}

class _BundleProductScreenState extends State<BundleProductScreen> {
  bool like = false;
  int currentIndex = 0;
  bool _isLoading = false;

  final _firestoreInstance = FirebaseFirestore.instance;
  int? newPrice;
  int items = 1;
  String? addPrice;
  int? totalPrice;

  void increment() {
    setState(() {
      items++;

      int price = int.parse(widget.price);
      newPrice = (newPrice ?? int.parse(widget.price)) + price;
    });
  }

  void decrement() {
    setState(() {
      if (items > 1) {
        items--;
        int price = int.parse(widget.price);
        newPrice = (newPrice ?? int.parse(widget.price)) - price;
      } else {
        Utils.flushBarErrorMessage("Fixed Limit", context);
      }
    });
  }

  void addToCart(
    String img,
    String title,
    String dPrice,
    String sellerId,
    String productId,
    String weight,
    String disPrice,
  ) async {
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
      Utils.snackBar('Product is already in the cart', context);
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
        'salePrice': widget.price,
        'deleteId': uuid,
        "size": widget.size,
        "color": "N/A",
        "weight": weight,
        'dPrice': disPrice,

        // Add other product details as needed
      });
      Utils.snackBar('Successfully added to cart', context);
    }
  }

  void addToFavorites(
      String discount, String weight, String size, String color) async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth
          .instance.currentUser!.uid; // You need to implement this function
      String uuid = const Uuid().v1();
      // Add the item to the 'favoriteList' collection
      await _firestoreInstance
          .collection('favoriteList')
          .doc(uid)
          .collection('favorites')
          .doc(uuid)
          .set({
        'title': widget.title.toString(),
        'salePrice': widget.saleprice.toString(),
        'imageUrl': widget.imageUrl[0],
        'id': widget.productId.toString(),
        'sellerId': widget.sellerId,
        'deletedId': uuid,
        "weight": weight,
        'color': 'N/A',
        'size': size,
        "discount": discount
        // 'isLike': like,
      });
      // Display a success message or perform any other action
      Utils.snackBar('SuccessFully add to favourite', context);
    } catch (e) {
      // Handle errors
      Utils.flushBarErrorMessage('Error adding to favorites: $e', context);
    }
  }

  void removeFromFavorites() async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth
          .instance.currentUser!.uid; // You need to implement this function

      // Query the 'favoriteList' collection to find the document to delete
      QuerySnapshot querySnapshot = await _firestoreInstance
          .collection('favoriteList')
          .doc(uid)
          .collection('favorites')
          .where('title', isEqualTo: widget.title.toString())
          .get();

      // Delete the document
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await _firestoreInstance
            .collection('favoriteList')
            .doc(uid)
            .collection('favorites')
            .doc(doc.id)
            .delete();
      }

      // Display a success message or perform any other action
      Utils.snackBar('SuccessFully removed from favourite', context);
    } catch (e) {
      // Handle errors
      Utils.flushBarErrorMessage('Error removing from favorites: $e', context);
      // print('Error removing from favorites: $e');
    }
  }

  final List<Map<String, dynamic>> _popularRelatedPacks = [];
  fetchPopularRelatedPack() async {
    try {
      setState(() {
        _isLoading = true;
      });
      QuerySnapshot qn =
          await _firestoreInstance.collection('bundle pack').get();

      setState(() {
        _popularRelatedPacks.clear();
        for (int i = 0; i < qn.docs.length; i++) {
          // Access individual products in the bundle
          Map<String, dynamic> product1 = qn.docs[i]['product1'] ?? {};
          Map<String, dynamic> product2 = qn.docs[i]['product2'] ?? {};
          Map<String, dynamic> product3 = qn.docs[i]['product3'] ?? {};
          Map<String, dynamic> product4 = qn.docs[i]['product4'] ?? {};
          Map<String, dynamic> product5 = qn.docs[i]['product5'] ?? {};
          Map<String, dynamic> product6 = qn.docs[i]['product6'] ?? {};
          _popularRelatedPacks.add({
            'product1': {
              'amount': product1['amount'] ?? '',
              'image': product1['image'] ?? '',
              'title': product1['title'] ?? '',
            },
            'product2': {
              'amount': product2['amount'] ?? '',
              'image': product2['image'] ?? '',
              'title': product2['title'] ?? '',
            },
            'product3': {
              'amount': product3['amount'] ?? '',
              'image': product3['image'] ?? '',
              'title': product3['title'] ?? '',
            },
            'product4': {
              'amount': product4['amount'] ?? '',
              'image': product4['image'] ?? '',
              'title': product4['title'] ?? '',
            },
            'product5': {
              'amount': product5['amount'] ?? '',
              'image': product5['image'] ?? '',
              'title': product5['title'] ?? '',
            },
            'product6': {
              'amount': product6['amount'] ?? '',
              'image': product6['image'] ?? '',
              'title': product6['title'] ?? '',
            },
            //simple card
            'sellerId': qn.docs[i]['sellerId'],
            'id': qn.docs[i]['id'],
            'imageUrl': qn.docs[i]['imageUrl'],
            'title': qn.docs[i]['title'],
            'price': qn.docs[i]['price'],
            'detail': qn.docs[i]['detail'],
            'weight': qn.docs[i]['weight'],
            'size': qn.docs[i]['size'],
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

  int _currentIndex = 0;
  Color? likeColor;

  checkThefav() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await _firestoreInstance
        .collection('favoriteList')
        .doc(uid)
        .collection('favorites')
        .where('id', isEqualTo: widget.productId.toString())
        .get();
    if (querySnapshot.docs.isEmpty) {
      setState(() {
        likeColor = Colors.transparent;
      });
    } else {
      likeColor = AppColor.primaryColor;
    }
  }

  @override
  void initState() {
    checkThefav();
    fetchPopularRelatedPack();
    super.initState();
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
            )),
        title: const Text(
          "Bundel Details",
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 320,
                    width: 400,
                    decoration: const BoxDecoration(
                      color: Color(0xffEEEEEE),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 14,
                      ),
                      child: Column(
                        children: [
                          const VerticalSpeacing(10),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // Toggle the value of like
                                  setState(() {
                                    like = !like;
                                    if (like) {
                                      // Add to favorites
                                      addToFavorites("0", widget.weight,
                                          widget.size, 'N/A');
                                      like = true;
                                    } else {
                                      // Remove from favorites
                                      removeFromFavorites();
                                      like = false;
                                    }
                                  });
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  color: Colors.white,
                                  child: like
                                      ? const Icon(
                                          Icons.favorite,
                                          color: AppColor.primaryColor,
                                        )
                                      : const Icon(
                                          Icons.favorite_border_rounded),
                                ),
                              ),
                            ],
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 220.0,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: widget.imageUrl.map((imageUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: 250,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          const VerticalSpeacing(20),
                          AnimatedSmoothIndicator(
                            activeIndex: _currentIndex,
                            count: widget.imageUrl.length,
                            effect: const ScrollingDotsEffect(
                              dotWidth: 10.0,
                              dotHeight: 10.0,
                              activeDotColor: AppColor.primaryColor,
                              dotColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpeacing(30),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.fontColor,
                    ),
                  ),
                  const VerticalSpeacing(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.price,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            newPrice == null
                                ? "₹${widget.price}"
                                : "₹$newPrice",
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              decrement();
                            },
                            child: Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.grayColor,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 2,
                                    thickness: 2.5,
                                    color: AppColor.primaryColor,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Text(
                            items.toString(),
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor,
                            ),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          InkWell(
                            onTap: () {
                              increment();
                            },
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.grayColor,
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpeacing(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.weight,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                          const Text(
                            "Weight",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.grayColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            widget.size,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                          const Text(
                            "Size",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.grayColor,
                            ),
                          ),
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            "6",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                          Text(
                            "Item’s",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.grayColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const VerticalSpeacing(20),
                  const Text(
                    "Pack Details",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),

                  const VerticalSpeacing(
                    8,
                  ),
                  Text(
                    widget.detail,
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grayColor,
                    ),
                  ),

                  const VerticalSpeacing(20),
                  // first bundle product
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: AppColor.buttonTxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FancyShimmerImage(
                            imageUrl: widget.img1,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title1,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                            const SizedBox(
                              height:
                                  4, // Adjust spacing between title and amount
                            ),
                            Text(
                              widget.amount1,
                              // widget.amount1,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const VerticalSpeacing(10),
                  // second bundle product
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: AppColor.buttonTxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FancyShimmerImage(
                            imageUrl: widget.img2,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title2,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                            const SizedBox(
                              height:
                                  4, // Adjust spacing between title and amount
                            ),
                            Text(
                              widget.amount2,
                              // widget.amount1,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(10),
                  // third bundle product
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: AppColor.buttonTxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FancyShimmerImage(
                            imageUrl: widget.img3,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title3,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                            const SizedBox(
                              height:
                                  4, // Adjust spacing between title and amount
                            ),
                            Text(
                              widget.amount3,
                              // widget.amount1,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(10),
                  // fourth Bundle product
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: AppColor.buttonTxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FancyShimmerImage(
                            imageUrl: widget.img4,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title4,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                            const SizedBox(
                              height:
                                  4, // Adjust spacing between title and amount
                            ),
                            Text(
                              widget.amount4,
                              // widget.amount1,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(10),
                  // fifth Bundle product detail
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: AppColor.buttonTxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FancyShimmerImage(
                            imageUrl: widget.img5,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title5,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                            const SizedBox(
                              height:
                                  4, // Adjust spacing between title and amount
                            ),
                            Text(
                              widget.amount5,
                              // widget.amount1,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(10),
                  // sixth Bundle product
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: AppColor.buttonTxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FancyShimmerImage(
                            imageUrl: widget.img6,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title6,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                            const SizedBox(
                              height:
                                  4, // Adjust spacing between title and amount
                            ),
                            Text(
                              widget.amount6,
                              // widget.amount1,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(
                    20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 8,
                        color: AppColor.primaryColor,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              addToCart(
                                widget.imageUrl[0],
                                widget.title,
                                widget.saleprice,
                                widget.sellerId,
                                widget.productId,
                                widget.weight,
                                '0',
                              );
                            },
                            icon: const Icon(
                              Icons.add_shopping_cart_outlined,
                              color: AppColor.whiteColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.4,
                          color: AppColor.primaryColor,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => CheckOutScreen(
                                    tile: widget.title,
                                    price: widget.price,
                                    img: widget.imageUrl[0],
                                    id: widget.productId,
                                    customerId: widget.sellerId,
                                    weight: widget.weight,
                                    salePrice: newPrice == null
                                        ? widget.saleprice
                                        : newPrice.toString(),
                                    productType: "popular_pak",
                                    size: widget.size,
                                    color: 'N/A',
                                    quantity: items.toString(),
                                  ),
                                ),
                              );
                            },
                            child: const Center(
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top reviews',
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.fontColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => TotalRatingScreen(
                                productType: "bundle pack",
                                productId: widget.productId,
                                productPic: widget.imageUrl[0],
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "See More",
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.buttonBgColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(14),
                  SizedBox(
                    height: 145,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("bundle pack")
                          .doc(widget.productId)
                          .collection('commentsAndRatings')
                          .orderBy("time", descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('No comments and ratings available'),
                          );
                        }

                        // Limit the number of items to 2
                        final limitedDocs =
                            snapshot.data!.docs.take(2).toList();

                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: limitedDocs.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> data = limitedDocs[index]
                                .data() as Map<String, dynamic>;
                            return DetailRating(
                              userName: data['userName'],
                              img: data['profilePic'],
                              comment: data['comment'],
                              rating: data['currentUserRating'].toString(),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 10),
                        );
                      },
                    ),
                  ),
                  const VerticalSpeacing(13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Related products',
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.fontColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const PopularPackScreen(
                                title: 'Related products');
                          }));
                        },
                        child: const Text(
                          "See More",
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.buttonBgColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const VerticalSpeacing(12),
                  SizedBox(
                    height: 63,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _popularRelatedPacks.length,
                      itemBuilder: (context, index) {
                        if (_popularRelatedPacks.isEmpty) {
                          return const Center(
                            child: Text('Empty related products'),
                          );
                        } else {
                          final popularRelatedProducts =
                              _popularRelatedPacks[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    // Check if _popularRelatedPacks is not null and index is within bounds
                                    if (popularRelatedProducts.isNotEmpty &&
                                        index >= 0 &&
                                        index < popularRelatedProducts.length) {
                                      Map<String, dynamic> selectedPack =
                                          popularRelatedProducts;

                                      return BundleProductScreen(
                                        imageUrl:
                                            selectedPack['imageUrl'] ?? '',
                                        sellerId:
                                            selectedPack['sellerId'] ?? "",
                                        productId: selectedPack['id'] ?? "",
                                        title: selectedPack['title'] ?? '',
                                        price: selectedPack['price'] ?? '',
                                        saleprice:
                                            selectedPack['salePrice'] ?? '',
                                        detail: selectedPack['detail'] ?? '',
                                        weight: selectedPack['weight'] ?? '',
                                        size: selectedPack['size'] ?? '',
                                        img1: selectedPack['product1']
                                                ?['image'] ??
                                            '',
                                        title1: selectedPack['product1']
                                                ?['title'] ??
                                            '',
                                        amount1: selectedPack['product1']
                                                ?['amount'] ??
                                            '',
                                        img2: selectedPack['product2']
                                                ?['image'] ??
                                            '',
                                        title2: selectedPack['product2']
                                                ?['title'] ??
                                            '',
                                        amount2: selectedPack['product2']
                                                ?['amount'] ??
                                            '',
                                        img3: selectedPack['product3']
                                                ?['image'] ??
                                            '',
                                        title3: selectedPack['product3']
                                                ?['title'] ??
                                            '',
                                        amount3: selectedPack['product3']
                                                ?['amount'] ??
                                            '',
                                        img4: selectedPack['product4']
                                                ?['image'] ??
                                            '',
                                        title4: selectedPack['product4']
                                                ?['title'] ??
                                            '',
                                        amount4: selectedPack['product4']
                                                ?['amount'] ??
                                            '',
                                        img5: selectedPack['product5']
                                                ?['image'] ??
                                            '',
                                        title5: selectedPack['product5']
                                                ?['title'] ??
                                            '',
                                        amount5: selectedPack['product5']
                                                ?['amount'] ??
                                            '',
                                        img6: selectedPack['product6']
                                                ?['image'] ??
                                            '',
                                        title6: selectedPack['product6']
                                                ?['title'] ??
                                            '',
                                        amount6: selectedPack['product6']
                                                ?['amount'] ??
                                            '',
                                      );
                                    } else if (popularRelatedProducts.isEmpty) {
                                      return const Center(
                                        child: Text('No Products...'),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 206,
                              color: const Color(0xffEEEEEE),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 63,
                                    width: 84,
                                    color: const Color(0xffC4C4C4),
                                    child: Center(
                                      child: Image.network(
                                        popularRelatedProducts['imageUrl'][0],
                                        height: 50,
                                        width: 60,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text:
                                            '${popularRelatedProducts['title']}\n',
                                        style: const TextStyle(
                                          fontFamily: 'CenturyGothic',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.fontColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '₹${popularRelatedProducts['price']}',
                                            style: const TextStyle(
                                              fontFamily: 'CenturyGothic',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.buttonBgColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const VerticalSpeacing(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
