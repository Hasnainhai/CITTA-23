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
  });

  final String img;
  final String title;
  final String price;
  final IconData deleteIcon;
  final IconData shoppingIcon;
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
                child: Image.asset(img),
              ),
              title: Row(
                children: [
                  const SizedBox(width: 30.0),
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '$title \n',
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
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: AppColor.fontColor,
                    size: 24,
                  ),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColor.fontColor,
                    size: 24,
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
