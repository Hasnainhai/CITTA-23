import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 29, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpeacing(60),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "Welcome to our",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ),
                      Text(
                        "Vegan Life Style",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to our",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ),
                      const VerticalSpeacing(30),
                      TextFieldCustom(
                        controller: nameController,
                        maxLines: 1,
                        text: "Name",
                      ),
                      const VerticalSpeacing(30),
                      TextFieldCustom(
                        controller: nameController,
                        maxLines: 1,
                        text: "Email",
                      ),
                      const VerticalSpeacing(30),
                      TextFieldCustom(
                        controller: nameController,
                        maxLines: 1,
                        text: "Password",
                        obscureText: true,
                      ),
                      const VerticalSpeacing(30),
                      RoundedButton(
                          title: "Register",
                          onpress: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.otpscreen,
                            );
                          }),
                      const VerticalSpeacing(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account",
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
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.loginscreen);
                            },
                            child: Text(
                              "Log In",
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
                      const VerticalSpeacing(30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
