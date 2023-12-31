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
  });
  final String orderId;
  final String date;
  final String status;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      color: AppColor.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Order ID: ',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: orderId.length > 6
                            ? orderId.substring(0, 6)
                            : orderId,
                        style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColor.grayColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
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
