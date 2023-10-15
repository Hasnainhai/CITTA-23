import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';

import '../../res/components/colors.dart';

class LoginOrSigninScreen extends StatelessWidget {
  const LoginOrSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/log.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpeacing(80.0),
                    Text(
                      "Welcome to our",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w400,
                            color: AppColor.fontColor),
                      ),
                    ),
                    Text(
                      "Vegan Life Style",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w400,
                            color: AppColor.primaryColor),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
