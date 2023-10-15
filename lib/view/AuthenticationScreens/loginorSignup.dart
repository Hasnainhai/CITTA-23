import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/authButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginOrSignUp extends StatelessWidget {
  const LoginOrSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: <Widget>[
            const VerticalSpeacing(80.0),
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
            const VerticalSpeacing(50.0),
            RoundedButton(
                title: 'Login With Email',
                onpress: () {
                  Navigator.pushNamed(context, RoutesName.loginscreen);
                }),
            const VerticalSpeacing(50.0),
            Text(
              'OR',
              style: GoogleFonts.getFont(
                "Gothic A1",
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColor.fontColor,
                ),
              ),
            ),
            const VerticalSpeacing(50.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  'images/apple.png',
                  height: 20,
                  width: 20,
          
                AuthButton(color: AppColor.appleColor, img: 'images/apple.png'),
                AuthButton(
                    color: AppColor.googleColor, img: 'images/google.png'),
                AuthButton(
                    color: AppColor.twitterColor, img: 'images/twitter.png'),
                AuthButton(color: AppColor.fbColor, img: 'images/fb.png'),

              ],
            ),
          ],
        )),
      ),
    );
  }
}
