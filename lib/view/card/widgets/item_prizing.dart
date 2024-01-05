import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class ItemPrizingWidget extends StatelessWidget {
  const ItemPrizingWidget({
    super.key,
    required this.title,
    required this.price,
  });
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColor.grayColor,
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColor.blackColor,
          ),
        ),
      ],
    );
  }
}
