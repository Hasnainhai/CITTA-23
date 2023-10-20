import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: RoutesName.home,
      onGenerateRoute: Routes.generateRoute,
      home: DashBoardScreen(),
    );
  }
}
