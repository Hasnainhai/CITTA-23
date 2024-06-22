import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:citta_23/models/index_model.dart';
import 'package:citta_23/models/sub_total_model.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/view/Checkout/widgets/card_checkout_screen.dart';

class ForgetAnythingBottomSheet extends StatefulWidget {
  const ForgetAnythingBottomSheet({
    super.key,
    required this.subTotal,
    required this.productList,
  });

  final String subTotal;
  final List<Map<String, dynamic>> productList;

  @override
  _ForgetAnythingBottomSheetState createState() =>
      _ForgetAnythingBottomSheetState();
}

class _ForgetAnythingBottomSheetState extends State<ForgetAnythingBottomSheet> {
  int subTotal = 0;
  int d = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  final CollectionReference _productsCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("cart");

  void _fetchData() {
    _productsCollection.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        int sum = 0;
        int discount = 0;

        for (var document in querySnapshot.docs) {
          String priceString = document['salePrice'];
          int priceInt = int.tryParse(priceString.split('.').first) ?? 0;
          sum += priceInt;

          var data = document.data() as Map<String, dynamic>?;
          if (data != null && data.containsKey('dPrice')) {
            String disPrice = data['dPrice'];
            int dP = int.tryParse(disPrice.split('.').first) ?? 0;
            discount += dP;
          }
        }

        setState(() {
          subTotal = sum;
          d = discount;
          Provider.of<SubTotalModel>(context, listen: false)
              .updateSubTotal(subTotal);
          Provider.of<DiscountSum>(context, listen: false).updateDisTotal(d);
          Provider.of<TotalPriceModel>(context, listen: false)
              .updateTotalPrice(subTotal, d);
          Provider.of<IndexModel>(context, listen: false).items;
          Provider.of<IndexModel>(context, listen: false)
              .updateIndex(querySnapshot.docs.length);
        });
      }
    }).catchError((error) {
      debugPrint("Error fetching data: $error");
    });
  }

  String calculateDiscountedPrice(
      String originalPriceString, String discountPercentageString) {
    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);
    double p = originalPrice * (discountPercentage / 100);
    double discountedPrice = originalPrice - p;
    return discountedPrice.toStringAsFixed(0);
  }

  String dPrice(String originalPriceString, String discountPercentageString) {
    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);
    double discountedPrice = originalPrice * (discountPercentage / 100);
    return discountedPrice.toStringAsFixed(0);
  }

  Future<List<Map<String, dynamic>>> fetchRelatedProducts(
      BuildContext context) async {
    List<Map<String, dynamic>> relatedProducts = [];

    try {
      QuerySnapshot fashionSnapshot =
          await FirebaseFirestore.instance.collection('fashion').get();
      QuerySnapshot productsSnapshot =
          await FirebaseFirestore.instance.collection('products').get();

      for (var doc in fashionSnapshot.docs) {
        relatedProducts.add(doc.data() as Map<String, dynamic>);
      }
      for (var doc in productsSnapshot.docs) {
        relatedProducts.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Utils.flushBarErrorMessage(
          'Error fetching related products: $e', context);
    }

    return relatedProducts;
  }

  Future<void> addToCart(
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
      Utils.toastMessage('Please SignUp first');
      return;
    }

    final userId = currentUser.uid;
    CollectionReference cartCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    QuerySnapshot cartSnapshot = await cartCollectionRef
        .where('imageUrl', isEqualTo: img)
        .limit(1)
        .get();

    if (cartSnapshot.docs.isNotEmpty) {
      Utils.toastMessage('Product is already in the cart');
    } else {
      var uuid = const Uuid().v1();
      await FirebaseFirestore.instance
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
        'size': size,
        'color': color,
        'dPrice': dprice,
      });
      _fetchData();

      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Forget Anything?",
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColor.fontColor,
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close,
                              color: AppColor.fontColor),
                        ),
                      ],
                    ),
                    const Text(
                      "You haven't finished checking out yet.\nDon't miss out anything?",
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColor.fontColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpeacing(16),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          isScrollable:
                              true, // Allows the TabBar to scroll if needed
                          labelColor: AppColor.primaryColor,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: AppColor.primaryColor,
                          tabs: [
                            Tab(text: "Recommended"),
                            Tab(text: "Food"),
                            Tab(text: "Fashion"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 400, // Adjust height as needed
                child: TabBarView(
                  children: [
                    _buildRecommendedTab(context),
                    _buildEmptyTab("Food"),
                    _buildEmptyTab("Fashion"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Consumer<TotalPriceModel>(
                builder: (context, totalPriceModel, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${totalPriceModel.totalPrice}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (c) {
                              return CardCheckOutScreen(
                                productType: 'cart',
                                productList: widget.productList,
                                subTotal: totalPriceModel.totalPrice.toString(),
                              );
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                        ),
                        child: const Text(
                          'Continue to checkout',
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedTab(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchRelatedProducts(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching related products'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No related products found'));
        }

        final relatedProducts = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: relatedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 4 / 4,
          ),
          itemBuilder: (context, index) {
            final product = relatedProducts[index];
            return HomeCard(
              name: product['title'],
              price: '\$${product['price']}',
              dPrice: product['category'] == "Lightening Deals"
                  ? "${calculateDiscountedPrice(product['price'], product['discount'])}₹"
                  : product['price'] + '₹',
              borderColor: AppColor.primaryColor,
              fillColor: AppColor.bgColor,
              img: product['imageUrl'],
              iconColor: AppColor.primaryColor,
              ontap: () {},
              addCart: () {
                addToCart(
                  product['imageUrl'],
                  product['title'],
                  product['price'],
                  product['sellerId'],
                  product['id'],
                  product.containsKey('size') ? product['size'][2] : 'N/A',
                  product.containsKey('color') ? product['color'][0] : 'N/A',
                  product.containsKey('weight') ? product['weight'] : 'N/A',
                  product.containsKey('discount')
                      ? dPrice(product['price'], product['discount'])
                      : '0',
                );
                _fetchData();
              },
              productId: product['id'],
              sellerId: product['sellerId'],
              productRating: product.containsKey('averageReview')
                  ? product['averageReview']
                  : 0.0,
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyTab(String category) {
    return Center(
      child: Text('No products available in $category category.'),
    );
  }
}

// void showCustomBottomSheet(BuildContext context, List<Map<String, dynamic>> productList, String subTotal) {
//   showModalBottomSheet(
//     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//     context: context,
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//         child: Container(
//           color: Colors.white.withOpacity(0.8),
//           padding: const EdgeInsets.only(top: 100),
//           child: ForgetAnythingBottomSheet(
//             productList: productList,
//             subTotal: subTotal,
//           ),
//         ),
//       );
//     },
//   );
// }
