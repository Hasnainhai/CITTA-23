import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth authInstance = FirebaseAuth.instance;
final User? user = authInstance.currentUser;
final uid = user!.uid;
int totalPrice = 0;
double? countRatingStars;
List<Map<String, dynamic>> productList = [];
