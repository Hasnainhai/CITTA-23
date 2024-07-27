// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/check_out.dart';
import 'package:citta_23/view/HomeScreen/all_related_prod.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/total_reviews.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/widgets/detail_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
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
    required this.sellerId,
    required this.disPrice,
  });

  final String title;
  final List<dynamic> imageUrl;
  final String price;
  String salePrice;
  final String weight;
  final String detail;
  final String productId;
  final String sellerId;
  final String disPrice;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool like = false;
  final _firestoreInstance = FirebaseFirestore.instance;
  int? newPrice;
  int items = 1;
  void increment() {
    setState(() {
      items++;

      int price = int.parse(widget.salePrice);
      newPrice = (newPrice ?? int.parse(widget.salePrice)) + price;
    });
  }

  void decrement() {
    setState(() {
      if (items > 1) {
        items--;
        int price = int.parse(widget.salePrice);
        newPrice = (newPrice ?? int.parse(widget.salePrice)) - price;
      } else {
        Utils.flushBarErrorMessage("Fixed Limit", context);
      }
    });
  }

  void addToFavorites(
      String discount, String weight, String color, String size) async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String uuid = const Uuid().v1();
      // Add the item to the 'favoriteList' collection
      await _firestoreInstance
          .collection('favoriteList')
          .doc(uid)
          .collection('favorites')
          .doc(uuid)
          .set({
        'title': widget.title.toString(),
        'salePrice': widget.price.toString(),
        'imageUrl': widget.imageUrl[0].toString(),
        'id': widget.productId.toString(),
        'sellerId': widget.sellerId,
        'deletedId': uuid,
        'discount': discount,
        'weight': weight,
        'color': color,
        'size': size,
      });
      // Display a success message or perform any other action
      Utils.snackBar('SuccessFully add to favourite', context);
    } catch (e) {
      // Handle errors
      Utils.flushBarErrorMessage('Error adding to favorites: $e', context);
    }
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
        'salePrice': dPrice,
        'deleteId': uuid,
        "size": "N/A",
        "color": "N/A",
        "weight": weight,
        'dPrice': disPrice,

        // Add other product details as needed
      });
      Utils.snackBar('Successfully added to cart', context);
    }
  }

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
          .where('id', isEqualTo: widget.productId.toString())
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

  //get related products
  final List<Map<String, dynamic>> _relatedProducts = [];
  bool _isLoading = false;
  fetchRelatedProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn = await _firestoreInstance.collection('products').get();
      debugPrint(
          'Data fetched from Firestore ${qn.docs}'); // Debugging statement

      setState(() {
        _relatedProducts.clear();

        for (var doc in qn.docs) {
          var data = doc.data() as Map<String, dynamic>?;

          if (data != null) {
            var product = {
              'sellerId': data['sellerId'],
              'id': data['id'],
              'imageUrl': data['imageUrl'],
              'title': data['title'],
              'price': data['price'],
              'detail': data['detail'],
              'weight': data['weight'],
              'category': data['category'],
            };

            if (data.containsKey('discount') && data['discount'] != null) {
              product['discount'] = data['discount'].toString();
            }

            debugPrint('Fetched product: $product'); // Debugging statement

            _relatedProducts.add(product);
          }
        }
        _isLoading = false;

        debugPrint('All Products: $_relatedProducts'); // Debugging statement
      });
    } catch (e) {
      debugPrint('Error fetching products: $e'); // Debugging statement
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
    fetchRelatedProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 8,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColor.fontColor,
                        ),
                      ),
                      const Text(
                        "Product Detail ",
                        style: const TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.fontColor,
                        ),
                      ),
                      Container(),
                    ],
                  ),
                  const VerticalSpeacing(8),
                  Container(
                    height: 350,
                    width: 400,
                    decoration: const BoxDecoration(
                      color: Color(0xffEEEEEE),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 14,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 340.0,
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
                                      width: 300,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          const Positioned(
                              bottom: 20, child: VerticalSpeacing(12)),
                          Positioned(
                            bottom: 12,
                            right: MediaQuery.of(context).size.width / 2.8,
                            child: AnimatedSmoothIndicator(
                              activeIndex: _currentIndex,
                              count: widget.imageUrl.length,
                              effect: const ScrollingDotsEffect(
                                dotWidth: 10.0,
                                dotHeight: 10.0,
                                activeDotColor: AppColor.primaryColor,
                                dotColor: Colors.grey,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            child: GestureDetector(
                              onTap: () {
                                // Toggle the value of like
                                setState(() {
                                  if (likeColor == Colors.transparent) {
                                    // Add to favorites
                                    addToFavorites(widget.disPrice,
                                        widget.weight, "N/A", "N/A");
                                    likeColor = AppColor.primaryColor;
                                  } else {
                                    // Remove from favorites
                                    removeFromFavorites();
                                    likeColor = Colors.transparent;
                                  }
                                });
                              },
                              child: Container(
                                height: 48,
                                width: 48,
                                child: likeColor == AppColor.primaryColor
                                    ? const Icon(
                                        Icons.favorite,
                                        color: AppColor.primaryColor,
                                      )
                                    : const Icon(Icons.favorite_border_rounded),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpeacing(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColor.fontColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.price,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColor.fontColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                newPrice == null
                                    ? "${widget.salePrice}₹"
                                    : "${newPrice.toString()}₹",
                                style: const TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  decrement();
                                },
                                child: Container(
                                    height: 24,
                                    width: 24,
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
                                "${items}Kg",
                                style: const TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.grayColor,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColor.primaryColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "Product Details",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColor.fontColor,
                    ),
                  ),
                  Text(
                    widget.detail,
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                  const VerticalSpeacing(12),
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
                              if (FirebaseAuth.instance.currentUser != null) {
                                addToCart(
                                    widget.imageUrl[0],
                                    widget.title,
                                    widget.price,
                                    widget.sellerId,
                                    widget.productId,
                                    items == 1
                                        ? widget.weight
                                        : items.toString(),
                                    widget.disPrice.toString());
                              } else {
                                showSignupDialog(context);
                              }
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
                              if (FirebaseAuth.instance.currentUser != null) {
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
                                      productType: "product",
                                      salePrice: newPrice == null
                                          ? widget.salePrice
                                          : newPrice.toString(),
                                      size: "N/A",
                                      quantity: items.toString(),
                                      color: "N/A",
                                    ),
                                  ),
                                );
                              } else {
                                showSignupDialog(context);
                              }
                            },
                            child: const Center(
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top reviews',
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.fontColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => TotalRatingScreen(
                                productType: "products",
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
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColor.buttonBgColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(8),
                  SizedBox(
                    height: 145,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("products")
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
                            child: Text(
                              'No comments and ratings available',
                              style: TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColor.fontColor,
                              ),
                            ),
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
                  const VerticalSpeacing(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Related products',
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
                              MaterialPageRoute(builder: (context) {
                            return const AllRelatedProd();
                          }));
                        },
                        child: const Text(
                          "See More",
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
                  const VerticalSpeacing(8),
                  SizedBox(
                    height: 63,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _relatedProducts.length,
                      itemBuilder: (context, index) {
                        if (_relatedProducts.isEmpty) {
                          return const Center(
                            child: Text('Empty related products'),
                          );
                        } else {
                          final categoryRelatedProducts =
                              _relatedProducts[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetailScreen(
                                      title: categoryRelatedProducts['title']
                                          .toString(),
                                      productId: categoryRelatedProducts['id']
                                          .toString(),
                                      sellerId:
                                          categoryRelatedProducts['sellerId']
                                              .toString(),
                                      imageUrl:
                                          categoryRelatedProducts['imageUrl'],
                                      price: categoryRelatedProducts['price']
                                          .toString(),
                                      salePrice: categoryRelatedProducts[
                                                  'category'] ==
                                              "Lightening Deals"
                                          ? calculateDiscountedPrice(
                                              categoryRelatedProducts['price'],
                                              categoryRelatedProducts[
                                                  'discount'])
                                          : categoryRelatedProducts['price']
                                              .toString(),
                                      weight: categoryRelatedProducts['weight']
                                          .toString(),
                                      detail: categoryRelatedProducts['detail']
                                          .toString(),
                                      disPrice: categoryRelatedProducts[
                                                  'category'] ==
                                              "Lightening Deals"
                                          ? (int.parse(categoryRelatedProducts[
                                                      'discount']) /
                                                  100 *
                                                  int.parse(
                                                      categoryRelatedProducts[
                                                          'price']))
                                              .toString()
                                          : '0',
                                    );
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
                                        categoryRelatedProducts['imageUrl'][0],
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
                                            '${categoryRelatedProducts['title']}\n',
                                        style: const TextStyle(
                                          fontFamily: 'CenturyGothic',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.fontColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '₹${categoryRelatedProducts['price']}',
                                            style: const TextStyle(
                                              fontFamily: 'CenturyGothic',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
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
                  const VerticalSpeacing(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
