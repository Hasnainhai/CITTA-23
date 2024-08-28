// ignore_for_file: file_names
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/authButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  void startTimer() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      try {
        if (FirebaseAuth.instance.currentUser != null) {
          await Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.dashboardScreen, (routes) => false);
        } else {
          await Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.loginscreen, (routes) => false);
        }
      } catch (e) {
        Utils.flushBarErrorMessage('$e', context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // startTimer();
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
            const Center(
              child: Text.rich(
                TextSpan(
                  text: 'Welcome to our \n',
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: AppColor.fontColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Vegan Life Style',
                      style: TextStyle(
                          fontFamily: 'CenturyGothic',
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.loginscreen, (routes) => false);
                }),
            const VerticalSpeacing(50.0),
            const Text(
              'OR',
              style: TextStyle(
                fontFamily: 'CenturyGothic',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColor.fontColor,
              ),
            ),
            const VerticalSpeacing(50.0),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: AuthButton(
                buttonText: 'SignUp with Google',
              ),
            ),
          ],
        )),
      ),
    );
  }
}
