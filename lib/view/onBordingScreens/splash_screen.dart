import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/onBordingScreens/onbording_screen1.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds and then navigate to the next screen
    Future.delayed(const Duration(seconds: 5), () {
      MaterialPageRoute(builder: (context) => const OnBordingScreen1());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.splashBgColor,
      body: SafeArea(
        child: Column(
          children: [
            const VerticalSpeacing(200),
            Container(
              alignment: Alignment.center,
              height: 57.87,
              width: 195,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                const SizedBox(
                  height: 450,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: -100,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'images/splash.png',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
