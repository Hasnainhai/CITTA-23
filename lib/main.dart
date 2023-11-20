import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'routes/routes_name.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.loginscreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
