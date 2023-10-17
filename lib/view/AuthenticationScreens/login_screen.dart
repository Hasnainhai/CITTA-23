import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/sigin_buttons.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const VerticalSpeacing(40.0),
                Container(
                  height: 80.0,
                  width: 215.0,
                  color: AppColor.logoBgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const VerticalSpeacing(50.0),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Welcome to our \n',
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          color: AppColor.fontColor,
                        ),
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Vegan Life Style',
                          style: TextStyle(
                              color: AppColor.buttonBgColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 30.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpeacing(80.0),
                TextFieldCustom(
                  controller: emailController,
                  maxLines: 1,
                  text: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFieldCustom(
                  controller: passwordController,
                  maxLines: 1,
                  text: 'Your Password',
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.restscreen,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password?",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(30),
                RoundedButton(
                    title: "Login",
                    onpress: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.homeScreen, (route) => false);
                    }),
                const VerticalSpeacing(30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SiginButton(
                      buttonTitle: 'Google',
                      buttonImage: 'images/google.png',
                      borderColor: AppColor.googleColor,
                      ontap: () {},
                    ),
                    SiginButton(
                      buttonTitle: 'Apple',
                      buttonImage: 'images/apple.png',
                      borderColor: AppColor.fontColor,
                      ontap: () {},
                    ),
                  ],
                ),
                const VerticalSpeacing(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t Have Account?",
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
                        Navigator.pushNamed(context, RoutesName.registerScreen);
                      },
                      child: Text(
                        "Sign up",
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
                const VerticalSpeacing(90.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
