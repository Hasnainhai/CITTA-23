import 'package:citta_23/view/Checkout/widgets/myCheckout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/components/colors.dart';

class AddressCheckOutWidget extends StatelessWidget {
  const AddressCheckOutWidget({
    super.key,
    required this.bgColor,
    required this.borderColor,
    required this.titleColor,
    required this.title,
    required this.phNo,
    required this.address,
  });
  final Color bgColor;
  final Color borderColor;
  final Color titleColor;
  final String title;
  final String phNo;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: bgColor, border: Border.all(width: 2, color: borderColor)),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCheckBox(),
            const SizedBox(width: 15.0),
            Text.rich(
              TextSpan(
                text: '$title \n ',
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '($phNo\n',
                    style: const TextStyle(
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  TextSpan(
                    text: address,
                    style: const TextStyle(
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
