// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
      height: MediaQuery.of(context).size.height / 7.6,
      child: Card(
        shape: const RoundedRectangleBorder(),
        color: Colors.white,
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 58.0,
                        width: 58.0,
                        child: Image.network(img),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColor.fontColor,
                            ),
                          ),
                          Text(
                            subTitle,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productPrice,
                        style: const TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                      Text(
                        procustAverate,
                        style: const TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
