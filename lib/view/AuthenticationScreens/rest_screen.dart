import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../res/components/custom_field.dart';
import '../../res/components/roundedButton.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({super.key});

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Forget Password",
          style: GoogleFonts.getFont(
            "Gothic A1",
            color: AppColor.fontColor,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.fontColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
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
                      const VerticalSpeacing(24),
                      Text(
                        "Reset Your Password",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ),
                      const VerticalSpeacing(24),
                      Text(
                        "Please enter your number. We will send a codeto your phone to reset your password.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ),
                      const VerticalSpeacing(30),
                      TextFieldCustom(
                        controller: emailController,
                        maxLines: 1,
                        text: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const VerticalSpeacing(24),
                      RoundedButton(title: "Send Me Link", onpress: () {}),
                      const VerticalSpeacing(300),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
