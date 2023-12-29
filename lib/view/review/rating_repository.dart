import 'package:citta_23/res/consts/firebase_const.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RatingRepository {
  void giveRatings(String productId, String comment, context) {
    CollectionReference rateDriverRef = FirebaseFirestore.instance
        .collection("products")
        .doc("lJlxtZy4TShqYz5E3B0c")
        .collection("ratings");

    rateDriverRef.get().then(
      (snap) {
        if (snap.docs.isEmpty) {
          rateDriverRef.add({"rating": countRatingStars});
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const DashBoardScreen(),
            ),
          );
        } else {
          double pastRatings = snap.docs.first.get("rating");
          double newAverageRating = (pastRatings + countRatingStars!) / 2;

          rateDriverRef.doc(snap.docs.first.id).set(
            {"rating": newAverageRating},
          );

          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const DashBoardScreen(),
            ),
          );
        }

        // Use Fluttertoast or any other notification method as needed
        // Fluttertoast.showToast(
        //   msg: "Restarting the app now",
        // );
      },
    );

    var uuid = const Uuid().v1();
    String time = DateTime.now().toString();
    Map<String, dynamic> commentMap = {
      "comment": comment,
      "currentUserRating": countRatingStars,
      "time": time,
      "userName": "userDataName", // Replace with actual user data
      "profilePic": "profilePic", // Replace with actual user data
    };

    FirebaseFirestore.instance
        .collection("products")
        .doc("lJlxtZy4TShqYz5E3B0c")
        .collection("commentsAndRatings")
        .doc(uuid)
        .set(commentMap);
  }
}
