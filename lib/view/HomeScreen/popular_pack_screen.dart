// ignore_for_file: use_build_context_synchronously

import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapbar.dart';
import 'package:citta_23/view/HomeScreen/bundle_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';
import 'widgets/homeCard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PopularPackScreen extends StatefulWidget {
  const PopularPackScreen({super.key, required this.title});
  final String title;
  @override
  State<PopularPackScreen> createState() => _PopularPackScreenState();
}

bool isTrue = false;
bool _isLoading = false;
final _firestoreInstance = FirebaseFirestore.instance;

class _PopularPackScreenState extends State<PopularPackScreen> {
  final List<Map<String, dynamic>> _popularPacks = [];
  fetchPopularPack() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn =
          await _firestoreInstance.collection('bundle pack').get();

      setState(() {
        _popularPacks.clear();
        for (var doc in qn.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Access individual products in the bundle
          Map<String, dynamic> product1 = data['product1'] ?? {};
          Map<String, dynamic> product2 = data['product2'] ?? {};
          Map<String, dynamic> product3 = data['product3'] ?? {};
          Map<String, dynamic> product4 = data['product4'] ?? {};
          Map<String, dynamic> product5 = data['product5'] ?? {};
          Map<String, dynamic> product6 = data['product6'] ?? {};

          _popularPacks.add({
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
            // simple card
            'sellerId': data['sellerId'],
            'id': data['id'],
            'imageUrl': data['imageUrl'][0],
            'title': data['title'],
            'price': data['price'],
            'salePrice': data['salePrice'] ?? '',
            'detail': data['detail'],
            'weight': data['weight'] ?? '',
            'size': data['size'],
            'averageReview': data['averageReview'] ?? 0.0,
          });
        }
      });

      return qn.docs;
    } catch (e) {
      // Log the error or handle it as necessary
      debugPrint('Error fetching popular packs: $e');
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
      String productId, String weight, String size) async {
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
        'weight': weight,
        'color': "N/A",
        'dPrice': "0",
        'size': size,
        // Add other product details as needed
      });
      Utils.snackBar('Successfully added to cart', context);
    }
  }

  @override
  initState() {
    super.initState();
    fetchPopularPack();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: _isLoading,
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height / 7,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.createmyownpackscreen,
                  );
                },
                child: Container(
                  height: 52,
                  color: AppColor.primaryColor,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColor.buttonTxColor,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Create Own Pack",
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.buttonTxColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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
            ),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'CenturyGothic',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _popularPacks.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16, // Horizontal spacing
                    mainAxisSpacing: 12, // Vertical spacing
                  ),
                  itemBuilder: (_, index) {
                    // Check if _products is not empty and index is within valid range
                    if (_popularPacks.isNotEmpty &&
                        index < _popularPacks.length) {
                      return HomeCard(
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                // Check if _popularPacks is not null and index is within bounds
                                if (_popularPacks.isNotEmpty &&
                                    index >= 0 &&
                                    index < _popularPacks.length) {
                                  Map<String, dynamic> selectedPack =
                                      _popularPacks[index];
                                  return BundleProductScreen(
                                    imageUrl: selectedPack['imageUrl'] ?? '',
                                    productId: selectedPack['id'] ?? "",
                                    sellerId: selectedPack['sellerId'] ?? '',
                                    title: selectedPack['title'] ?? '',
                                    price: selectedPack['price'] ?? '',
                                    saleprice: selectedPack['salePrice'] ?? '',
                                    detail: selectedPack['detail'] ?? '',
                                    weight: selectedPack['weight'] ?? '',
                                    size: selectedPack['size'] ?? '',
                                    img1: selectedPack['product1']?['image'] ??
                                        '',
                                    title1: selectedPack['product1']
                                            ?['title'] ??
                                        '',
                                    amount1: selectedPack['product1']
                                            ?['amount'] ??
                                        '',
                                    img2: selectedPack['product2']?['image'] ??
                                        '',
                                    title2: selectedPack['product2']
                                            ?['title'] ??
                                        '',
                                    amount2: selectedPack['product2']
                                            ?['amount'] ??
                                        '',
                                    img3: selectedPack['product3']?['image'] ??
                                        '',
                                    title3: selectedPack['product3']
                                            ?['title'] ??
                                        '',
                                    amount3: selectedPack['product3']
                                            ?['amount'] ??
                                        '',
                                    img4: selectedPack['product4']?['image'] ??
                                        '',
                                    title4: selectedPack['product4']
                                            ?['title'] ??
                                        '',
                                    amount4: selectedPack['product4']
                                            ?['amount'] ??
                                        '',
                                    img5: selectedPack['product5']?['image'] ??
                                        '',
                                    title5: selectedPack['product5']
                                            ?['title'] ??
                                        '',
                                    amount5: selectedPack['product5']
                                            ?['amount'] ??
                                        '',
                                    img6: selectedPack['product6']?['image'] ??
                                        '',
                                    title6: selectedPack['product6']
                                            ?['title'] ??
                                        '',
                                    amount6: selectedPack['product6']
                                            ?['amount'] ??
                                        '',
                                  );
                                } else {
                                  Utils.flushBarErrorMessage(
                                      'error occure while fetching bundle products',
                                      context);
                                }
                                return Container();
                              },
                            ),
                          );
                        },
                        sellerId: _popularPacks[index]['sellerId'].toString(),
                        productId: _popularPacks[index]['id'].toString(),
                        name: _popularPacks[index]['title'].toString(),
                        price: _popularPacks[index]['price'].toString(),
                        dPrice: _popularPacks[index]['salePrice'].toString(),
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.appBarButtonColor,
                        img: _popularPacks[index]['imageUrl'][0],
                        iconColor: AppColor.buttonBgColor,
                        // add to cart logic
                        addCart: () {
                          if (_popularPacks.isNotEmpty &&
                              index >= 0 &&
                              index < _popularPacks.length) {
                            addToCart(
                              _popularPacks[index]['imageUrl'][0],
                              _popularPacks[index]['title'],
                              _popularPacks[index]['salePrice'],
                              _popularPacks[index]['sellerId'],
                              _popularPacks[index]['id'],
                              _popularPacks[index]['weight'],
                              _popularPacks[index]['size'],
                            );
                          }
                        },
                        productRating:
                            _popularPacks[index]['averageReview'] ?? 0.0,
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Shimmer(
                          duration: const Duration(seconds: 3),
                          interval: const Duration(seconds: 5),
                          color: AppColor.grayColor
                              .withOpacity(0.2), //Default value
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
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
