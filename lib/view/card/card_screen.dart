// ignore_for_file: prefer_final_fields

import 'package:citta_23/models/index_model.dart';

import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/Checkout/widgets/card_checkout_screen.dart';
import 'package:citta_23/view/card/widgets/cart_page_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../res/components/colors.dart';
import '../../res/components/roundedButton.dart';
import 'widgets/dottedLineWidget.dart';
import 'widgets/item_prizing.dart';

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

  List<Map<String, dynamic>> productList = [];

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

    print(productList);
  }

  void _fetchData() {
    _productsCollection.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        int sum = 0;

        querySnapshot.docs.forEach((QueryDocumentSnapshot document) {
          String priceString = document['salePrice'];
          int priceInt = int.tryParse(priceString) ?? 0;
          sum += priceInt;
        });

        setState(() {
          totalPrice = sum;
        });
      }
    });
  }

  // other stuff
  @override
  void initState() {
    super.initState();
    getDocumentIndex();
    _fetchData();
    fetchDataFromFirestore();
  }

  Future<void> _deleteProduct(String deleteId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(deleteId)
          .delete();
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Cart Page',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // cart widget stuff
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
                      return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return CartWidget(
                            title: data['title'],
                            price: data['salePrice'],
                            img: data['imageUrl'],
                            onDelete: () async {
                              _deleteProduct(data['deleteId']);
                            },
                            items: 1,
                            sellerId: data['sellerId'],
                            productId: data['id'],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const VerticalSpeacing(30.0),
                Text(
                  'Add Coupon',
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 46,
                      width: MediaQuery.of(context).size.width * 0.55,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColor.grayColor, width: 1.0),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Voucher Code',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.0,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: RoundedButton(title: 'Apply', onpress: () {}),
                    ),
                  ],
                ),
                const VerticalSpeacing(30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Items",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.grayColor,
                        ),
                      ),
                    ),

                    Consumer<IndexModel>(
                      builder: (context, indexModel, child) {
                        return Text(
                          '${indexModel.items}',
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor,
                            ),
                          ),
                        );
                      },
                    ),
                    // Text(
                    //   index.toString(),
                    //   style: GoogleFonts.getFont(
                    //     "Gothic A1",
                    //     textStyle: const TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w800,
                    //       color: AppColor.blackColor,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // ItemPrizingWidget(title: 'Total Item', price: ),
                const VerticalSpeacing(12.0),
                SizedBox(
                  height: 1, // Height of the dotted line
                  width: double.infinity, // Infinite width
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                  ),
                ),
                const VerticalSpeacing(12.0),
                const ItemPrizingWidget(title: 'Price', price: '₹60'),
                const VerticalSpeacing(12.0),
                SizedBox(
                  height: 1, // Height of the dotted line
                  width: double.infinity, // Infinite width
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                  ),
                ),
                const VerticalSpeacing(12.0),
                ItemPrizingWidget(title: 'Total Price', price: '₹$totalPrice'),

                const VerticalSpeacing(30.0),
                SizedBox(
                  height: 46.0,
                  width: double.infinity,
                  child: RoundedButton(
                      title: 'Checkout',
                      onpress: () {
                        debugPrint(
                            "this is sub total from check out screen$subTotal");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => CardCheckOutScreen(
                                    productType: 'cart',
                                    productList: productList,
                                  )),
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
