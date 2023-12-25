// ignore_for_file: use_build_context_synchronously

import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/check_out.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:citta_23/view/HomeScreen/widgets/increase_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../routes/routes_name.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.salePrice,
    required this.weight,
    required this.detail,
    required this.productId,
    required this.sallerId,
  });

  final String title;
  final String imageUrl;
  final String price;
  String salePrice;
  final String weight;
  final String detail;
  final String productId;
  final String sallerId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool like = false;
  final _firestoreInstance = FirebaseFirestore.instance;

  void addToFavorites() async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth
          .instance.currentUser!.uid; // You need to implement this function

      // Add the item to the 'favoriteList' collection
      await _firestoreInstance
          .collection('favoriteList')
          .doc(uid)
          .collection('favorites')
          .add({
        'title': widget.title.toString(),
        'salePrice': widget.salePrice.toString(),
        'imageUrl': widget.imageUrl.toString(),
        // 'isLike': like,
      });
      // Display a success message or perform any other action
      Utils.toastMessage('SuccessFully add to favourite');
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
      Utils.toastMessage('SuccessFully removed from favourite');
    } catch (e) {
      // Handle errors
      Utils.flushBarErrorMessage('Error removing from favorites: $e', context);
      // print('Error removing from favorites: $e');
    }
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const DashBoardScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.fontColor,
            )),
        title: Text(
          "Product Details",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 26,
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
                                    addToFavorites();
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
                                    : const Icon(Icons.favorite_border_rounded),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: SizedBox(
                            height: 250,
                            width: 250,
                            child: FancyShimmerImage(
                              imageUrl: widget.imageUrl,
                              boxFit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpeacing(30),
                Text(
                  widget.title,
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(16),
                Text(
                  "Weight: ${widget.weight}",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(
                  28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.price,
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.salePrice,
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IncreaseContainer(
                      price: widget.salePrice,
                      onPriceChanged: (updatedPrice) {
                        setState(() {
                          widget.salePrice = updatedPrice.toString();
                        });
                      },
                    ),
                  ],
                ),
                const VerticalSpeacing(
                  20,
                ),
                Text(
                  "Product Details",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(
                  8,
                ),
                Text(
                  widget.detail,
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grayColor,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.totalreviewscreen,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                const VerticalSpeacing(
                  28,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   RoutesName.checkOutScreen,
                          // );
                          print(widget.sallerId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => CheckOutScreen(
                                tile: widget.title,
                                price: widget.price,
                                img: widget.imageUrl,
                                id: widget.productId,
                                customerId: widget.sallerId,
                                weight: widget.weight,
                                salePrice: widget.salePrice,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 60,
                          color: Colors.white,
                          child: const Icon(Icons.shopping_bag_outlined),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Buy Now",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(
                  40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
