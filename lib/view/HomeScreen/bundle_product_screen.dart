import 'package:carousel_slider/carousel_slider.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import 'widgets/increase_container.dart';

class BundleProductScreen extends StatefulWidget {
  const BundleProductScreen({super.key});

  @override
  State<BundleProductScreen> createState() => _BundleProductScreenState();
}

class _BundleProductScreenState extends State<BundleProductScreen> {
  bool like = false;
  int currentIndex = 0;
  final List<String> imgList = [
    "images/fruit1.png",
    "images/fruit2.png",
    "images/purepng.png",
  ];
  List<Color> colors = [
    AppColor.primaryColor,
    AppColor.primaryColor,
    AppColor.primaryColor
  ];

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
          "Bundel Details",
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
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 320,
                  width: 400,
                  decoration: const BoxDecoration(
                    color: Color(0xffEEEEEE),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                    ),
                    child: Column(
                      children: [
                        const VerticalSpeacing(10),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  like = !like; // Toggle the value of like
                                });
                              },
                              child: Container(
                                height: 48,
                                width: 48,
                                color: Colors.white,
                                child: like
                                    ? const Icon(
                                        Icons.favorite,
                                        color: AppColor.primaryColor,
                                      )
                                    : const Icon(Icons.favorite_border_rounded),
                              ),
                            ),
                          ],
                        ),
                        CarouselSlider(
                          items: imgList
                              .map((items) => Center(
                                    child: Image.asset(
                                      items,
                                      height: 200,
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index % colors.length;
                                });
                              }),
                        ),
                        const VerticalSpeacing(40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 18,
                              height: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color:
                                    currentIndex == 0 ? colors[0] : Colors.grey,
                              ),
                            ),
                            Container(
                              width: 10,
                              height: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color:
                                    currentIndex == 1 ? colors[1] : Colors.grey,
                              ),
                            ),
                            Container(
                              width: 10,
                              height: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color:
                                    currentIndex == 2 ? colors[2] : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpeacing(30),
                Text(
                  "Cauliflower Bangladeshi",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$30",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "\$20",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const IncreaseContainer()
                  ],
                ),
                const VerticalSpeacing(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "25 Kg",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                        ),
                        Text(
                          "Weight",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.grayColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Medum",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                        ),
                        Text(
                          "Size",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.grayColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "17",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                        ),
                        Text(
                          "Item’s",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.grayColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const VerticalSpeacing(20),
                Text(
                  "Pack Details",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(20),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Image.asset(
                        "images/fruit1.png",
                        height: 26,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Cabbage",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      "2 Kg",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Image.asset(
                        "images/fruit1.png",
                        height: 26,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Cabbage",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      "2 Kg",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Image.asset(
                        "images/fruit1.png",
                        height: 26,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Cabbage",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      "2 Kg",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Image.asset(
                        "images/fruit1.png",
                        height: 26,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Cabbage",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      "2 Kg",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Image.asset(
                        "images/fruit1.png",
                        height: 26,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Cabbage",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      "2 Kg",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Image.asset(
                        "images/fruit1.png",
                        height: 26,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Cabbage",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Text(
                      "2 Kg",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Review",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                const VerticalSpeacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 52,
                      width: 60,
                      color: const Color(0xffEDBCD4),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColor.fontColor,
                      ),
                    ),
                    Container(
                      height: 52,
                      width: MediaQuery.of(context).size.width / 1.5,
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
                            "Buy Now",
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
                  ],
                ),
                const VerticalSpeacing(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
