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
  Stripe.publishableKey = "";
  // "pk_live_51MqJ7aSDFxQSCBeqQ84Nu6z4Tz5S0UL2ExT0tNT0l0HnOuuqHwGGmPGXuaUYpuudJ1H5I4nr4bxeScgIEfk9tIPQ00Lr668Udh";
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
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
