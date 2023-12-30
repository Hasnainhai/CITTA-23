import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../res/components/colors.dart';
import 'widgets/homeCard.dart';

class CreateOwnPackScreen extends StatefulWidget {
  const CreateOwnPackScreen({super.key});

  @override
  State<CreateOwnPackScreen> createState() => _CreateOwnPackScreenState();
}

class _CreateOwnPackScreenState extends State<CreateOwnPackScreen> {
  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;
  bool isTrue = true;
  List<Map<String, dynamic>> productList = [];

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection('products').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          'id': qn.docs[i]['id'],
          'sellerId': qn.docs[i]['sellerId'],
          'imageUrl': qn.docs[i]['imageUrl'],
          'title': qn.docs[i]['title'],
          'price': qn.docs[i]['price'],
          'salePrice': qn.docs[i]['salePrice'],
          'detail': qn.docs[i]['detail'],
          'weight': qn.docs[i]['weight'],
        });
      }
    });
    return qn.docs;
  }

  void addToMap(String img, String title, String dPrice, String sellerId,
      String productId) async {
    productList.add({
      'productId': productId,
      'title': title,
      'imageUrl': img,
      'sellerId': sellerId,
      'salePrice': dPrice,
      'status': "pending",
      'date': DateTime.now().toString(),
      'buyyerId': FirebaseAuth.instance.currentUser!.uid,
    });

    // await cartCollectionRef.add({
    //   'id': productId,
    //   'sellerId': sellerId,
    //   'imageUrl': img,
    //   'title': title,
    //   'salePrice': dPrice,
    //   // Add other product details as needed
    // });
    print(productList);

    Utils.toastMessage('Successfully added to cart');
  }

  @override
  initState() {
    super.initState();
    fetchProducts();
  }

  bool firstButton = true;
  bool secondButton = false;

  bool thirdButton = false;

  bool fourthButton = false;

  bool fifthButton = false;

  bool sixButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.fontColor,
            )),
        title: Text(
          "Create My Pack",
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
        ),
      ),
      bottomNavigationBar: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('myOwnPack')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> cartItems = snapshot.data!.docs;
            double totalPrice = 0;
            for (var item in cartItems) {
              totalPrice += double.parse(item['salePrice']);
            }

            return Container(
              height: MediaQuery.of(context).size.height / 9,
              color: AppColor.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            var item = cartItems[index];
                            if (cartItems.isEmpty) {
                              return const Center(
                                child: Text(
                                  'Empty Cart...',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, right: 4.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColor.buttonTxColor,
                                    image: DecorationImage(
                                      image: NetworkImage(item['imageUrl']),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "\$${totalPrice.toStringAsFixed(1)}", // Display total price
                            style: GoogleFonts.getFont(
                              "Gothic A1",
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColor.buttonTxColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: AppColor.buttonTxColor,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          // ListView.builder(
                          //   itemBuilder: (context, index) {
                          //     var product = _products[index];
                          //     return InkWell(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => CheckOutScreen(
                          //               tile: product['title'].toString(),
                          //               price: product['price'].toString(),
                          //               img: product['imageUrl'],
                          //               id: product['id'].toString(),
                          //               customerId:
                          //                   product['sellerId'].toString(),
                          //               weight: product['weight'].toString(),
                          //               salePrice:
                          //                   product['salePrice'].toString(),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //       child:
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Shimmer(
                duration: const Duration(seconds: 3), //Default value
                interval: const Duration(
                    seconds: 5), //Default value: Duration(seconds: 0)
                color: AppColor.grayColor.withOpacity(0.2), //Default value
                colorOpacity: 0.2, //Default value
                enabled: true, //Default value
                direction: const ShimmerDirection.fromLTRB(), //Default Value
                child: Container(
                  height: 50,
                  width: 50,
                  color: AppColor.grayColor.withOpacity(0.2),
                ),
              ),
            );
          }
        },
      ),
      body: SafeArea(
          child: ListView(
        children: [
          // Container(
          //   margin: const EdgeInsets.only(
          //     top: 20,
          //     left: 20,
          //     right: 20,
          //   ),
          //   height: 60,
          //   width: MediaQuery.of(context).size.width,
          //   child: TextFormField(
          //     decoration: const InputDecoration(
          //       hintText: "Search Here",
          //       helperStyle: TextStyle(color: AppColor.grayColor),
          //       filled: true,
          //       border: InputBorder.none,
          //       suffixIcon: Icon(
          //         Icons.search,
          //       ),
          //     ),
          //   ),
          // ),
          // const VerticalSpeacing(18),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5, // Horizontal spacing
                mainAxisSpacing: 10, // Vertical spacing
              ),
              const VerticalSpeacing(18),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5, // Horizontal spacing
                    mainAxisSpacing: 10, // Vertical spacing
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    // Check if _products is not empty and index is within valid range
                    if (_products.isNotEmpty && index < _products.length) {
                      return HomeCard(
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailScreen(
                                    title: _products[index]['title'].toString(),
                                    imageUrl: _products[index]['imageUrl'],
                                    price: _products[index]['price'].toString(),
                                    salePrice: _products[index]['salePrice']
                                        .toString(),
                                    productId:
                                        _products[index]['id'].toString(),
                                    sellerId:
                                        _products[index]['sellerId'].toString(),
                                    weight:
                                        _products[index]['weight'].toString(),
                                    detail:
                                        _products[index]['detail'].toString());
                              },
                            ),
                          );
                        },
                        sellerId: _products[index]['sellerId'],
                        productId: _products[index]['id'],
                        name: _products[index]['title'].toString(),
                        price: _products[index]['price'].toString(),
                        dPrice: _products[index]['salePrice'].toString(),
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.appBarButtonColor,
                        cartBorder: isTrue
                            ? AppColor.appBarButtonColor
                            : AppColor.buttonBgColor,
                        img: _products[index]['imageUrl'],
                        iconColor: AppColor.buttonBgColor,
                        addCart: () {
                          if (_products.isNotEmpty &&
                              index >= 0 &&
                              index < _products.length) {
                            addToMap(
                                _products[index]['imageUrl'],
                                _products[index]['title'],
                                _products[index]['salePrice'],
                                _products[index]['id'],
                                _products[index]['sellerId']);
                          }
                        },
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Shimmer(
                          duration: const Duration(seconds: 3), //Default value
                          interval: const Duration(
                              seconds: 5), //Default value: Duration(seconds: 0)
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
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                // Check if _products is not empty and index is within valid range
                if (_products.isNotEmpty && index < _products.length) {
                  return HomeCard(
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailScreen(
                                title: _products[index]['title'].toString(),
                                imageUrl: _products[index]['imageUrl'],
                                price: _products[index]['price'].toString(),
                                salePrice:
                                    _products[index]['salePrice'].toString(),
                                productId: _products[index]['id'].toString(),
                                sellerId:
                                    _products[index]['sellerId'].toString(),
                                weight: _products[index]['weight'].toString(),
                                detail: _products[index]['detail'].toString());
                          },
                        ),
                      );
                    },
                    sellerId: _products[index]['sellerId'],
                    productId: _products[index]['id'],
                    name: _products[index]['title'].toString(),
                    price: _products[index]['price'].toString(),
                    dPrice: _products[index]['salePrice'].toString(),
                    borderColor: AppColor.buttonBgColor,
                    fillColor: AppColor.appBarButtonColor,
                    cartBorder: isTrue
                        ? AppColor.appBarButtonColor
                        : AppColor.buttonBgColor,
                    img: _products[index]['imageUrl'],
                    iconColor: AppColor.buttonBgColor,
                    addCart: () {
                      if (_products.isNotEmpty &&
                          index >= 0 &&
                          index < _products.length) {
                        addToCart(
                            _products[index]['imageUrl'],
                            _products[index]['title'],
                            _products[index]['salePrice'],
                            _products[index]['id'],
                            _products[index]['sellerId']);
                      }
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Shimmer(
                      duration: const Duration(seconds: 3), //Default value
                      interval: const Duration(
                          seconds: 5), //Default value: Duration(seconds: 0)
                      color:
                          AppColor.grayColor.withOpacity(0.2), //Default value
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
                  ); // or some default widget
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
