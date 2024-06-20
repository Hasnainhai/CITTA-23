// ignore_for_file: file_names, camel_case_types

import 'package:citta_23/view/trackOrder/track_order.dart';
import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';

class myOrderCard extends StatefulWidget {
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
    required this.title,
    required this.phoneNumber,
    required this.weight,
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
  final String title;
  final String phoneNumber;
  final String weight;

  @override
  State<myOrderCard> createState() => _myOrderCardState();
}

class _myOrderCardState extends State<myOrderCard> {
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
                  widget.date,
                  style: const TextStyle(
                    color: AppColor.grayColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    debugPrint("this is the img:${widget.img}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => TrackOrder(
                          title: widget.title,
                          date: widget.date,
                          status: widget.status,
                          weight: "weight",
                          items: "items",
                          price: widget.salePrice,
                          orderId: widget.orderId,
                          img: widget.img,
                        ),
                      ),
                    );
                  },
                  child: Container(
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
                    widget.ontap();
                  },
                  child: Text(
                    widget.status,
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
