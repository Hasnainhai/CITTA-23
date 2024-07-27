// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

// ignore: must_be_immutable
class HomeCard extends StatelessWidget {
  HomeCard({
    super.key,
    required this.name,
    required this.price,
    required this.dPrice,
    required this.borderColor,
    required this.fillColor,
    required this.img,
    required this.iconColor,
    required this.ontap,
    required this.addCart,
    required this.productId,
    required this.sellerId,
    this.oofProd,
    this.percentage,
    required this.productRating,
  });
  final String img;
  final String name;
  final String price;
  final String dPrice;
  final Color borderColor;
  final Color fillColor;
  final Color iconColor;
  final Function() ontap;
  final Function() addCart;
  final String productId;
  final String sellerId;
  bool? oofProd;
  String? percentage;
  final double productRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: const BoxDecoration(
        color: Color(0xffF7F7F7),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            oofProd == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 6),
                    child: Container(
                      width: 50,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Center(
                        child: Text(
                          '$percentage% off',
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            VerticalSpeacing(
                oofProd == true ? 0 : MediaQuery.of(context).size.height / 38),
            Center(
              child: InkWell(
                onTap: ontap,
                child: SizedBox(
                  height: oofProd == true
                      ? MediaQuery.of(context).size.height / 11
                      : MediaQuery.of(context).size.height / 9,
                  width: oofProd == true ? 75 : 85,
                  child: FancyShimmerImage(
                    imageUrl: img,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const VerticalSpeacing(6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.length > 14 ? '${name.substring(0, 14)}...' : name,
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColor.fontColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColor.fontColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          dPrice,
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColor.fontColor,
                          ),
                        )
                      ],
                    ),
                    RatingBar.builder(
                      initialRating: productRating,
                      minRating: 1,
                      tapOnlyMode: true,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      glowColor: Colors.amber,
                      itemCount: 5,
                      itemSize: 14,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: addCart,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 40,
                        width: MediaQuery.of(context).size.width / 18,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          border: Border.all(
                            width: 1.0,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: AppColor.whiteColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    const VerticalSpeacing(16),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
