// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/done_screen.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/Checkout/widgets/address_checkout_widget.dart';
import '../../../res/components/colors.dart';

class CardCheckOutScreen extends StatefulWidget {
  const CardCheckOutScreen({
    super.key,
    // required this.tile,
    // required this.price,
    // required this.img,
    // required this.id,
    // required this.customerId,
    // required this.weight,
    // required this.salePrice,
    required this.productType,
    required this.productList,
    required this.subTotal,
  });
  // final String tile;
  // final String price;
  // final String img;
  // final String id;
  // final String customerId;
  // final String weight;
  // final String salePrice;
  final String productType;
  final List<Map<String, dynamic>> productList;
  final String subTotal;
  @override
  State<CardCheckOutScreen> createState() => _CardCheckOutScreenState();
}

class _CardCheckOutScreenState extends State<CardCheckOutScreen> {
  bool firstButton = true;
  bool secondButton = false;
  bool thirdButton = false;
  bool isChecked = false;
  String? address;
  String? postalCode;
  String? city;
  String? state;
  String? name;
  String? phoneNumber;
  String paymentType = 'Stripe';

  onChanged(bool? value) {
    setState(() {
      isChecked = value!;
    });
  }

  bool _isLoading = false;
  void saveOrdersToFirestore() async {
    final CollectionReference<Map<String, dynamic>> myOrdersCollection =
        FirebaseFirestore.instance.collection('saller');

    // ignore: unused_local_variable
    Map<String, dynamic> addressMap = {
      "Address": address as String,
      "postalCode": postalCode as String,
      "city": city as String,
      "state": state as String,
      "name": name as String,
      "phone": phoneNumber as String,
    };
    for (var orderMap in widget.productList) {
      final String buyerId = orderMap['sellerId']!;
      var orderId = const Uuid().v1();
      orderMap["address"] = address;
      orderMap["postalCode"] = postalCode;
      orderMap['city'] = city;
      orderMap['state'] = state;
      orderMap['name'] = name;
      orderMap['uuid'] = orderId;
      orderMap['date'] = DateTime.now().toString();
      orderMap['status'] = "pending";
      orderMap['phone'] = phoneNumber;
      orderMap['paymentType'] = paymentType;

      // orderMap['address'] = addressMap;

      await myOrdersCollection
          .doc(buyerId)
          .collection('my_orders')
          .doc(orderId)
          .set(orderMap);

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('my_orders')
          .doc(orderId)
          .set(orderMap);
    }
  }

  Future<void> initPayment({
    required String email,
    required String amount,
  }) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(
              "https://us-central1-citta-23-2b5be.cloudfunctions.net/stripePaymentIntentRequest"),
          body: {
            'email': email,
            'amount': amount,
            'address': address,
            'postal_code': postalCode,
            'city': city,
            'state': state,
            'name': name,
          });
      final jsonRespone = jsonDecode(
        response.body,
      );
      debugPrint(jsonRespone.toString());
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonRespone['paymentIntent'],
        merchantDisplayName: 'Groccery',
        customerId: jsonRespone['customerId'],
        customerEphemeralKeySecret: jsonRespone['aphemeralKey'],
      ));
      await Stripe.instance.presentPaymentSheet();
      Fluttertoast.showToast(msg: "Payment is successful");
      saveOrdersToFirestore();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const CheckOutDoneScreen()),
          (route) => false);
    } catch (e) {
      if (e is StripeException) {
        Utils.flushBarErrorMessage("Payment  Cancelled", context);

        setState(() {
          _isLoading = false;
        });
      } else {
        Utils.flushBarErrorMessage("Problem in Payment", context);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Checkout ',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.blackColor,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpeacing(24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select delivery address',
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.addressdetailscreen);
                        },
                        child: Container(
                          height: 28.0,
                          width: 28.0,
                          color: AppColor.primaryColor,
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20),
                  SizedBox(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('my_Address')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      debugPrint('address one is selected');
                                      address = data['address2'];
                                      name = data['name'];
                                      city = data['city'];
                                      postalCode = data['zipcode'];
                                      state = data['state'];
                                      phoneNumber = data['phone'];
                                    },
                                    child: AddressCheckOutWidget(
                                      bgColor: AppColor.whiteColor,
                                      borderColor: AppColor.grayColor,
                                      titleColor: AppColor.blackColor,
                                      title: data['address2'],
                                      phNo: data['phone'],
                                      address: data['address1'],
                                    ),
                                  ),
                                  const VerticalSpeacing(20.0),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                  ),
                  const Text(
                    'Select Payment System',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.fontColor,
                    ),
                  ),
                  const VerticalSpeacing(20.0),
                  SizedBox(
                    height: 66,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  firstButton = !firstButton;
                                  secondButton = false;
                                  thirdButton = false;
                                  paymentType = 'Stripe';
                                });
                              },
                              child: Center(
                                child: Container(
                                  height: 66,
                                  width: 135,
                                  decoration: BoxDecoration(
                                      color: firstButton
                                          ? AppColor.logoBgColor
                                          : Colors.transparent,
                                      border: Border.all(
                                          width: 1,
                                          color: firstButton
                                              ? AppColor.primaryColor
                                              : AppColor.grayColor)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30.0,
                                        width: 30.0,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'images/masterCard.png'),
                                                fit: BoxFit.contain)),
                                      ),
                                      const VerticalSpeacing(5),
                                      Text(
                                        "Master Card",
                                        style: TextStyle(
                                            fontFamily: 'CenturyGothic',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: firstButton
                                                ? AppColor.fontColor
                                                : AppColor.fontColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  firstButton = false;
                                  secondButton = false;
                                  thirdButton = !thirdButton;
                                  paymentType = 'cash on delivery';
                                });
                              },
                              child: Center(
                                child: Container(
                                  height: 66,
                                  width: 135,
                                  decoration: BoxDecoration(
                                      color: thirdButton
                                          ? AppColor.logoBgColor
                                          : Colors.transparent,
                                      border: Border.all(
                                          width: 1,
                                          color: thirdButton
                                              ? AppColor.primaryColor
                                              : AppColor.grayColor)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30.0,
                                        width: 30.0,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage('images/cash.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      const VerticalSpeacing(5),
                                      Text(
                                        "Cash On Delivery",
                                        style: TextStyle(
                                            fontFamily: 'CenturyGothic',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: thirdButton
                                                ? AppColor.fontColor
                                                : AppColor.fontColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  VerticalSpeacing(MediaQuery.of(context).size.height / 2.8),
                  RoundedButton(
                      title: paymentType == "Stripe" ? 'Pay Now' : "Order Now",
                      onpress: () async {
                        debugPrint("press");
                        double amountInDollars = double.parse(widget.subTotal);
                        int amountInCents = (amountInDollars * 100).round();

                        if (name != null &&
                            postalCode != null &&
                            city != null &&
                            state != null &&
                            address != null) {
                          if (paymentType == 'Stripe') {
                            initPayment(
                              email: "basitalyshah51214@gmail.com",
                              amount: amountInCents.toString(),
                            );
                          } else {
                            saveOrdersToFirestore();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const CheckOutDoneScreen()),
                                (route) => false);
                            Utils.toastMessage('Orders has been Placed');
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please enter address details");
                        }
                      }),
                  const VerticalSpeacing(50.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
