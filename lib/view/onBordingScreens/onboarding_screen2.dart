import 'package:citta_23/view/onBordingScreens/onboarding_screen3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              const VerticalSpeacing(60),
              Text(
                "Amazing Discounts & Offers",
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor),
                ),
              ),
              const VerticalSpeacing(16),
              Text(
                "In aliquip aute exercitation ut et nisi ut mollit. Deserunt dolor elit pariatur aute .",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
              ),
              const VerticalSpeacing(66),
              OnButton(
                progress: 0.6,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const OnBordingScreen3()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
