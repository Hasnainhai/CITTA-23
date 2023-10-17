import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../res/components/widgets/verticalSpacing.dart';
import 'widgets/homeCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTrue = true;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40.0,
              width: 40.0,
              color: AppColor.appBarButtonColor,
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notes,
                    color: AppColor.menuColor,
                  ),
                ),
              ),
            ),
          ),
          title: Container(
            height: 40.0,
            width: 190.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on,
                      color: AppColor.menuColor,
                    ),
                  ),
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Current Location \n',
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'Chhatak,Syhlet',
                              style: TextStyle(
                                color: AppColor.grayColor,
                                fontWeight: FontWeight.w200,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.expand_more,
                    color: AppColor.buttonBgColor,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40.0,
                width: 40.0,
                color: AppColor.appBarButtonColor,
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: AppColor.menuColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 180.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/bannerImg.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  VerticalSpeacing(50.0),
                  Row(
                    children: [

                    ],
                  ),
                  VerticalSpeacing(50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Pack",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor),
                        ),
                      ),
                      Text(
                        "View All",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.buttonBgColor),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCard(
                        name: 'Bundle Pack',
                        categories: 'Onion,Oil,Salt...',
                        price: '\$35 ',
                        dPrice: '\$50.32',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.appBarButtonColor,
                        cartBorder: isTrue
                            ? AppColor.appBarButtonColor
                            : AppColor.buttonBgColor,
                        img: 'images/fruit1.png',
                        iconColor: AppColor.buttonBgColor,
                      ),
                      HomeCard(
                        name: 'Fruit Pack',
                        categories: 'Apple,banana...',
                        price: '\$50 ',
                        dPrice: '\$70.32',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: isTrue
                            ? AppColor.buttonBgColor
                            : AppColor.appBarButtonColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit2.png',
                        iconColor: isTrue
                            ? AppColor.whiteColor
                            : AppColor.buttonBgColor,
                      ),
                    ],
                  ),
                  const VerticalSpeacing(16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Our New Item",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor),
                        ),
                      ),
                      Text(
                        "View All",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.buttonBgColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCard(
                        name: 'Girl Guide',
                        categories: '1000 GM',
                        price: '\$10 ',
                        dPrice: '\$15.99',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: isTrue
                            ? AppColor.buttonBgColor
                            : AppColor.appBarButtonColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit3.png',
                        iconColor: isTrue
                            ? AppColor.whiteColor
                            : AppColor.buttonBgColor,
                      ),
                      HomeCard(
                        name: 'Tomato',
                        categories: '1000 GM',
                        price: '\$5 ',
                        dPrice: '\$9.99',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: isTrue
                            ? AppColor.buttonBgColor
                            : AppColor.appBarButtonColor,
                        cartBorder: AppColor.buttonBgColor,
                        img: 'images/fruit4.png',
                        iconColor: isTrue
                            ? AppColor.whiteColor
                            : AppColor.buttonBgColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
