import 'dart:async';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() {
    Timer(const Duration(seconds: 6), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushNamed(context, RoutesName.dashboardScreen);
      } else {
        Navigator.pushNamed(context, RoutesName.onboarding1);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    // Delay for 5 seconds and then navigate to the next screen
    // Future.delayed(const Duration(seconds: 5), () {
    //   Navigator.pushNamed(context, RoutesName.onboarding1);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.splashBgColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splash.png"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              VerticalSpeacing(MediaQuery.of(context).size.height / 4),
              Container(
                height: 58,
                width: 195,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/logo.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
