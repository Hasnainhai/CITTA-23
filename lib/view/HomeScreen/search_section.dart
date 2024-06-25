import 'package:citta_23/models/search_model.dart';
import 'package:citta_23/repository/search_repository.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  String calculateDiscountedPrice(
      String originalPriceString, String discountPercentageString) {
    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);
    double discountedPrice =
        originalPrice - (originalPrice * (discountPercentage / 100));
    return discountedPrice.toStringAsFixed(0);
  }

  void showSignupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          shape: const RoundedRectangleBorder(),
          icon: const Icon(
            Icons.no_accounts_outlined,
            size: 80,
            color: AppColor.primaryColor,
          ),
          title: const Text('You don\'t have any account, please'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.loginscreen);
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ),
              const SizedBox(height: 12.0), // Vertical spacing
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(),
                  side: const BorderSide(
                    color: AppColor.primaryColor, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.registerScreen);
                },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addToCart(
      String img,
      String title,
      String dPrice,
      String sellerId,
      String productId,
      String size,
      String color,
      String weight,
      String dprice) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      showSignupDialog();
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
        'weight': weight,
        "size": size,
        "color": color,
        "dPrice": dprice,
        // Add other product details as needed
      });
      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.6,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 16,
        ),
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) {
          Product product = productProvider.products[index];

          return HomeCard(
            oofProd: product.discount != "N/A" ? true : false,
            percentage: product.discount,
            ontap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return product.isFashion
                    ? FashionDetail(
                        sellerId: product.sellerId,
                        productId: product.id,
                        title: product.title,
                        imageUrl: product.imageUrl,
                        salePrice: product.discount != "N/A"
                            ? calculateDiscountedPrice(
                                product.price, product.discount)
                            : product.price,
                        detail: product.detail,
                        colors: product.colors,
                        sizes: product.sizes,
                        price: product.price,
                        disPrice: product.discount != "N/A"
                            ? (int.parse(product.discount) /
                                    100 *
                                    int.parse(product.price))
                                .toStringAsFixed(0)
                            : '0',
                      )
                    : ProductDetailScreen(
                        title: product.title,
                        productId: product.id,
                        sellerId: product.sellerId,
                        imageUrl: product.imageUrl,
                        price: product.price,
                        salePrice: product.discount != "N/A"
                            ? calculateDiscountedPrice(
                                product.price, product.discount)
                            : product.price,
                        weight: product.weight,
                        detail: product.detail,
                        disPrice: product.discount != "N/A"
                            ? (int.parse(product.discount) /
                                    100 *
                                    int.parse(product.price))
                                .toStringAsFixed(0)
                            : '0',
                      );
              }));
            },
            sellerId: product.sellerId,
            productId: product.id,
            name: product.title,
            price: product.price,
            dPrice: product.discount != "N/A"
                ? calculateDiscountedPrice(product.price, product.discount)
                : product.price,
            borderColor: AppColor.buttonBgColor,
            fillColor: AppColor.appBarButtonColor,
            img: product.imageUrl,
            iconColor: AppColor.buttonBgColor,
            addCart: () {
              addToCart(
                product.imageUrl,
                product.title,
                product.price,
                product.sellerId,
                product.id,
                product.sizes.isNotEmpty ? product.sizes[0] : "N/A",
                product.colors.isNotEmpty ? product.colors[0] : "N/A",
                product.weight,
                product.discount != "N/A"
                    ? (int.parse(product.discount) /
                            100 *
                            int.parse(product.price))
                        .toStringAsFixed(0)
                    : '0',
              );
            },
            productRating: product.averageReview,
          );
        },
      ),
    );
  }
}
