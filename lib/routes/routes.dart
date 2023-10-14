import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/onBordingScreens/onboarding_screen2.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.onboarding1:
        return MaterialPageRoute(
            builder: (context) => const OnBordingScreen2());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No routes define'),
            ),
          );
        });
    }
  }
}
