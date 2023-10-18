import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.name,
    required this.categories,
    required this.price,
    required this.dPrice,
    required this.borderColor,
    required this.fillColor,
    required this.cartBorder,
    required this.img,
    required this.iconColor,
    required this.ontap,
  });
  final String img;
  final String name;
  final String categories;
  final String price;
  final String dPrice;
  final Color borderColor;
  final Color fillColor;
  final Color cartBorder;
  final Color iconColor;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 210.0,
          width: MediaQuery.of(context).size.width * 0.43,
          decoration: BoxDecoration(
            color: AppColor.appBarButtonColor,
            border: Border.all(width: 1, color: cartBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(20.0),
                Center(
                  child: InkWell(
                    onTap: ontap,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Image.asset(
                          img,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalSpeacing(6.0),
                Text.rich(
                  TextSpan(
                    text: '$name \n',
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColor.fontColor,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: categories,
                        style: const TextStyle(
                            color: AppColor.grayColor,
                            // fontWeight: FontWeight.w100,
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: price,
                            style: GoogleFonts.getFont(
                              "Gothic A1",
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: dPrice,
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 28.0,
                      width: 28.0,
                      decoration: BoxDecoration(
                        color: fillColor,
                        border: Border.all(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.add, color: iconColor),
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
