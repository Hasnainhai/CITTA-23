// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.name,
    required this.price,
    required this.dPrice,
    required this.borderColor,
    required this.fillColor,
    required this.cartBorder,
    required this.img,
    required this.iconColor,
    required this.ontap, required this.addCart,
  });
  final String img;
  final String name;
  final String price;
  final String dPrice;
  final Color borderColor;
  final Color fillColor;
  final Color cartBorder;
  final Color iconColor;
  final Function() ontap;
  final Function() addCart;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.43,
          decoration: const BoxDecoration(
            color: Color(0xffF7F7F7),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(15.0),
                Center(
                  child: InkWell(
                    onTap: ontap,
                    child: SizedBox(
                      height: 86,
                      width: 86,
                      child: FancyShimmerImage(
                        imageUrl: img,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const VerticalSpeacing(6.0),
                Text(
                  name.length > 8 ? '${name.substring(0, 8)}...' : name,
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: price,
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          TextSpan(
                            text: dPrice,
                            style: GoogleFonts.getFont(
                              "Gothic A1",
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        addCart();
                      },
                      child: Container(
                        height: 28.0,
                        width: 28.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            width: 1.0,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.add, color: AppColor.primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
