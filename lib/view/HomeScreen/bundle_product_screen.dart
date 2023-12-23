import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import 'widgets/increase_container.dart';

class BundleProductScreen extends StatefulWidget {
  const BundleProductScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.saleprice,
    required this.detail,
    required this.weight,
    required this.size,
    required this.img1,
    required this.title1,
    required this.amount1,
    required this.img2,
    required this.title2,
    required this.amount2,
    required this.img3,
    required this.title3,
    required this.amount3,
    required this.img4,
    required this.title4,
    required this.amount4,
    required this.img5,
    required this.title5,
    required this.amount5,
    required this.img6,
    required this.title6,
    required this.amount6,
    required this.id,
    required this.productId,
  });
  final String imageUrl;
  final String title;
  final String price;
  final String saleprice;
  final String detail;
  final String weight;
  final String size;
  final String id;
  final String productId;
  //bundle 1
  final String img1;
  final String title1;
  final String amount1;
  //bundle 2
  final String img2;
  final String title2;
  final String amount2;
  //bundle 3
  final String img3;
  final String title3;
  final String amount3;
  //bundle 4
  final String img4;
  final String title4;
  final String amount4;
  //bundle 5
  final String img5;
  final String title5;
  final String amount5;
  //bundle 6
  final String img6;
  final String title6;
  final String amount6;

  @override
  State<BundleProductScreen> createState() => _BundleProductScreenState();
}

class _BundleProductScreenState extends State<BundleProductScreen> {
  bool like = false;
  int currentIndex = 0;

  // List<Color> colors = [
  //   AppColor.primaryColor,
  //   AppColor.primaryColor,
  //   AppColor.primaryColor
  // ];
  // late List<String?> imgList;

  // @override
  // void initState() {
  //   super.initState();
  //   imgList = [
  //     widget.img1,
  //     widget.img2,
  //     widget.img3,
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    print(
        '........................................${widget.title1}............................');
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
                        Center(
                          child: SizedBox(
                            height: 250,
                            width: 250,
                            child: FancyShimmerImage(
                              imageUrl: widget.imageUrl,
                              boxFit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // CarouselSlider(
                        //   items: imgList
                        //       .where((item) =>
                        //           item != null) // Filter out null values
                        //       .map((item) => Center(
                        //             child: Image.network(
                        //               item!,
                        //               height: 200,
                        //             ),
                        //           ))
                        //       .toList(),
                        //   options: CarouselOptions(
                        //     enlargeCenterPage: true,
                        //     onPageChanged: (index, reason) {
                        //       setState(() {
                        //         currentIndex = index % colors.length;
                        //       });
                        //     },
                        //   ),
                        // ),
                        // const VerticalSpeacing(40),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       width: 18,
                        //       height: 5,
                        //       margin: const EdgeInsets.symmetric(horizontal: 3),
                        //       decoration: BoxDecoration(
                        //         color:
                        //             currentIndex == 0 ? colors[0] : Colors.grey,
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 10,
                        //       height: 5,
                        //       margin: const EdgeInsets.symmetric(horizontal: 3),
                        //       decoration: BoxDecoration(
                        //         color:
                        //             currentIndex == 1 ? colors[1] : Colors.grey,
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 10,
                        //       height: 5,
                        //       margin: const EdgeInsets.symmetric(horizontal: 3),
                        //       decoration: BoxDecoration(
                        //         color:
                        //             currentIndex == 2 ? colors[2] : Colors.grey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpeacing(30),
                Text(
                  widget.title,
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
                          widget.price,
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
                          widget.saleprice,
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
                          widget.weight,
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
                          widget.size,
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
                // first bundle product
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FancyShimmerImage(
                          imageUrl: widget.img1,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title1,
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
                            height:
                                4, // Adjust spacing between title and amount
                          ),
                          Text(
                            widget.amount1,
                            // widget.amount1,
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
                    ),
                  ],
                ),

                const VerticalSpeacing(10),
                // second bundle product
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FancyShimmerImage(
                          imageUrl: widget.img2,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title2,
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
                            height:
                                4, // Adjust spacing between title and amount
                          ),
                          Text(
                            widget.amount2,
                            // widget.amount1,
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
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                // third bundle product
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FancyShimmerImage(
                          imageUrl: widget.img3,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title3,
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
                            height:
                                4, // Adjust spacing between title and amount
                          ),
                          Text(
                            widget.amount3,
                            // widget.amount1,
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
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                // fourth Bundle product
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FancyShimmerImage(
                          imageUrl: widget.img4,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title4,
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
                            height:
                                4, // Adjust spacing between title and amount
                          ),
                          Text(
                            widget.amount4,
                            // widget.amount1,
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
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                // fifth Bundle product detail
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FancyShimmerImage(
                          imageUrl: widget.img5,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title5,
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
                            height:
                                4, // Adjust spacing between title and amount
                          ),
                          Text(
                            widget.amount5,
                            // widget.amount1,
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
                    ),
                  ],
                ),
                const VerticalSpeacing(10),
                // sixth Bundle product
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColor.buttonTxColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FancyShimmerImage(
                          imageUrl: widget.img6,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title6,
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
                            height:
                                4, // Adjust spacing between title and amount
                          ),
                          Text(
                            widget.amount6,
                            // widget.amount1,
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
