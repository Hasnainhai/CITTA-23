import 'package:citta_23/models/index_model.dart';
import 'package:citta_23/models/sub_total_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart';
import 'routes/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51MqJ7aSDFxQSCBeqlY6oQU8xdJEsaAiESLWghEUnYHUHYnCjJrbJMaIpSyVopiqfnyym9H4Gcvg5kNmiHcUThznT00QSiE5jbT";
  Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SubTotalModel>(
          create: (context) => SubTotalModel(),
        ),
        ChangeNotifierProvider<IndexModel>(
          create: ((context) => IndexModel()),
        ),
        ChangeNotifierProvider<DiscountSum>(
          create: ((context) => DiscountSum()),
        ),
        ChangeNotifierProvider(
            create: (_) => TotalPriceModel()), // Add this line
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
          background: const Color(0xffFFFFFF),
        ), // Set the background color here
      ),
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
