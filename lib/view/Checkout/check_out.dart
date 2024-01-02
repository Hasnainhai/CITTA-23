// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/toggle_widget.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/widgets/address_checkout_widget.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({
    super.key,
    required this.tile,
    required this.price,
    required this.img,
    required this.id,
    required this.customerId,
    required this.weight,
    required this.salePrice,
    required this.productType,
  });
  final String tile;
  final String price;
  final String img;
  final String id;
  final String customerId;
  final String weight;
  final String salePrice;
  final String productType;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool firstButton = true;
  bool secondButton = false;
  bool thirdButton = false;
  bool isChecked = false;
  String? address;
  String? postalCode;
  String? city;
  String? state;
  String? name;
  String? phone;

  onChanged(bool? value) {
    setState(() {
      isChecked = value!;
    });
  }

  bool _isLoading = false;
  void saveDetail() {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var fireStore = FirebaseFirestore.instance;
    var uid = const Uuid().v1();
    var date = DateTime.now();
    fireStore
        .collection('users')
        .doc(userId)
        .collection('my_orders')
        .doc(uid)
        .set({
      'title': widget.tile,
      'imageUrl': widget.img,
      'productId': widget.id,
      'sallerId': widget.customerId,
      'price': widget.salePrice,
      'salePrice': widget.price,
      'weight': widget.weight,
      'date': date.toString(),
      "productType": widget.productType,
      'status': "pending",
      'uuid': uid,
      "address": address,
      "postalCode": postalCode,
      'city': city,
      'state': state,
      'name': name,
      'phone': phone,
    });
    fireStore
        .collection('saller')
        .doc(widget.customerId)
        .collection('my_orders')
        .doc(uid)
        .set({
      'title': widget.tile,
      'imageUrl': widget.img,
      'productId': widget.id,
      'buyyerId': userId,
      'price': widget.price,
      'salePrice': widget.salePrice,
      'weight': widget.weight,
      'date': date.toString(),
      'status': "pending",
      'uuid': uid,
      "address": address,
      "postalCode": postalCode,
      'city': city,
      'state': state,
      'name': name,
      'phone': phone,
    });
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
      Utils.toastMessage('Payment is successful');

      saveDetail();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const DashBoardScreen()),
          (route) => false);
    } catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
          msg: e.toString(),
        );
        setState(() {
          _isLoading = false;
        });
      } else {
        debugPrint(
          "This error of code ${e.toString()}",
        );
        Fluttertoast.showToast(
          msg: e.toString(),
        );
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
        title: Text(
          'Checkout ',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
            ),
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
                      Text(
                        'Select delivery address',
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                      phone = data['phone'];
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
                  Text(
                    'Select Payment System',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.fontColor,
                      ),
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
                                        style: GoogleFonts.getFont(
                                          "Gothic A1",
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: firstButton
                                                ? AppColor.fontColor
                                                : AppColor.fontColor,
                                          ),
                                        ),
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
                                  secondButton = !secondButton;
                                  thirdButton = false;
                                });
                              },
                              child: Center(
                                child: Container(
                                  height: 66,
                                  width: 135,
                                  decoration: BoxDecoration(
                                      color: secondButton
                                          ? AppColor.logoBgColor
                                          : Colors.transparent,
                                      border: Border.all(
                                          width: 1,
                                          color: secondButton
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
                                                    'images/paypal.png'),
                                                fit: BoxFit.contain)),
                                      ),
                                      const VerticalSpeacing(5),
                                      Text(
                                        "PayPal",
                                        style: GoogleFonts.getFont(
                                          "Gothic A1",
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: secondButton
                                                ? AppColor.fontColor
                                                : AppColor.fontColor,
                                          ),
                                        ),
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
                                                image: AssetImage(
                                                    'images/cash.png'),
                                                fit: BoxFit.contain)),
                                      ),
                                      const VerticalSpeacing(5),
                                      Text(
                                        "Cash On Delivery",
                                        style: GoogleFonts.getFont(
                                          "Gothic A1",
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: thirdButton
                                                ? AppColor.fontColor
                                                : AppColor.fontColor,
                                          ),
                                        ),
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
                  const VerticalSpeacing(30.0),
                  const TextFieldCustom(
                    maxLines: 1,
                    text: 'Card Name',
                    hintText: 'Hasnain haider',
                  ),
                  const TextFieldCustom(
                    maxLines: 1,
                    text: 'Card Number',
                    hintText: '71501 90123 **** ****',
                  ),
                  const VerticalSpeacing(20.0),
                  const ToggleWidget(
                    title: 'Remember My Card Details',
                  ),
                  const VerticalSpeacing(20.0),
                  RoundedButton(
                      title: 'Pay Now',
                      onpress: () async {
                        debugPrint("press");
                        if (name != null &&
                            postalCode != null &&
                            city != null &&
                            state != null &&
                            address != null) {
                          int roundPrice = int.parse(widget.salePrice);
                          String fixPrice = (roundPrice * 100).toString();
                          initPayment(
                              email: "basitalyshah51214@gmail.com",
                              amount: fixPrice);
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
