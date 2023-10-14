import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'colors.dart';

class OnButton extends StatelessWidget {
  final double progress;
  final Function()? onTap;

  const OnButton({super.key, required this.progress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 45,
      percent: progress,
      progressColor: AppColor.primaryColor,
      backgroundColor: AppColor.inActiveColor,
      center: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFFE0180),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
