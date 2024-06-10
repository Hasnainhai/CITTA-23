// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        decoration: BoxDecoration(
            color: const Color(0xffF7F7F7),
            border:
                Border.all(width: 1, color: AppColor.homeCartborderColor)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpeacing(14.0),
              Center(
                child: InkWell(
                  onTap: ontap,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: FancyShimmerImage(
                      imageUrl: img,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const VerticalSpeacing(6.0),
              Text(
                name.length > 8 ? '${name.substring(0, 8)}...' : name,
                style: const TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColor.fontColor,
                ),
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
                    onTap: () {
                      addCart();
                    },
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
