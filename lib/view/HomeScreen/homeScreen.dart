// ignore_for_file: file_names
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../res/components/widgets/verticalSpacing.dart';
import '../drawer/drawer.dart';
import 'widgets/homeCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    bool isTrue = true;
    return Scaffold(
      drawer: const DrawerScreen(),
      key: scaffoldKey,
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
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.notes,
                  color: AppColor.menuColor,
                ),
              ),
            ),
          ),
        ),
        title: SizedBox(
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
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.searchscreen,
                    );
                  },
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
                  const VerticalSpeacing(50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: Center(
                              child: Container(
                                height: 45.0,
                                width: MediaQuery.of(context).size.width * 0.4,
                                color: AppColor.buttonBgColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 33.0,
                                      width: 63.0,
                                      color: AppColor.categoryLightColor,
                                    ),
                                    Text(
                                      'Food',
                                      style: GoogleFonts.getFont(
                                        "Gothic A1",
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 25,
                            top: 0,
                            bottom: 5.0,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                'images/foodimg.png',
                                height: 59.0,
                                width: 59.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: Center(
                              child: Container(
                                height: 45.0,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: AppColor.buttonBgColor)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 33.0,
                                      width: 63.0,
                                      color: AppColor.categoryLightColor,
                                    ),
                                    Text(
                                      'Fashion',
                                      style: GoogleFonts.getFont(
                                        "Gothic A1",
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.buttonBgColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 0,
                            bottom: 12.0,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                'images/fashionimg.png',
                                height: 56.0,
                                width: 42.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpeacing(50.0),
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
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.popularpackscreen,
                          );
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.buttonBgColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(16.0),
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
                        fillColor: AppColor.appBarButtonColor,
                        cartBorder: isTrue
                            ? AppColor.appBarButtonColor
                            : AppColor.buttonBgColor,
                        img: 'images/fruit1.png',
                        iconColor: AppColor.buttonBgColor,
                      ),
                      HomeCard(
                        ontap: () {},
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
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.newitemsscreen,
                          );
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.buttonBgColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCard(
                        ontap: () {},
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
                        ontap: () {},
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
