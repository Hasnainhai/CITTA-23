// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() async {
    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        await Firebase.initializeApp();
        if (FirebaseAuth.instance.currentUser != null) {
          await Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.dashboardScreen, (routes) => false);
        } else {
          await Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.onboarding1, (routes) => false);
        }
      } catch (e) {
        Utils.flushBarErrorMessage('$e', context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
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
