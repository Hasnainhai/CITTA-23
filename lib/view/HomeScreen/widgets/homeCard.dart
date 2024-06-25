// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
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
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              VerticalSpeacing(oofProd == true ? 0 : 20),
              Center(
                child: InkWell(
                  onTap: ontap,
                  child: SizedBox(
                    height: oofProd == true ? 60 : 70,
                    width: oofProd == true ? 60 : 70,
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
                  Text(
                    name.length > 8 ? '${name.substring(0, 8)}...' : name,
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColor.fontColor,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Text(
                        '$productRating',
                        style: const TextStyle(color: AppColor.fontColor),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: price,
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        TextSpan(
                          text: dPrice,
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: addCart,
                    child: Container(
                      height: 28.0,
                      width: 28.0,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        border: Border.all(
                          width: 1.0,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.add, color: AppColor.whiteColor),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
