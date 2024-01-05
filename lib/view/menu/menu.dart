import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
import 'package:citta_23/view/HomeScreen/new_items.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';
import '../../res/consts/vars.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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

  void addToCart(String img, String title, String dPrice, String sellerId,
      String productId) async {
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
        // Add other product details as needed
      });
      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  void initState() {
    super.initState();
    _collectionReference = FirebaseFirestore.instance.collection('products');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerticalSpeacing(50.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Choose a Category',
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: AppColor.fontColor,
                ),
              ),
            ),
            const VerticalSpeacing(30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    _handleFoodButton();
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width * 0.43,
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
                                    fontWeight: FontWeight.bold,
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
                InkWell(
                  onTap: () {
                    _handleFashionButton();
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: Center(
                          child: Container(
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: categoryType == CategoryType.fashion
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
                                  'Fashion',
                                  style: TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
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
              ],
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    future: _collectionReference.get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Display the data in a GridView.builder
                        var data = snapshot.data!.docs;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                var item = data[index];
                                return productType == "food"
                                    ? HomeCard(
                                        name: item['title'],
                                        price: item['price'],
                                        dPrice: item['salePrice'],
                                        borderColor: AppColor.buttonBgColor,
                                        fillColor: AppColor.appBarButtonColor,
                                        cartBorder: isTrue
                                            ? AppColor.appBarButtonColor
                                            : AppColor.buttonBgColor,
                                        img: item['imageUrl'],
                                        iconColor: AppColor.buttonBgColor,
                                        ontap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ProductDetailScreen(
                                                    title: item['title']
                                                        .toString(),
                                                    productId:
                                                        item['id'].toString(),
                                                    sellerId: item['sellerId']
                                                        .toString(),
                                                    imageUrl: item['imageUrl'],
                                                    price: item['price']
                                                        .toString(),
                                                    salePrice: item['salePrice']
                                                        .toString(),
                                                    weight: item['weight']
                                                        .toString(),
                                                    detail: item['detail']
                                                        .toString());
                                              },
                                            ),
                                          );
                                        },
                                        addCart: () {
                                          addToCart(
                                            item['imageUrl'],
                                            item['title'],
                                            item['price'],
                                            item['salePrice'],
                                            item['id'],
                                          );
                                        },
                                        productId: item['id'],
                                        sellerId: item['sellerId'],
                                      )
                                    : HomeCard(
                                        name: item['title'],
                                        price: "",
                                        dPrice: item['price'],
                                        borderColor: AppColor.buttonBgColor,
                                        fillColor: AppColor.appBarButtonColor,
                                        cartBorder: isTrue
                                            ? AppColor.appBarButtonColor
                                            : AppColor.buttonBgColor,
                                        img: item['imageUrl'],
                                        iconColor: AppColor.buttonBgColor,
                                        ontap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return FashionDetail(
                                                    sellerId: item['sellerId'],
                                                    productId: item['id'],
                                                    title: item['title']
                                                        .toString(),
                                                    imageUrl: item['imageUrl'],
                                                    salePrice: item['price'],
                                                    detail: item['detail']
                                                        .toString());
                                              },
                                            ),
                                          );
                                        },
                                        addCart: () {
                                          addToCart(
                                            item['imageUrl'],
                                            item['title'],
                                            item['price'],
                                            item['price'],
                                            item['id'],
                                          );
                                        },
                                        productId: item['id'],
                                        sellerId: item['sellerId'],
                                      );
                              }),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
