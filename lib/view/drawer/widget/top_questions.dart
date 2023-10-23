// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';

class TopQuestion extends StatelessWidget {
  const TopQuestion({
    Key? key,
    required this.question,
  }) : super(key: key);
  final String question;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            question,
            style: GoogleFonts.getFont(
              "Gothic A1",
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.grayColor,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColor.grayColor,
            size: 14,
          )
        ]),
        const Divider()
      ],
    );
  }
}