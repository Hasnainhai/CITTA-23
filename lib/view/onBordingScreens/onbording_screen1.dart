import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../res/components/verticalSpacing.dart';

class OnBordingScreen1 extends StatelessWidget {
  const OnBordingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            const VerticalSpeacing(80),
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/onboarding1.png"),
                ),
              ),
            ),
            const VerticalSpeacing(60),
            const Text(
              "Browse all the category",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: AppColor.fontColor),
            ),
            const VerticalSpeacing(16),
            const Text(
              "In aliquip aute exercitation ut et nisi ut mollit. Deserunt dolor elit pariatur aute .",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const VerticalSpeacing(66),
            CircularPercentIndicator(
              radius: 56,
              percent: 0.3,
              progressColor: AppColor.primaryColor,
              backgroundColor: AppColor.inActiveColor,
              center: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffFE0180),
                        blurRadius: 11,
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
            ),
          ],
        ),
      )),
    );
  }
}
