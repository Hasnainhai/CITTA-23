import 'package:citta_23/view/HomeScreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
      // home: HomeScreen(),
    );
  }
}
