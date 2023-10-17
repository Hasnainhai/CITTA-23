import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../res/components/colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    VerticalSpeacing(MediaQuery.of(context).size.height / 20),
                    Text(
                      "Entry Your 4 digit code",
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColor.grayColor,
                        ),
                      ),
                    ),
                    Image.asset(
                      "images/mail_box.png",
                    ),
                  ],
                ),
              ),
              Pinput(
                length: 4,
                onChanged: (value) {
                  otp = value;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
