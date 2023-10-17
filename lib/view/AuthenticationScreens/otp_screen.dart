import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/AuthenticationScreens/verification_popup.dart';
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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        VerticalSpeacing(
                            MediaQuery.of(context).size.height / 20),
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
                        VerticalSpeacing(
                            MediaQuery.of(context).size.height / 20),
                        Pinput(
                          length: 4,
                          onChanged: (value) {
                            otp = value;
                          },
                        ),
                        VerticalSpeacing(
                            MediaQuery.of(context).size.height / 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account?",
                              style: GoogleFonts.getFont(
                                "Gothic A1",
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.fontColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Resend",
                                style: GoogleFonts.getFont(
                                  "Gothic A1",
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalSpeacing(
                            MediaQuery.of(context).size.height / 20),
                        RoundedButton(
                            title: "Verify",
                            onpress: () async {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const VerficationPopUp(),
                              );
                            }),
                        VerticalSpeacing(
                            MediaQuery.of(context).size.height / 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
