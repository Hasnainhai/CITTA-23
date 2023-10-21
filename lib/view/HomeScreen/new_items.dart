import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/routes_name.dart';
import 'DashBoard/tapBar.dart';
import 'widgets/homeCard.dart';

class NewItemsScreen extends StatefulWidget {
  const NewItemsScreen({super.key});

  @override
  State<NewItemsScreen> createState() => _NewItemsScreenState();
}

class _NewItemsScreenState extends State<NewItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const DashBoardScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.fontColor,
          ),
        ),
        title: Text(
          "New Item",
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
          ),
        ),
      ),
    );
  }
}
