// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class TopQuestion extends StatelessWidget {
  const TopQuestion({
    super.key,
    required this.question,
  });
  final String question;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            question,
            style: const TextStyle(
              fontFamily: 'CenturyGothic',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColor.primaryColor,
            size: 16,
          )
        ]),
        const Divider()
      ],
    );
  }
}
