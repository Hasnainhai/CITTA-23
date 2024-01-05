import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/components/colors.dart';
import '../../res/components/onboarding_button.dart';
import '../../res/components/widgets/verticalSpacing.dart';

class OnBordingScreen2 extends StatelessWidget {
  const OnBordingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const VerticalSpeacing(80),
                Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/onboarding2.png"),
                    ),
                  ),
                ),
                const VerticalSpeacing(30),
                const Text(
                  "Amazing Discounts & Offers",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                const VerticalSpeacing(16),
                const Text(
                  "In aliquip aute exercitation ut et nisi ut mollit. Deserunt dolor elit pariatur aute .",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                const VerticalSpeacing(46),
                OnButton(
                  progress: 0.6,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.onboarding3);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
