import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SiginButton extends StatelessWidget {
  final String buttonTitle;
  final String buttonImage;
  final Color borderColor;
  final Function() ontap;
  const SiginButton({
    super.key,
    required this.buttonTitle,
    required this.buttonImage,
    required this.borderColor,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 56,
        width: (MediaQuery.of(context).size.width / 2) - 40,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 34,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                buttonImage,
                height: 30,
                width: 30,
              ),
              Text(
                buttonTitle,
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: borderColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
