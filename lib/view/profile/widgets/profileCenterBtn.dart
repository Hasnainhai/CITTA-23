// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';

// ignore: camel_case_types
class profileCenterBtns extends StatelessWidget {
  const profileCenterBtns(
      {super.key,
      required this.tColor,
      required this.bColor,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.ontap});

  final Color tColor;
  final Color bColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            ontap();
          },
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tColor, bColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0],
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: AppColor.whiteColor,
              ),
            ),
          ),
        ),
        const VerticalSpeacing(10.0),
        Text.rich(
          TextSpan(
            text: '$title\n',
            style: GoogleFonts.getFont(
              "Gothic A1",
              textStyle: const TextStyle(
                  fontSize: 12,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w600),
            ),
            children: <TextSpan>[
              TextSpan(
                text: subtitle,
                style: const TextStyle(
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
