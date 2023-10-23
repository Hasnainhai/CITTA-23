import 'package:citta_23/res/components/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';
import '../widgets/coupon_card.dart';

class CouponDetail extends StatelessWidget {
  const CouponDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Coupon Details ',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back,
          color: AppColor.blackColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpeacing(20.0),
            CouponCard(ontap: () {}, img: 'images/offer1.png'),
            const VerticalSpeacing(40.0),
            Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  text: '41% off only for you. To get this discount\n',
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.w600),
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text: '        collect and apply the voucher.',
                      style: TextStyle(
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalSpeacing(30.0),
            Row(
              children: [
                Container(
                  height: 5,
                  width: 20,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(width: 20.0),
                Text.rich(
                  TextSpan(
                    text: 'Redeemable At All Sulphurfree Bura\n',
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w600),
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'And Black Coffee',
                        style: TextStyle(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(16.0),
            Row(
              children: [
                Container(
                  height: 5,
                  width: 20,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(width: 20.0),
                Text.rich(
                  TextSpan(
                    text: 'Not Valid With Any Other Discount \n',
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w600),
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'And Promotion',
                        style: TextStyle(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(16.0),
            Row(
              children: [
                Container(
                  height: 5,
                  width: 20,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(width: 20.0),
                Text.rich(
                  TextSpan(
                    text: 'Vaild For Sulphurfree, Coffee,\n And Tea Only',
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(16.0),
            Row(
              children: [
                Container(
                  height: 5,
                  width: 20,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(width: 20.0),
                Text.rich(
                  TextSpan(
                    text: 'No Cash Value',
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(30.0),
            Text(
              'Exp 12/12/2020',
              style: GoogleFonts.getFont(
                "Gothic A1",
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const VerticalSpeacing(30.0),
            RoundedButton(title: 'Redeem Now', onpress: () {}),
            //  VerticalSpeacing(10.0),
            Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Terms and Conditions',
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
