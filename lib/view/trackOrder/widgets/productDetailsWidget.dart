// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.img,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.productPrice,
    required this.procustAverate,
    required this.productId,
    required this.id,
  });

  final String img;
  final String title;
  final String subTitle;
  final String price;
  final String productPrice;
  final String procustAverate;
  final String productId;
  final String id;
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
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColor.fontColor,
                            ),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '$subTitle \n \n',
                              style: const TextStyle(
                                color: AppColor.fontColor,
                                // fontWeight: FontWeight.w100,
                                fontSize: 16.0,
                              ),
                            ),
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
                  Text(
                    productPrice,
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.fontColor,
                      ),
                    ),
                  ),
                  Text(
                    procustAverate,
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grayColor,
                      ),
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
