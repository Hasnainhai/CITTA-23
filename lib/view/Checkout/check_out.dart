import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/Checkout/widgets/address_checkout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool switchValue = false;
  bool firstButton = true;
  bool secondButton = false;
  bool thirdButton = false;
  bool isChecked = false;

  onChanged(bool? value) {
    setState(() {
      isChecked = value!;
    });
  }
  // Color bgColor = AppColor.whiteColor;
  // Color borderColor = AppColor.grayColor;
  // Color titleColor = AppColor.blackColor;

  // void changeColors() {
  //   setState(() {
  //     // Change the colors when the button is clicked
  //     bgColor = AppColor.logoBgColor;
  //     borderColor = AppColor.primaryColor;
  //     titleColor = AppColor.primaryColor;
  //   });
  // }

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
        leading: const Icon(
          Icons.arrow_back,
          color: AppColor.blackColor,
        ),
      ),
      body: SafeArea(
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
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.addressdetailscreen,
                        );
                      },
                      child: Text(
                        'Add New',
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const AddressCheckOutWidget(
                    bgColor: AppColor.logoBgColor,
                    borderColor: AppColor.primaryColor,
                    titleColor: AppColor.primaryColor,
                    title: 'Home Address',
                    phNo: '(309) 071-9396-939',
                    address: '1749 Custom Road, Chhastak'),
                const VerticalSpeacing(20.0),
                const AddressCheckOutWidget(
                    bgColor: AppColor.whiteColor,
                    borderColor: AppColor.grayColor,
                    titleColor: AppColor.blackColor,
                    title: 'Office Address',
                    phNo: '(309)  071-9396-939',
                    address: '152 Nobab Road, Sylhet'),
                const VerticalSpeacing(20.0),
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
                VerticalSpeacing(20.0),
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
                                              image:
                                                  AssetImage('images/cash.png'),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 177,
                      child: TextFieldCustom(
                        maxLines: 1,
                        text: 'Expiry Date',
                        hintText: '01/04/2028',
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 177,
                      child: TextFieldCustom(
                        maxLines: 2,
                        text: 'CVV',
                        hintText: '1214',
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Remember My Card Details",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    FlutterSwitch(
                      value: switchValue,
                      onToggle: (value) {
                        setState(() {
                          switchValue = value;
                        });
                      },
                      width: 50.0, // Adjust the width to make it square
                      height: 26.0, // Adjust the height to make it square
                      toggleSize: 28.0, // Adjust the toggle size
                      activeColor: Colors.pink,
                      inactiveColor: Colors.grey,
                      borderRadius: 0.0,
                    ),
                  ],
                ),
                const VerticalSpeacing(20.0),
                RoundedButton(title: 'Pay Now', onpress: () {}),
                const VerticalSpeacing(50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
