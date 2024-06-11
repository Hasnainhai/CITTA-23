import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'product_detail_screen.dart';
import 'widgets/homeCard.dart';

// ignore: must_be_immutable
class CategoryProductsScreen extends StatefulWidget {
  CategoryProductsScreen(
      {super.key, required this.title, required this.products});

  String title;
  final List<Map<String, dynamic>> products;
  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool isTrue = true;
  void addToCart(String img, String title, String dPrice, String sellerId,
      String productId, String weight, String disPrice) async {
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
        'size': 'N/A',
        'color': 'N/A',
        'weight': weight,
        'dPrice': disPrice,
        // Add other product details as needed
      });
      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    String calculateDiscountedPrice(
        String originalPriceString, String discountPercentageString) {
      // Convert strings to double
      debugPrint("this is the discount:$discountPercentageString");
      debugPrint("this is the total:$originalPriceString");

      double originalPrice = double.parse(originalPriceString);
      double discountPercentage = double.parse(discountPercentageString);

      // Calculate discounted price
      double p = originalPrice * (discountPercentage / 100);
      double discountedPrice = originalPrice - p;

      // Return the discounted price as a formatted string
      return discountedPrice.toStringAsFixed(
          0); // You can adjust the number of decimal places as needed
    }

    String dPrice(String originalPriceString, String discountPercentageString) {
      // Convert strings to double
      debugPrint("this is the discount:$discountPercentageString");
      debugPrint("this is the total:$originalPriceString");

      double originalPrice = double.parse(originalPriceString);
      double discountPercentage = double.parse(discountPercentageString);

      // Calculate discounted price
      double discountedPrice = originalPrice * (discountPercentage / 100);

      // Return the discounted price as a formatted string
      return discountedPrice.toStringAsFixed(
          0); // You can adjust the number of decimal places as needed
    }

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
                        salePrice: widget.products[index]['category'] ==
                                "Lightening Deals"
                            ? calculateDiscountedPrice(
                                widget.products[index]['price'].toString(),
                                widget.products[index]['discount'].toString(),
                              )
                            : widget.products[index]['price'].toString(),
                        weight: widget.products[index]['weight'].toString(),
                        detail: widget.products[index]['detail'].toString(),
                        disPrice: widget.products[index]['category'] ==
                                "Lightening Deals"
                            ? dPrice(widget.products[index]['discount'],
                                widget.products[index]['price'])
                            : "0");
                  },
                ),
              );
            },
            productId: widget.products[index]['id'],
            sellerId: widget.products[index]['sellerId'],
            name: widget.products[index]['title'].toString(),
            price: widget.products[index]['price'].toString(),
            dPrice: widget.products[index]['category'] == "Lightening Deals"
                ? calculateDiscountedPrice(
                    widget.products[index]['price'].toString(),
                    widget.products[index]['discount'].toString(),
                  )
                : widget.products[index]['price'].toString(),
            borderColor: AppColor.buttonBgColor,
            fillColor: AppColor.appBarButtonColor,
            img: widget.products[index]['imageUrl'],
            iconColor: AppColor.buttonBgColor,
            addCart: () {
              addToCart(
                  widget.products[index]['imageUrl'],
                  widget.products[index]['title'],
                  widget.products[index]['price'],
                  widget.products[index]['sellerId'],
                  widget.products[index]['id'],
                  widget.products[index]['weight'],
                  widget.products[index]['category'] == "Lightening Deals"
                      ? dPrice(widget.products[index]['discount'],
                          widget.products[index]['price'])
                      : "0");
            },
          );
        },
      ),
    );
  }
}
