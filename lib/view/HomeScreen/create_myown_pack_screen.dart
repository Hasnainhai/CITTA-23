import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import '../../routes/routes_name.dart';
import 'widgets/homeCard.dart';

class CreateOwnPackScreen extends StatefulWidget {
  const CreateOwnPackScreen({super.key});

  @override
  State<CreateOwnPackScreen> createState() => _CreateOwnPackScreenState();
}

class _CreateOwnPackScreenState extends State<CreateOwnPackScreen> {
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
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 7,
        color: AppColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: AppColor.buttonTxColor,
                        image: DecorationImage(
                            image: AssetImage(
                              "images/fruit1.png",
                            ),
                            fit: BoxFit.contain),
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
                        image: DecorationImage(
                            image: AssetImage(
                              "images/fruit1.png",
                            ),
                            fit: BoxFit.contain),
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
                        image: DecorationImage(
                            image: AssetImage(
                              "images/fruit1.png",
                            ),
                            fit: BoxFit.contain),
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
                        image: DecorationImage(
                            image: AssetImage(
                              "images/fruit1.png",
                            ),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "\$35.05",
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
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.cartScreen,
                        );
                      },
                      child: Container(
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
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Search Here",
                  helperStyle: TextStyle(color: AppColor.grayColor),
                  filled: true,
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            const VerticalSpeacing(18),
            SizedBox(
              height: 66,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        firstButton = !firstButton;
                        secondButton = false;
                        thirdButton = false;
                        fourthButton = false;
                        fifthButton = false;
                        sixButton = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      height: 30,
                      width: 100,
                      color: firstButton
                          ? AppColor.primaryColor
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          "Vegetables",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: firstButton
                                  ? AppColor.buttonTxColor
                                  : AppColor.grayColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        fifthButton = false;
                        firstButton = false;
                        secondButton = !fourthButton;
                        thirdButton = false;
                        fourthButton = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      height: 20,
                      width: 100,
                      color: secondButton
                          ? AppColor.primaryColor
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          "Meat & Fish",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: secondButton
                                  ? AppColor.buttonTxColor
                                  : AppColor.grayColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        fifthButton = false;
                        firstButton = false;
                        secondButton = false;
                        thirdButton = !thirdButton;
                        fourthButton = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      height: 20,
                      width: 100,
                      color: thirdButton
                          ? AppColor.primaryColor
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          "Medicine",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: thirdButton
                                  ? AppColor.buttonTxColor
                                  : AppColor.grayColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        fifthButton = false;
                        firstButton = false;
                        secondButton = false;
                        thirdButton = false;
                        fourthButton = !fourthButton;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      height: 20,
                      width: 100,
                      color: fourthButton
                          ? AppColor.primaryColor
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          "Baby Care",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: fourthButton
                                  ? AppColor.buttonTxColor
                                  : AppColor.grayColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        fifthButton = !fifthButton;
                        firstButton = false;
                        secondButton = false;
                        thirdButton = false;
                        fourthButton = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      height: 20,
                      width: 100,
                      color: fifthButton
                          ? AppColor.primaryColor
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          "Fruits",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: fifthButton
                                  ? AppColor.buttonTxColor
                                  : AppColor.grayColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    height: 30,
                    width: 100,
                    color:
                        sixButton ? AppColor.primaryColor : Colors.transparent,
                    child: Center(
                      child: Text(
                        "Vegetables",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: sixButton
                                ? AppColor.buttonTxColor
                                : AppColor.grayColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCard(
                        ontap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.productdetailscreen,
                          );
                        },
                        name: 'Bundle Pack',
                        categories: 'Onion,Oil,Salt...',
                        price: '\$35 ',
                        dPrice: '\$50.32',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.buttonBgColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit1.png',
                        iconColor: AppColor.appBarButtonColor,
                      ),
                      HomeCard(
                        ontap: () {},
                        name: 'Fruit Pack',
                        categories: 'Apple,banana...',
                        price: '\$50 ',
                        dPrice: '\$70.32',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.buttonBgColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit2.png',
                        iconColor: AppColor.whiteColor,
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCard(
                        ontap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.productdetailscreen,
                          );
                        },
                        name: 'Bundle Pack',
                        categories: 'Onion,Oil,Salt...',
                        price: '\$35 ',
                        dPrice: '\$50.32',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.buttonBgColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit1.png',
                        iconColor: AppColor.appBarButtonColor,
                      ),
                      HomeCard(
                        ontap: () {},
                        name: 'Fruit Pack',
                        categories: 'Apple,banana...',
                        price: '\$50 ',
                        dPrice: '\$70.32',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.buttonBgColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit2.png',
                        iconColor: AppColor.whiteColor,
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCard(
                        ontap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.productdetailscreen,
                          );
                        },
                        name: 'Bundle Pack',
                        categories: 'Onion,Oil,Salt...',
                        price: '\$35 ',
                        dPrice: '\$50.32',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.buttonBgColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit1.png',
                        iconColor: AppColor.appBarButtonColor,
                      ),
                      HomeCard(
                        ontap: () {},
                        name: 'Fruit Pack',
                        categories: 'Apple,banana...',
                        price: '\$50 ',
                        dPrice: '\$70.32',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.buttonBgColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit2.png',
                        iconColor: AppColor.whiteColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
