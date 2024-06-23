// ignore_for_file: library_private_types_in_public_api

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

import '../HomeScreen/fashion_detail.dart';
import '../HomeScreen/product_detail_screen.dart';

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

  Future<List<Map<String, dynamic>>> fetchFashionProducts() async {
    List<Map<String, dynamic>> fashionProducts = [];

    try {
      QuerySnapshot fashionSnapshot =
          await FirebaseFirestore.instance.collection('fashion').get();

      for (var doc in fashionSnapshot.docs) {
        fashionProducts.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Utils.flushBarErrorMessage(
          'Error fetching fashion products: $e', context);
    }

    return fashionProducts;
  }

  Future<List<Map<String, dynamic>>> fetchFoodProducts() async {
    List<Map<String, dynamic>> foodProducts = [];

    try {
      QuerySnapshot foodSnapshot =
          await FirebaseFirestore.instance.collection('products').get();

      for (var doc in foodSnapshot.docs) {
        foodProducts.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Utils.flushBarErrorMessage('Error fetching food products: $e', context);
    }

    return foodProducts;
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
                          isScrollable: true,
                          labelColor: AppColor.primaryColor,
                          unselectedLabelColor: AppColor.fontColor,
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
                height: 400,
                child: TabBarView(
                  children: [
                    _buildRecommendedTab(context),
                    _buildFoodTab(context),
                    _buildFashionTab(context),
                  ],
                ),
              ),
              Consumer<TotalPriceModel>(
                builder: (context, totalPriceModel, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, right: 25),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      color: AppColor.appBarButtonColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    color: AppColor.grayColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (c) {
                                    return CardCheckOutScreen(
                                      productType: 'cart',
                                      productList: widget.productList,
                                      subTotal:
                                          totalPriceModel.totalPrice.toString(),
                                    );
                                  }),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(),
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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

  Widget _buildFoodTab(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchFoodProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching food products'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No food products found'));
        }

        final foodProducts = snapshot.data!;

        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: foodProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 4 / 4,
          ),
          itemBuilder: (context, index) {
            final product = foodProducts[index];
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
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductDetailScreen(
                        title: product['title'].toString(),
                        productId: product['id'].toString(),
                        sellerId: product['sellerId'].toString(),
                        imageUrl: product['imageUrl'],
                        price: product['category'] == "Lightening Deals"
                            ? "${calculateDiscountedPrice(product['price'], product['discount'])}₹"
                            : product['price'] + '₹',
                        salePrice: product['price'].toString(),
                        weight: product['weight'].toString(),
                        detail: product['detail'].toString(),
                        disPrice: product['category'] == "Lightening Deals"
                            ? (int.parse(product['discount']) /
                                    100 *
                                    int.parse(product['price']))
                                .toString()
                            : '0',
                      );
                    },
                  ),
                );
              },
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

  Widget _buildFashionTab(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchFashionProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching fashion products'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No fashion products found'));
        }

        final fashionProducts = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: fashionProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 4 / 4,
          ),
          itemBuilder: (context, index) {
            final product = fashionProducts[index];
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
              ontap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FashionDetail(
                    price: product['price'],
                    title: product['title'].toString(),
                    imageUrl: product['imageUrl'],
                    salePrice: product['category'] == "Lightening Deals"
                        ? calculateDiscountedPrice(
                            product['price'], product['discount'])
                        : product['price'].toString(),
                    detail: product['detail'].toString(),
                    sellerId: product['sellerId'],
                    productId: product['id'],
                    colors: product['color'].cast<String>(),
                    sizes: product['size'].cast<String>(),
                    disPrice: product['category'] == "Lightening Deals"
                        ? (int.parse(product['discount']) /
                                100 *
                                int.parse(product['price']))
                            .toString()
                        : '0',
                  );
                }));
              },
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
}
