// ignore_for_file: use_build_context_synchronously
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/check_out.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/total_reviews.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/widgets/detail_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';

// ignore: must_be_immutable
class FashionDetail extends StatefulWidget {
  FashionDetail(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.salePrice,
      required this.detail,
      required this.sellerId,
      required this.productId,
      required this.colors,
      required this.sizes});

  final String title;
  final String imageUrl;
  String salePrice;
  final String detail;
  final String sellerId;
  final String productId;
  final List<String> colors;
  final List<String> sizes;

  @override
  State<FashionDetail> createState() => _FashionDetailState();
}

class _FashionDetailState extends State<FashionDetail> {
  bool like = false;
  int? newPrice;
  int items = 1;
  String size = 'small';
  String? addPrice;
  int? totalPrice;
  bool button1 = true;
  bool button2 = false;
  bool button3 = false;
  bool button4 = false;
  String? selectSize;
  String? color;
  bool button5 = false;
  bool button6 = false;

  final _firestoreInstance = FirebaseFirestore.instance;
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

  void addToCart(
    String img,
    String title,
    String dPrice,
    String sellerId,
    String productId,
    String size,
    String color,
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
        "size": size,
        "color": color,
        "weight": "N/A",
        'dPrice': disPrice,

        // Add other product details as needed
      });
      Utils.toastMessage('Successfully added to cart');
    }
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

  String? _selectedImageUrl;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedImageUrl = widget.imageUrl;
    fetchFashionRelatedProducts();
  }

  void _onColorTap(String imageUrl) {
    setState(() {
      _selectedImageUrl = imageUrl;
    });
  }

  void _onSizeTap(String size) {
    setState(() {
      _selectedSize = size;
    });
  }

  //fashion detail related products
  bool isLoading = false;
  final List _fashionRelatedProducts = [];
  fetchFashionRelatedProducts() async {
    try {
      setState(() {
        isLoading = true;
      });
      QuerySnapshot qn = await _firestoreInstance.collection('fashion').get();

      setState(() {
        _fashionRelatedProducts.clear();
        for (int i = 0; i < qn.docs.length; i++) {
          _fashionRelatedProducts.add({
            'sellerId': qn.docs[i]['sellerId'],
            'id': qn.docs[i]['id'],
            'imageUrl': qn.docs[i]['imageUrl'],
            'title': qn.docs[i]['title'],
            'price': qn.docs[i]['price'],
            'detail': qn.docs[i]['detail'],
            'color': qn.docs[i]['color'],
            'size': qn.docs[i]['size'],
          });
        }
      });
      return qn.docs;
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
          "Product Details",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.fontColor,
          ),
        ),
      ),
      body: SafeArea(
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
                                    : const Icon(Icons.favorite_border_rounded),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: SizedBox(
                            height: 250,
                            width: 250,
                            child: FancyShimmerImage(
                              imageUrl: _selectedImageUrl.toString(),
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
                          newPrice == null
                              ? "${widget.salePrice}₹"
                              : "$newPrice₹",
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ],
                    ),
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
                          items.toString(),
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
                const VerticalSpeacing(
                  20,
                ),
                const Text(
                  "Product Details",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grayColor,
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
                const Text(
                  "Colors:",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.fontColor,
                  ),
                ),
                const VerticalSpeacing(14),
                Wrap(
                  spacing: 8,
                  children: widget.colors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        _onColorTap(color);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          height: 40,
                          width: 44,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedImageUrl == color
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                          child: Center(
                            child: Image.network(color),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const VerticalSpeacing(
                  20,
                ),
                const Text(
                  "Sizes:",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.fontColor,
                  ),
                ),
                const VerticalSpeacing(14),
                Wrap(
                  spacing: 8,
                  children: widget.sizes.map((size) {
                    return GestureDetector(
                      onTap: () {
                        _onSizeTap(size);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedSize == size
                                ? AppColor.primaryColor
                                : Colors.grey,
                          ),
                        ),
                        child: Text(
                          size,
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const VerticalSpeacing(
                  14,
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
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            if (_selectedSize == null &&
                                _selectedImageUrl == null) {
                              Utils.toastMessage(
                                  "Please select size and color");
                            } else {
                              addToCart(
                                  widget.imageUrl,
                                  widget.title,
                                  widget.salePrice,
                                  widget.sellerId,
                                  widget.productId,
                                  _selectedSize!,
                                  _selectedImageUrl!,
                                  "0");
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
                                  productType: 'fashion',
                                  salePrice: newPrice == null
                                      ? widget.salePrice
                                      : newPrice.toString(),
                                  size: size,
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
                              productType: "fashion",
                              productId: widget.productId,
                              productPic: widget.imageUrl,
                            ),
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
                        .collection("fashion")
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
                ),
                const VerticalSpeacing(12),
                SizedBox(
                  height: 63,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _fashionRelatedProducts.length,
                    itemBuilder: (context, index) {
                      if (_fashionRelatedProducts.isEmpty) {
                        return const Center(
                          child: Text('Empty fashion products'),
                        );
                      } else {
                        final fashion = _fashionRelatedProducts[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FashionDetail(
                                sellerId: _fashionRelatedProducts[index]
                                    ['sellerId'],
                                productId: _fashionRelatedProducts[index]['id'],
                                title: _fashionRelatedProducts[index]['title']
                                    .toString(),
                                imageUrl: _fashionRelatedProducts[index]
                                    ['imageUrl'],
                                salePrice: _fashionRelatedProducts[index]
                                    ['price'],
                                detail: _fashionRelatedProducts[index]['detail']
                                    .toString(),
                                colors: _fashionRelatedProducts[index]['color']
                                    .cast<String>(),
                                sizes: _fashionRelatedProducts[index]['size']
                                    .cast<String>(),
                              );
                            }));
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
                                    child: Image.network(fashion['imageUrl']),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      text: '${fashion['title']}\n',
                                      style: const TextStyle(
                                        fontFamily: 'CenturyGothic',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.fontColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '₹${fashion['price']}',
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
        ),
      ),
    );
  }
}
