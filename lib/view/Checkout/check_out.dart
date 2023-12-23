// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/toggle_widget.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/Checkout/widgets/address_checkout_widget.dart';
import 'package:citta_23/view/review/review.dart';
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
  const CheckOutScreen(
      {super.key,
      required this.tile,
      required this.price,
      required this.img,
      required this.id,
      required this.customerId});
  final String tile;
  final String price;
  final String img;
  final String id;
  final String customerId;

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

  onChanged(bool? value) {
    setState(() {
      isChecked = value!;
    });
  }

  bool _isLoading = false;
  void saveDetail() {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var fireStore = FirebaseFirestore.instance;
    var uid = Uuid().v1();
    fireStore
        .collection('users')
        .doc(userId)
        .collection('my_orders')
        .doc(uid)
        .set({
      'title': widget.tile,
      'imgurl': widget.img,
      'productId': widget.id,
      'sallerId': widget.id,
      'price': widget.price,
    });
    fireStore
        .collection('Saller')
        .doc(widget.customerId)
        .collection('my_orders')
        .doc(uid)
        .set({
      'title': widget.tile,
      'imgurl': widget.img,
      'productId': widget.id,
      'buyyerId': userId,
      'price': widget.price,
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
      Fluttertoast.showToast(msg: "Payment is successful");
      saveDetail();
      await showDialog(
        context: context,
        builder: (BuildContext context) => const Rating(),
      );
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
                              address = data['address2'];
                              name = data['name'];
                              city = data['city'];
                              postalCode = data['zipcode'];
                              state = data['state'];

                              return Column(
                                children: [
                                  AddressCheckOutWidget(
                                    bgColor: AppColor.whiteColor,
                                    borderColor: AppColor.grayColor,
                                    titleColor: AppColor.blackColor,
                                    title: data['address2'],
                                    phNo: data['phone'],
                                    address: data['address1'],
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       height: 100,
                  //       width: MediaQuery.of(context).size.width * 0.43,
                  //       child: const TextFieldCustom(
                  //         maxLines: 1,
                  //         text: 'Expiry Date',
                  //         hintText: '01/04/2028',
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 100,
                  //       width: MediaQuery.of(context).size.width * 0.43,
                  //       child: const TextFieldCustom(
                  //         maxLines: 2,
                  //         text: 'CVV',
                  //         hintText: '1214',
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                          print("this is the name of customer:$name");
                          initPayment(
                              email: "basitalyshah51214@gmail.com",
                              amount: "50.0");
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
