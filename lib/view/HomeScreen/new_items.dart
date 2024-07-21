import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
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
  void addToCart(
      String img,
      String title,
      String dPrice,
      String sellerId,
      String productId,
      String weight,
      String disPrice,
      String color,
      String size) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Utils.snackBar('Please SignUp first', context);
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
        'salePrice': dPrice,
        'deleteId': uuid,
        'size': 'N/A',
        'color': 'N/A',
        'weight': weight,
        'dPrice': disPrice,
        // Add other product details as needed
      });
      Utils.snackBar('Successfully added to cart', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String calculateDiscountedPrice(
        String originalPriceString, String discountPercentageString) {
      // Convert strings to double

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
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        itemCount: widget.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return HomeCard(
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    var product = widget.products[index];
                    // Handle size and color fields
                    List<String> sizes = product['size'] is List
                        ? List<String>.from(product['size'])
                        : ['N/A'];
                    List<String> colors = product['color'] is List
                        ? List<String>.from(product['color'])
                        : ['N/A'];

                    // Determine which screen to navigate to
                    return sizes.isNotEmpty && sizes[0] != 'N/A'
                        ? FashionDetail(
                            title: product['title'].toString(),
                            imageUrl: product['imageUrl'],
                            salePrice: product['category'] == "Lightening Deals"
                                ? calculateDiscountedPrice(
                                    product['price'].toString(),
                                    product['discount'].toString(),
                                  )
                                : product['price'].toString(),
                            detail: product['detail'].toString(),
                            sellerId: product['sellerId'].toString(),
                            productId: product['id'].toString(),
                            colors: colors,
                            sizes: sizes,
                            price: product['price'].toString(),
                            disPrice: product['category'] == "Lightening Deals"
                                ? dPrice(product['discount'], product['price'])
                                : "0",
                          )
                        : ProductDetailScreen(
                            title: product['title'].toString(),
                            productId: product['id'].toString(),
                            sellerId: product['sellerId'].toString(),
                            imageUrl: product['imageUrl'],
                            price: product['price'].toString(),
                            salePrice: product['category'] == "Lightening Deals"
                                ? calculateDiscountedPrice(
                                    product['price'].toString(),
                                    product['discount'].toString(),
                                  )
                                : product['price'].toString(),
                            weight: product.containsKey('weight') &&
                                    product['weight'] != null &&
                                    product['weight'].toString().isNotEmpty
                                ? product['weight'].toString()
                                : 'N/A',
                            detail: product['detail'].toString(),
                            disPrice: product['category'] == "Lightening Deals"
                                ? dPrice(product['discount'], product['price'])
                                : "0",
                          );
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
            img: widget.products[index]['imageUrl'][0],
            iconColor: AppColor.buttonBgColor,
            addCart: () {
              var product = widget.products[index];

              // Handle size and color fields
              List<String> sizes = product['size'] is List
                  ? List<String>.from(product['size'])
                  : ['N/A'];
              List<String> colors = product['color'] is List
                  ? List<String>.from(product['color'])
                  : ['N/A'];

              // Log size and color to ensure they are correct

              // Adding to cart
              addToCart(
                product['imageUrl'][0],
                product['title'],
                product['price'],
                product['sellerId'],
                product['id'],
                product.containsKey('weight') &&
                        product['weight'] != null &&
                        product['weight'].toString().isNotEmpty
                    ? product['weight'].toString()
                    : 'N/A',
                product.containsKey('discount') &&
                        product['discount'] != null &&
                        product['discount'].isNotEmpty
                    ? dPrice(
                        product['price'].toString(),
                        product['discount'].toString(),
                      )
                    : "0",
                colors.isNotEmpty && colors[0] != 'N/A' ? colors[0] : 'N/A',
                sizes.isNotEmpty && sizes[0] != 'N/A' ? sizes[0] : 'N/A',
              );
            },
            productRating: widget.products[index]['averageReview'],
          );
        },
      ),
    );
  }
}
