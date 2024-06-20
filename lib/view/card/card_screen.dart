// ignore_for_file: prefer_final_fields, use_build_context_synchronously
import 'package:citta_23/models/index_model.dart';
import 'package:citta_23/models/sub_total_model.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/firebase_const.dart';
import 'package:citta_23/view/card/widgets/cart_page_widget.dart';
import 'package:citta_23/view/card/widgets/emptyCartWidget.dart';
import 'package:citta_23/view/forgetAnything/forget_anything.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/components/colors.dart';
import '../../res/components/roundedButton.dart';

int items = 0;

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  CollectionReference _productsCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("cart");

  void fetchDataFromFirestore() async {
    QuerySnapshot<Object?> productsSnapshot = await _productsCollection.get();
    debugPrint("this is the productsSnapshot:$productsSnapshot");
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
        'size': product['size'],
        'color': product['color'],
        'discount': product['dPrice'],
        'quantit': items.toString(),
        "weight": product['weight'],
      };
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    getDocumentIndex();
    _fetchData();
  }

  Future<void> getDocumentIndex() async {
    QuerySnapshot querySnapshot = await _productsCollection.get();
    setState(() {
      items = querySnapshot.docs.length;
      Provider.of<IndexModel>(context, listen: false).updateIndex(items);
    });
  }

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
        });
      }
    }).catchError((error) {
      debugPrint("Error fetching data: $error");
    });
  }

  void showCheckOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          shape: const RoundedRectangleBorder(),
          icon: const ImageIcon(
            AssetImage('images/shopping.png'),
            size: 80,
            color: AppColor.menuColor,
          ),
          title: Wrap(
            direction: Axis.horizontal,
            children: <Widget>[
              Consumer<TotalPriceModel>(
                builder: (context, totalPriceModel, child) {
                  return Text(
                    'You haven\'t finished checking out yet. Don\'t miss out on free shipping & a ₹${totalPriceModel.totalPrice} discount',
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.menuColor,
                    ),
                  );
                },
              ),
            ],
          ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ForgetAnything(
                        productList: productList,
                        subTotal: subTotal.toString());
                  }));
                },
                child: const Text(
                  'Keep checking out',
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(),
                  side: const BorderSide(
                    color: AppColor.primaryColor,
                    width: 2.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Return to cart',
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                    stream: _productsCollection.snapshots(),
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
                                  discount: data['dPrice'],
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
                      builder: (context, discountSum, child) {
                        return Text(
                          '${discountSum.dis}',
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
                const VerticalSpeacing(12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sub-Total",
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grayColor,
                      ),
                    ),
                    Consumer<TotalPriceModel>(
                      builder: (context, totalPriceModel, child) {
                        return Text(
                          '₹${totalPriceModel.totalPrice}',
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
                        showCheckOutDialog(context);
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
