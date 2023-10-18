import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';


class ItemPrizingWidget extends StatelessWidget {
  const ItemPrizingWidget({
    super.key, required this.title, required this.price,
  });
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.grayColor,
            ),
          ),
        ),
         Text(
          price,
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColor.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}