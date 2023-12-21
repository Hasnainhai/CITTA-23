import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';

class FavouristListCart extends StatelessWidget {
  const FavouristListCart({
    super.key,
    required this.img,
    required this.title,
    required this.price,
    required this.deleteIcon,
    required this.shoppingIcon,
    required this.ontap,
    required this.ontap2,
  });

  final String img;
  final String title;
  final String price;
  final IconData deleteIcon;
  final IconData shoppingIcon;
  final Function ontap;
  final Function ontap2;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: Colors.white,
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: ListTile(
              leading: SizedBox(
                height: 80.0,
                width: 58.0,
                child: FancyShimmerImage(
                  imageUrl: img,
                  boxFit: BoxFit.fill,
                ),
              ),
              title: Row(
                children: [
                  const SizedBox(width: 30.0),
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '\n$title \n',
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColor.fontColor,
                            ),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: price,
                              style: const TextStyle(
                                color: AppColor.fontColor,
                                // fontWeight: FontWeight.w100,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      ontap();
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: AppColor.fontColor,
                      size: 24,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ontap2();
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColor.fontColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
