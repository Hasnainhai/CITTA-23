import 'package:citta_23/routes/routes.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.loginOrSignup,
      onGenerateRoute: Routes.generateRoute,
    );

  }
}
