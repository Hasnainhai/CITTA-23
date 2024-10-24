// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class TopQuestion extends StatelessWidget {
  const TopQuestion({super.key, required this.question, required this.onpress});
  final String question;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onpress,
          child:
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
              Icons.keyboard_arrow_down_outlined,
              color: AppColor.primaryColor,
              size: 16,
            )
          ]),
        ),
      ],
    );
  }
}
