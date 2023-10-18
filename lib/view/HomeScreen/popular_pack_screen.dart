import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import 'widgets/homeCard.dart';

class PopularPackScreen extends StatefulWidget {
  const PopularPackScreen({super.key});

  @override
  State<PopularPackScreen> createState() => _PopularPackScreenState();
}

class _PopularPackScreenState extends State<PopularPackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height / 7,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Container(
              height: 52,
              color: AppColor.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColor.buttonTxColor,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Create Own Pack",
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColor.buttonTxColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
          ),
        ),
        title: Text(
          "Popular Pack",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const VerticalSpeacing(16),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeCard(
                          ontap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.bundleproductdetail,
                            );
                          },
                          name: 'Perry Ice Cream Banana',
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
                          iconColor: AppColor.appBarButtonColor,
                        ),
                      ],
                    ),
                    const VerticalSpeacing(16),
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
                          name: 'Perry Ice Cream Banana',
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
                          iconColor: AppColor.appBarButtonColor,
                        ),
                      ],
                    ),
                    const VerticalSpeacing(16),
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
                          name: 'Perry Ice Cream Banana',
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
                          iconColor: AppColor.appBarButtonColor,
                        ),
                      ],
                    ),
                    const VerticalSpeacing(16),
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
                          name: 'Perry Ice Cream Banana',
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
                          iconColor: AppColor.appBarButtonColor,
                        ),
                      ],
                    ),
                    const VerticalSpeacing(16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
