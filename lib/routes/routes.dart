import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/AuthenticationScreens/login_screen.dart';
import 'package:citta_23/view/AuthenticationScreens/loginorSignup.dart';
import 'package:citta_23/view/AuthenticationScreens/otp_screen.dart';
import 'package:citta_23/view/AuthenticationScreens/registration_screen.dart';
import 'package:citta_23/view/AuthenticationScreens/rest_screen.dart';
import 'package:citta_23/view/HomeScreen/homeScreen.dart';
import 'package:citta_23/view/onBordingScreens/onboarding_screen2.dart';
import 'package:citta_23/view/onBordingScreens/onboarding_screen3.dart';
import 'package:citta_23/view/onBordingScreens/splash_screen.dart';
import 'package:flutter/material.dart';
import '../view/AuthenticationScreens/login_or_signin_screen.dart';
import '../view/onBordingScreens/onbording_screen1.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case RoutesName.onboarding1:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnBordingScreen1(),
        );
      case RoutesName.onboarding2:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnBordingScreen2(),
        );
      case RoutesName.onboarding3:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnBordingScreen3(),
        );
      case RoutesName.loginOrSignup:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginOrSignUp(),
        );
      case RoutesName.loginorsiginscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginOrSigninScreen(),
        );

      case RoutesName.loginscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );

      case RoutesName.restscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RestScreen(),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case RoutesName.otpscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OtpScreen(),
        );
      case RoutesName.registerScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RegisterScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No routes define'),
              ),
            );
          },
        );
    }
  }
}
