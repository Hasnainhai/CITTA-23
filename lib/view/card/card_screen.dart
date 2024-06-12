// ignore_for_file: prefer_final_fields, use_build_context_synchronously
import 'package:citta_23/models/index_model.dart';
import 'package:citta_23/models/sub_total_model.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';

import 'package:citta_23/utils/utils.dart';

import 'package:citta_23/res/consts/firebase_const.dart';

import 'package:citta_23/view/Checkout/widgets/card_checkout_screen.dart';
import 'package:citta_23/view/card/widgets/cart_page_widget.dart';
import 'package:citta_23/view/card/widgets/emptyCartWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/components/colors.dart';
import '../../res/components/roundedButton.dart';

int items = 0;

class CardScreen extends StatefulWidget {
  const CardScreen({
    super.key,
  });
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int? index;
  int totalPrice = 0;

  CollectionReference _productsCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("cart");

  Future<void> getDocumentIndex() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .get();
    setState(() {
      items = querySnapshot.docs.length;
      Provider.of<IndexModel>(context, listen: false).updateIndex(items);
    });
  }

  void fetchDataFromFirestore() async {
    QuerySnapshot<Object?> productsSnapshot = await _productsCollection.get();

    productList = productsSnapshot.docs.map((DocumentSnapshot product) {
      return {
        'productId': product.id,
        'title': product['title'] as String,
        'imageUrl': product['imageUrl'] as String,
        'sellerId': product['sellerId'] as String,
        'salePrice': product['salePrice'] as String,
        'status': "pending",
        'date': DateTime.now().toString(),
        'buyyerId': FirebaseAuth.instance.currentUser!.uid,
      };
    }).toList();
  }

  void _fetchData() {
    _productsCollection.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        int sum = 0;
        int discount = 0;

        querySnapshot.docs.forEach((QueryDocumentSnapshot document) {
          // Print entire document data for debugging
          debugPrint("Document data: ${document.data()}");

          // Parse salePrice as integer
          String priceString = document['salePrice'];
          int priceInt = int.tryParse(priceString.split('.').first) ?? 0;
          sum += priceInt;

          // Check if document data contains dPrice
          var data = document.data() as Map<String, dynamic>?;
          if (data != null) {
            if (data.containsKey('dPrice')) {
              String disPrice = data['dPrice'];
              int dP = int.tryParse(disPrice.split('.').first) ?? 0;
              discount += dP;

              // Debug output to check parsed discount price
              debugPrint(
                  "Parsed discount price: $dP from document ${document.id}");
            } else {
              // Debug output to indicate missing dPrice key
              debugPrint("Missing dPrice key in document: ${document.id}");
            }
          } else {
            // Debug output to indicate null data
            debugPrint("Null data for document: ${document.id}");
          }
        });

        // Update state and notify providers
        setState(() {
          subTotal = sum;
          Provider.of<SubTotalModel>(context, listen: false)
              .updateSubTotal(subTotal);
          d = discount;
          Provider.of<DiscountSum>(context, listen: false).updateDisTotal(d);
        });

        // Debug output to check final sums
        debugPrint("Final subTotal: $subTotal");
        debugPrint("Final discount sum: $d");
      }
    }).catchError((error) {
      // Handle any errors that occur during the fetch
      debugPrint("Error fetching data: $error");
    });
  }

  // other stuff
  @override
  void initState() {
    super.initState();
    getDocumentIndex();
    _fetchData();
  }

  // ignore: unused_element
  Future<void> _deleteProduct(String deleteId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(deleteId)
          .delete();
    } catch (e) {
      Utils.flushBarErrorMessage('$e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Cart Page',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.blackColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            subTotal = 0;
            Provider.of<SubTotalModel>(context, listen: false)
                .updateSubTotal(subTotal);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.hasData) {}
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      fetchDataFromFirestore();

                      return snapshot.data!.docs.isEmpty
                          ? const EmptyCart()
                          : ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                return CartWidget(
                                  title: data['title'],
                                  price: data['salePrice'],
                                  img: data['imageUrl'],
                                  items: 1,
                                  sellerId: data['sellerId'],
                                  productId: data['id'],
                                  deletedId: data['deleteId'],
                                );
                              }).toList(),
                            );
                    },
                  ),
                ),
                const VerticalSpeacing(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Items",
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grayColor,
                      ),
                    ),
                    Consumer<IndexModel>(
                      builder: (context, indexModel, child) {
                        return Text(
                          '${indexModel.items}',
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColor.blackColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const VerticalSpeacing(12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Price",
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grayColor,
                      ),
                    ),
                    Consumer<SubTotalModel>(
                      builder: (context, subTotalModel, child) {
                        return Text(
                          '₹${subTotalModel.subTotal}',
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColor.blackColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const VerticalSpeacing(12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Discount",
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grayColor,
                      ),
                    ),
                    Consumer<DiscountSum>(
                      builder: (context, indexModel, child) {
                        return Text(
                          '${indexModel.dis}',
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColor.blackColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const VerticalSpeacing(12.0),
                const Divider(
                  color: AppColor.primaryColor,
                ),
                const VerticalSpeacing(12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Price",
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grayColor,
                      ),
                    ),
                    Consumer<SubTotalModel>(
                      builder: (context, subTotalModel, child) {
                        return Text(
                          '₹${subTotalModel.subTotal}',
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColor.blackColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const VerticalSpeacing(30.0),
                SizedBox(
                  height: 46.0,
                  width: double.infinity,
                  child: RoundedButton(
                      title: 'Checkout',
                      onpress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => CardCheckOutScreen(
                              productType: 'cart',
                              productList: productList,
                              subTotal: "$subTotal",
                            ),
                          ),
                        );
                      }),
                ),
                const VerticalSpeacing(60.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
