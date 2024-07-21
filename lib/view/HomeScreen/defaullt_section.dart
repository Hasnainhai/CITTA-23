import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/vars.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/bundle_product_screen.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
import 'package:citta_23/view/HomeScreen/new_items.dart';
import 'package:citta_23/view/HomeScreen/popular_pack_screen.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uuid/uuid.dart';

import '../../routes/routes_name.dart';

class DefaultSection extends StatefulWidget {
  const DefaultSection({super.key});

  @override
  State<DefaultSection> createState() => _DefaultSectionState();
}

class _DefaultSectionState extends State<DefaultSection> {
  var categoryType = CategoryType.fashion;
  // final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;
  bool _isLoading = false;
  final List<Map<String, dynamic>> _newItems = [];
  final List<Map<String, dynamic>> _hotSelling = [];
  final List<Map<String, dynamic>> _lighteningDeals = [];
  final List<Map<String, dynamic>> _fashionnewItems = [];
  final List<Map<String, dynamic>> _fashionhotSelling = [];
  final List<Map<String, dynamic>> _fashionlighteningDeals = [];
  bool isSearch = false;
  @override
  initState() {
    super.initState();
    fetchCategoryProducts();
    fetchPopularPack();
    fetchFashionProducts();
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

  fetchCategoryProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn = await _firestoreInstance.collection('products').get();

      setState(() {
        _newItems.clear();
        _hotSelling.clear();
        _lighteningDeals.clear();

        for (var doc in qn.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          var product = {
            'sellerId': data['sellerId'],
            'id': data['id'],
            'imageUrl': data['imageUrl'],
            'title': data['title'],
            'price': data['price'],
            'detail': data['detail'],
            'weight': data['weight'],
            'category': data['category'],
            'averageReview': data['averageReview'] ?? 0.0, // Default to 0.0
          };

          switch (product['category']) {
            case 'New Items':
              _newItems.add(product);
              break;
            case 'Hot Selling':
              _hotSelling.add(product);
              break;
            case 'Lightening Deals':
              product['discount'] =
                  data['discount'] ?? 'N/A'; // Default to 'N/A'
              _lighteningDeals.add(product);
              break;
          }
        }

        // Ensure at least one product is added to _newItems and _hotSelling if initially empty
        if (_newItems.isEmpty || _hotSelling.isEmpty) {
          for (var doc in qn.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            var product = {
              'sellerId': data['sellerId'],
              'id': data['id'],
              'imageUrl': data['imageUrl'],
              'title': data['title'],
              'price': data['price'],
              'detail': data['detail'],
              'weight': data['weight'],
              'category': data['category'],
              'averageReview': data['averageReview'] ?? 0.0,
            };
            if (product['category'] == 'New Items' &&
                !_newItems.contains(product)) {
              _newItems.add(product);
            } else if (product['category'] == 'Hot Selling' &&
                !_hotSelling.contains(product)) {
              _hotSelling.add(product);
            }
          }
        }

        _isLoading = false;
      });
    } catch (e) {
      _isLoading = false;
    }
  }

  final List<Map<String, dynamic>> _popularPacks = [];
  List<dynamic> listedImages = [];

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
          debugPrint("this is the data map:${data.entries}");
          // Ensure imageUrl is a list of strings
          List<dynamic> imageUrl = List<dynamic>.from(data['imageUrl'] ?? []);

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
            'sellerId': data['sellerId'] ?? '',
            'id': data['id'] ?? '',
            'imageUrl': data['imageUrl'],
            'title': data['title'] ?? '',
            'price': data['price'] ?? '',
            'salePrice': data['salePrice'] ?? '',
            'detail': data['detail'] ?? '',
            'weight': data['weight'] ?? '',
            'size': data['size'] ?? '',
            'averageReview': data['averageReview'] ?? 0.0,
          });
          listedImages = data['imageUrl'];
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

  fetchFashionProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn = await _firestoreInstance.collection('fashion').get();

      setState(() {
        _fashionnewItems.clear();
        _fashionhotSelling.clear();
        _fashionlighteningDeals.clear();
        for (var doc in qn.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          var fashion = {
            'category': data['category'],
            'sellerId': data['sellerId'],
            'id': data['id'],
            'imageUrl': data['imageUrl'],
            'title': data['title'],
            'price': data['price'],
            'detail': data['detail'],
            'color': data['color'],
            'size': data['size'],
            'averageReview': data['averageReview'] ?? 0.0,
          };

          if (fashion['category'] == "Lightening Deals") {
            fashion['discount'] = data['discount'] ?? 'N/A';
            _fashionlighteningDeals.add(fashion);
            debugPrint("this is the discount:${fashion['discount']}");
            debugPrint("this is the fashion:${fashion.entries}");
          } else {
            switch (fashion['category']) {
              case 'New Items':
                _fashionnewItems.add(fashion);
                break;
              case 'Hot Selling':
                _fashionhotSelling.add(fashion);
                break;
            }
          }
        }

        if (_fashionnewItems.isEmpty || _fashionhotSelling.isEmpty) {
          for (var doc in qn.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            var product = {
              'category': data['category'],
              'sellerId': data['sellerId'],
              'id': data['id'],
              'imageUrl': data['imageUrl'],
              'title': data['title'],
              'price': data['price'],
              'detail': data['detail'],
              'color': data['color'],
              'size': data['size'],
              'averageReview': data['averageReview'] ?? 0.0,
            };
            if (product['category'] == "Lightening Deals") {
              product['discount'] = data['discount'] ?? 'N/A';
            }
            if (product['category'] == 'New Items' &&
                !_fashionnewItems.contains(product)) {
              _fashionnewItems.add(product);
            } else if (product['category'] == 'Hot Selling' &&
                !_fashionhotSelling.contains(product)) {
              _fashionhotSelling.add(product);
            }
          }
        }
      });
    } catch (e) {
      // Log the error or handle it as necessary
      debugPrint('Error fetching fashion products: $e');
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
        'weight': weight,
        "size": size,
        "color": color,
        "dPrice": dprice,
        // Add other product details as needed
      });
      Utils.snackBar('Successfully added to cart', context);
    }
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: _isLoading,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (categoryType == CategoryType.fashion) {
                    return;
                  }
                  setState(() {
                    categoryType = CategoryType.fashion;
                  });
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Center(
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: categoryType == CategoryType.fashion
                                ? AppColor.buttonBgColor
                                : Colors.transparent,
                            border: Border.all(
                                width: 1, color: AppColor.buttonBgColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 33.0,
                                width: 63.0,
                                color: AppColor.categoryLightColor,
                              ),
                              Text(
                                'Fashion',
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: categoryType == CategoryType.fashion
                                      ? AppColor.whiteColor
                                      : AppColor.buttonBgColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 0,
                      bottom: 12.0,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset(
                          'images/fashionimg.png',
                          height: 56.0,
                          width: 42.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (categoryType == CategoryType.food) {
                    return;
                  }
                  setState(() {
                    categoryType = CategoryType.food;
                  });
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Center(
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: categoryType == CategoryType.food
                                  ? AppColor.buttonBgColor
                                  : Colors.transparent,
                              border: Border.all(
                                  width: 1, color: AppColor.buttonBgColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 33.0,
                                width: 63.0,
                                color: AppColor.categoryLightColor,
                              ),
                              Text(
                                'Food',
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: categoryType == CategoryType.food
                                      ? AppColor.whiteColor
                                      : AppColor.buttonBgColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 0,
                      bottom: 5.0,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset(
                          'images/foodimg.png',
                          height: 59.0,
                          width: 59.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          categoryType == CategoryType.food
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular Pack",
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColor.fontColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const PopularPackScreen(
                                  title: 'Popular Pack');
                            }));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.buttonBgColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpeacing(12.0),
                    // Popular packs here
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4.7,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
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
                                        debugPrint(
                                            "this is the bundle pack list2:${_popularPacks[index]['image']}");
                                        return BundleProductScreen(
                                          imageUrl: listedImages,
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
                                      } else if (_popularPacks.isEmpty) {
                                        return const Center(
                                          child: Text('No Products...'),
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                );
                              },
                              sellerId:
                                  _popularPacks[index]['sellerId'].toString(),
                              productId: _popularPacks[index]['id'].toString(),
                              name: _popularPacks[index]['title'].toString(),
                              price: _popularPacks[index]['price'].toString(),
                              dPrice: "₹${_popularPacks[index]['price']}",
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
                                    _popularPacks[index]['price'],
                                    _popularPacks[index]['sellerId'],
                                    _popularPacks[index]['id'],
                                    "N/A",
                                    "N/A",
                                    _popularPacks[index]['weight'],
                                    "0",
                                  );
                                }
                              },
                              productRating:
                                  _popularPacks[index]['averageReview'] ?? 0.0,
                            );
                          } else {
                            // Handle the case when the list is empty or index is out of range
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Shimmer(
                                duration:
                                    const Duration(seconds: 3), //Default value
                                interval: const Duration(
                                    seconds:
                                        5), //Default value: Duration(seconds: 0)
                                color: AppColor.grayColor
                                    .withOpacity(0.2), //Default value
                                colorOpacity: 0.2, //Default value
                                enabled: true, //Default value
                                direction: const ShimmerDirection
                                    .fromLTRB(), //Default Value
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
                    Column(
                      children: [
                        _buildCategorySection(context, 'New Items', _newItems),
                        _buildCategorySection(
                            context, 'Hot Selling', _hotSelling),
                        _buildCategorySection(
                            context, 'Lightening Deals', _lighteningDeals),
                      ],
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      _buildFashionCategorySection(
                          context, 'New Items', _fashionnewItems),
                      _buildFashionCategorySection(
                          context, 'Hot Selling', _fashionhotSelling),
                      _buildFashionCategorySection(
                          context, 'Lightening Deals', _fashionlighteningDeals),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String category,
      List<Map<String, dynamic>> products) {
    final categoryProducts =
        products.where((product) => product['category'] == category).toList();
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontFamily: 'CenturyGothic',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.fontColor,
              ),
            ),
            InkWell(
              onTap: () {
                String title = category;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CategoryProductsScreen(
                    title: title,
                    products: products,
                  );
                }));
              },
              child: const Text(
                "View All",
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColor.buttonBgColor,
                ),
              ),
            ),
          ],
        ),
        const VerticalSpeacing(12),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4.7,
          child: categoryProducts.isEmpty
              ? Center(child: Text('No $category...'))
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      categoryProducts.length < 2 ? categoryProducts.length : 2,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (_, index) {
                    final product = categoryProducts[index];

                    return HomeCard(
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
                                price: product['price'].toString(),
                                salePrice: category == "Lightening Deals"
                                    ? calculateDiscountedPrice(
                                        product['price'], product['discount'])
                                    : product['price'].toString(),
                                weight: product['weight'].toString(),
                                detail: product['detail'].toString(),
                                disPrice: category == "Lightening Deals"
                                    ? (int.parse(product['discount']) /
                                            100 *
                                            int.parse(product['price']))
                                        .toStringAsFixed(0)
                                    : '0',
                              );
                            },
                          ),
                        );
                      },
                      percentage: category == "Lightening Deals"
                          ? product['discount'].toString()
                          : '',
                      oofProd: category == "Lightening Deals" ? true : false,
                      productId: product['id'],
                      sellerId: product['sellerId'],
                      name: product['title'].toString(),
                      price: product['price'].toString(),
                      dPrice: category == "Lightening Deals"
                          ? "${calculateDiscountedPrice(product['price'], product['discount'])}₹"
                          : product['price'].toString(),
                      borderColor: AppColor.buttonBgColor,
                      fillColor: AppColor.appBarButtonColor,
                      img: product['imageUrl'][0],
                      iconColor: AppColor.buttonBgColor,
                      addCart: () {
                        if (categoryProducts.isNotEmpty &&
                            index >= 0 &&
                            index < categoryProducts.length) {
                          addToCart(
                            product['imageUrl'][0],
                            product['title'],
                            product['price'].toString(),
                            product['sellerId'],
                            product['id'],
                            "N/A",
                            "N/A",
                            product['weight'],
                            category == "Lightening Deals"
                                ? dPrice(product['price'], product['discount'])
                                : '0',
                          );
                        }
                      },
                      productRating: product['averageReview'] ?? 0.0,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFashionCategorySection(BuildContext context, String category,
      List<Map<String, dynamic>> products) {
    final categoryProducts =
        products.where((product) => product['category'] == category).toList();
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontFamily: 'CenturyGothic',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.fontColor,
              ),
            ),
            InkWell(
              onTap: () {
                String title = category;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CategoryProductsScreen(
                    title: title,
                    products: products,
                  );
                }));
              },
              child: const Text(
                "View All",
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColor.buttonBgColor,
                ),
              ),
            ),
          ],
        ),
        const VerticalSpeacing(12),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4.7,
          child: categoryProducts.isEmpty
              ? Center(child: Text('No $category...'))
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      categoryProducts.length < 2 ? categoryProducts.length : 2,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (_, index) {
                    final product = categoryProducts[index];

                    return HomeCard(
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FashionDetail(
                            sellerId: product['sellerId'],
                            productId: product['id'],
                            title: product['title'].toString(),
                            imageUrl: product['imageUrl'],
                            salePrice: category == "Lightening Deals"
                                ? calculateDiscountedPrice(
                                    product['price'], product['discount'])
                                : product['price'].toString(),
                            detail: product['detail'].toString(),
                            colors: product['color'].cast<String>(),
                            sizes: product['size'].cast<String>(),
                            price: product['price'],
                            disPrice: product['category'] == "Lightening Deals"
                                ? (int.parse(product['discount']) /
                                        100 *
                                        int.parse(product['price']))
                                    .toStringAsFixed(0)
                                : '0',
                          );
                        }));
                      },
                      percentage: category == "Lightening Deals"
                          ? product['discount'].toString()
                          : '',
                      oofProd: category == "Lightening Deals" ? true : false,
                      sellerId: product['sellerId'],
                      productId: product['id'],
                      name: product['title'].toString(),
                      price: '${product['price']}₹',
                      dPrice: category == "Lightening Deals"
                          ? "${calculateDiscountedPrice(product['price'], product['discount'])}₹"
                          : product['price'].toString(),
                      borderColor: AppColor.buttonBgColor,
                      fillColor: AppColor.appBarButtonColor,
                      img: product['imageUrl'][0],
                      iconColor: AppColor.buttonBgColor,
                      addCart: () {
                        debugPrint(
                            "this is the product of fashion:${product.toString()}");
                        if (categoryProducts.isNotEmpty &&
                            index >= 0 &&
                            index < categoryProducts.length) {
                          // Utils.flushBarErrorMessage(
                          //   "this is the id:${product['sellerId']}",
                          //   context,
                          // );
                          addToCart(
                            product['imageUrl'][0],
                            product['title'],
                            product['price'],
                            product['sellerId'],
                            product['id'],
                            product['size'][0],
                            product['color'][0],
                            "N/A",
                            product['category'] == "Lightening Deals"
                                ? dPrice(product['price'], product['discount'])
                                : '0',
                          );
                        }
                      },
                      productRating: product['averageReview'],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
