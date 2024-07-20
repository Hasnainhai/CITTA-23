import 'package:citta_23/repository/menu_repository.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/consts/vars.dart';
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

class MenuDefaultSection extends StatefulWidget {
  const MenuDefaultSection({super.key});

  @override
  State<MenuDefaultSection> createState() => _MenuDefaultSectionState();
}

class _MenuDefaultSectionState extends State<MenuDefaultSection> {
  CategoryType? categoryType;
  late CollectionReference _collectionReference;
  String productType = 'food';
  bool isTrue = true;

  void _handleFoodButton() {
    // Change the collection to 'products'
    setState(() {
      productType = 'food';
      _collectionReference = FirebaseFirestore.instance.collection('products');
    });
  }

  void _handleFashionButton() {
    // Change the collection to 'fashion'
    setState(() {
      productType = 'fashion';
      _collectionReference = FirebaseFirestore.instance.collection('fashion');
    });
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

  String calculateDiscountedPrice(
      String originalPriceString, String discountPercentageString) {
    // Convert strings to double
    debugPrint("this is the discount: $discountPercentageString");
    debugPrint("this is the total: $originalPriceString");

    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);

    // Calculate discounted price
    double p = originalPrice * (discountPercentage / 100);
    double discountedPrice = originalPrice - p;
    String orPrice = discountedPrice.toInt().toString();
    // Convert to integer to remove decimal places and then back to string
    return orPrice;
  }

  // popUp
  void showSignupDialog(BuildContext context) {
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
      String weight,
      String color,
      String disPrice) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      showSignupDialog(context);
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
        "size": size,
        'weight': weight,
        'dPrice': disPrice,
        'color': color,
        // Add other product details as needed
      });
      Utils.snackBar('Successfully added to cart', context);
    }
  }

  @override
  void initState() {
    super.initState();
    _collectionReference = FirebaseFirestore.instance.collection('products');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuRepository>(
      builder: (context, menuRepository, child) {
        return Expanded(
          child: FutureBuilder<QuerySnapshot>(
              future: menuRepository.collectionReference.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var data = snapshot.data!.docs;
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                var item = data[index];
                                var productData =
                                    item.data() as Map<String, dynamic>;

                                var product = {
                                  'sellerId': productData['sellerId'],
                                  'id': productData['id'],
                                  'imageUrl': productData['imageUrl'],
                                  'title': productData['title'],
                                  'price': productData['price'],
                                  'detail': productData['detail'],
                                  'weight': productData['weight'],
                                  'averageReview':
                                      productData.containsKey('averageReview')
                                          ? productData['averageReview']
                                          : 0.0,
                                };

                                return menuRepository.productType == "food"
                                    ? HomeCard(
                                        oofProd: item['category'] ==
                                                'Lightening Deals'
                                            ? true
                                            : false,
                                        percentage: item['category'] ==
                                                'Lightening Deals'
                                            ? item['discount']
                                            : "0",
                                        name: item['title'],
                                        price: item['price'],
                                        dPrice: item['category'] ==
                                                'Lightening Deals'
                                            ? "${calculateDiscountedPrice(item['price'], item['discount'])}₹"
                                            : item['price'] + '₹',
                                        borderColor: AppColor.buttonBgColor,
                                        fillColor: AppColor.appBarButtonColor,
                                        img: item['imageUrl'][0],
                                        iconColor: AppColor.buttonBgColor,
                                        ontap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ProductDetailScreen(
                                                  title:
                                                      item['title'].toString(),
                                                  productId:
                                                      item['id'].toString(),
                                                  sellerId: item['sellerId']
                                                      .toString(),
                                                  imageUrl: item['imageUrl'],
                                                  price:
                                                      item['price'].toString(),
                                                  salePrice: item['category'] ==
                                                          'Lightening Deals'
                                                      ? calculateDiscountedPrice(
                                                          item['price'],
                                                          item['discount'])
                                                      : item['price'],
                                                  weight:
                                                      item['weight'].toString(),
                                                  detail:
                                                      item['detail'].toString(),
                                                  disPrice: item['category'] ==
                                                          "Lightening Deals"
                                                      ? (int.parse(item[
                                                                  'discount']) /
                                                              100 *
                                                              int.parse(item[
                                                                  'price']))
                                                          .toString()
                                                      : '0',
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        addCart: () {
                                          addToCart(
                                            item['imageUrl'][0],
                                            item['title'],
                                            item['price'],
                                            item['sellerId'],
                                            item['id'],
                                            'N/A',
                                            item['weight'],
                                            'N/A',
                                            item['category'] ==
                                                    "Lightening Deals"
                                                ? dPrice(item['price'],
                                                    item['discount'])
                                                : '0',
                                          );
                                        },
                                        productId: item['id'],
                                        sellerId: item['sellerId'],
                                        productRating: product['averageReview'],
                                      )
                                    : HomeCard(
                                        oofProd: item['category'] ==
                                                'Lightening Deals'
                                            ? true
                                            : false,
                                        percentage: item['category'] ==
                                                'Lightening Deals'
                                            ? item['discount']
                                            : "0",
                                        name: item['title'],
                                        price: item['price'] + "₹",
                                        dPrice: item['category'] ==
                                                'Lightening Deals'
                                            ? calculateDiscountedPrice(
                                                item['price'], item['discount'])
                                            : item['price'],
                                        borderColor: AppColor.buttonBgColor,
                                        fillColor: AppColor.appBarButtonColor,
                                        img: item['imageUrl'][0],
                                        iconColor: AppColor.buttonBgColor,
                                        ontap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return FashionDetail(
                                                  sellerId: item['sellerId'],
                                                  productId: item['id'],
                                                  title:
                                                      item['title'].toString(),
                                                  imageUrl: item['imageUrl'],
                                                  salePrice: item['category'] ==
                                                          "Lightening Deals"
                                                      ? calculateDiscountedPrice(
                                                          item['price'],
                                                          item['discount'])
                                                      : item['price']
                                                          .toString(),
                                                  price: item['price'],
                                                  detail:
                                                      item['detail'].toString(),
                                                  colors: List<String>.from(
                                                      item['color']),
                                                  sizes: List<String>.from(
                                                      item['size']),
                                                  disPrice: item['category'] ==
                                                          "Lightening Deals"
                                                      ? (int.parse(item[
                                                                  'discount']) /
                                                              100 *
                                                              int.parse(item[
                                                                  'price']))
                                                          .toString()
                                                      : '0',
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        addCart: () {
                                          addToCart(
                                            item['imageUrl'][0],
                                            item['title'],
                                            item['price'],
                                            item['sellerId'],
                                            item['id'],
                                            item['size'][0],
                                            'N/A',
                                            item['color'][0],
                                            item['category'] ==
                                                    "Lightening Deals"
                                                ? dPrice(item['price'],
                                                    item['discount'])
                                                : '0',
                                          );
                                        },
                                        productId: item['id'],
                                        sellerId: item['sellerId'],
                                        productRating: product['averageReview'],
                                      );
                              }),
                        ),
                      ),
                    ],
                  );
                }
              }),
        );
      },
    );
  }
}
