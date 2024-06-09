// ignore_for_file: use_build_context_synchronously

import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/check_out.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/total_reviews.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/widgets/detail_rating.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/widgets/review_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';

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
  });

  final String title;
  final String imageUrl;
  final String price;
  String salePrice;
  final String weight;
  final String detail;
  final String productId;
  final String sellerId;

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

  void addToFavorites() async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth
          .instance.currentUser!.uid; // You need to implement this function
      String uuid = const Uuid().v1();
      // Add the item to the 'favoriteList' collection
      await _firestoreInstance
          .collection('favoriteList')
          .doc(uid)
          .collection('favorites')
          .doc(uuid)
          .set({
        'title': widget.title.toString(),
        'salePrice': widget.salePrice.toString(),
        'imageUrl': widget.imageUrl.toString(),
        'id': widget.productId.toString(),
        'sellerId': widget.sellerId,
        'deletedId': uuid
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
      Utils.toastMessage('SuccessFully removed from favourite');
    } catch (e) {
      // Handle errors
      Utils.flushBarErrorMessage('Error removing from favorites: $e', context);
      // print('Error removing from favorites: $e');
    }
  }

  //get related products
  List<Map<String, dynamic>> _relatedProducts = [];
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
          var product = {
            'sellerId': doc['sellerId'],
            'id': doc['id'],
            'imageUrl': doc['imageUrl'],
            'title': doc['title'],
            'price': doc['price'],
            'detail': doc['detail'],
            'weight': doc['weight'],
            'category': doc['category'],
          };

          debugPrint('Fetched product: $product'); // Debugging statement

          _relatedProducts.add(product);
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

  @override
  void initState() {
    fetchRelatedProducts();
    super.initState();
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
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.fontColor,
          ),
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
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
                                      : const Icon(
                                          Icons.favorite_border_rounded),
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
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.fontColor,
                    ),
                  ),
                  const VerticalSpeacing(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.price,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                newPrice == null
                                    ? "${widget.salePrice}₹"
                                    : "${newPrice.toString()}₹",
                                style: const TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
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
                                    height: 34,
                                    width: 34,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.grayColor,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpeacing(
                    20,
                  ),
                  const Text(
                    "Product Details",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                  const VerticalSpeacing(
                    8,
                  ),
                  Text(
                    widget.detail,
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grayColor,
                    ),
                  ),
                  const VerticalSpeacing(
                    20,
                  ),
                  const Divider(
                    color: Color(0xffECECEC),
                  ),
                  const VerticalSpeacing(
                    20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => TotalRatingScreen(
                              productType: "products",
                              productId: widget.productId),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Review",
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.fontColor,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () async {
                        //     await showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) => Rating(
                        //         productId: widget.productId,
                        //         productType: "products",
                        //       ),
                        //     );
                        //   },
                        //   child: const Text(
                        //     "Give Review",
                        //     style: TextStyle(
                        //       fontFamily: 'CenturyGothic',
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //       color: AppColor.fontColor,
                        //     ),
                        //   ),
                        // ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const VerticalSpeacing(
                    20,
                  ),

                  const Divider(
                    color: Color(0xffECECEC),
                  ),
                  const VerticalSpeacing(
                    28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(

                ),
                const VerticalSpeacing(
                  20,
                ),
                const VerticalSpeacing(
                  28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 8,
                      color: AppColor.primaryColor,
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_shopping_cart_outlined,
                              color: AppColor.whiteColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(

                        height: 50,
                        width: MediaQuery.of(context).size.width / 8,
                        color: AppColor.primaryColor,
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_shopping_cart_outlined,
                                color: AppColor.whiteColor,
                                size: 30,
                              ),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => CheckOutScreen(
                                    tile: widget.title,
                                    price: widget.salePrice,
                                    img: widget.imageUrl,
                                    id: widget.productId,
                                    customerId: widget.sellerId,
                                    weight: items.toString(),
                                    productType: "product",
                                    salePrice: newPrice == null
                                        ? widget.salePrice
                                        : newPrice.toString(),
                                    size: "Null",
                                  ),
                                ),
                              );
                            },
                            child: const Center(
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],

                    ),
                  ],
                ),
                const VerticalSpeacing(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top reviews',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                                productId: widget.productId),
                          ),
                        );
                      },
                      child: const Text(
                        "See More",
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.buttonBgColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(14),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No comments and ratings available'),
                        );
                      }

                      // Limit the number of items to 2
                      final limitedDocs = snapshot.data!.docs.take(2).toList();

                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: limitedDocs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> data =
                              limitedDocs[index].data() as Map<String, dynamic>;
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
                const VerticalSpeacing(13),
                const Text(
                  'Related products',
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.fontColor,

                  ),
                  const VerticalSpeacing(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top reviews',
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.fontColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "See More",
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.buttonBgColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const VerticalSpeacing(14),
                  // ReviewCard(
                  //     profilePic:
                  //         'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                  //     name: 'Hassnain haider',
                  //     rating: 5.toString(),
                  //     time: '12.20 Am',
                  //     comment: 'Good product'),
                  const VerticalSpeacing(13),
                  const Text(
                    'Related products',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.fontColor,
                    ),
                  ),
                  const VerticalSpeacing(12),
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
                                      salePrice:
                                          categoryRelatedProducts['price'],
                                      weight: categoryRelatedProducts['weight']
                                          .toString(),
                                      detail: categoryRelatedProducts['detail']
                                          .toString(),
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
                                          categoryRelatedProducts['imageUrl']),
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.fontColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '₹${categoryRelatedProducts['price']}',
                                            style: const TextStyle(
                                              fontFamily: 'CenturyGothic',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
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
                const VerticalSpeacing(40),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
