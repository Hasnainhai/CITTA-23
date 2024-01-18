// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';

// ignore: camel_case_types
class myOrderCard extends StatelessWidget {
  const myOrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.ontap,
    required this.img,
    required this.amount,
    required this.shippingAddress,
    required this.salePrice,
    required this.sellerId,
  });
  final String orderId;
  final String date;
  final String status;
  final Function ontap;
  final String img;
  final String amount;
  final String shippingAddress;
  final String salePrice;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114.0,
      width: double.infinity,
      color: AppColor.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColor.grayColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  height: 30,
                  width: 80,
                  color: AppColor.primaryColor,
                  child: const Center(
                    child: Text(
                      'Track Order',
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(
                    color: AppColor.grayColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ontap();
                  },
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
