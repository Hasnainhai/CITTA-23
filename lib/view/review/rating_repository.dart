import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RatingRepository {
  void giveRatings(String productId, String comment, context, String userName,
      String userProfile, String produtType, double? countRatingStars) {
    CollectionReference rateDriverRef = FirebaseFirestore.instance
        .collection(produtType)
        .doc(productId)
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
      },
    );
    var uuid = const Uuid().v1();
    String time = DateTime.now().toString();
    Map<String, dynamic> commentMap = {
      "comment": comment,
      "currentUserRating": countRatingStars,
      "time": time,
      "userName": userName, // Replace with actual user data
      "profilePic": userProfile, // Replace with actual user data
    };

    FirebaseFirestore.instance
        .collection(produtType)
        .doc(productId)
        .collection("commentsAndRatings")
        .doc(uuid)
        .set(commentMap);
    _updateOrAddAverageReview(produtType, productId, countRatingStars);
  }

  void _updateOrAddAverageReview(
      String produtType, String productId, double? newRating) {
    DocumentReference productRef =
        FirebaseFirestore.instance.collection(produtType).doc(productId);

    productRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // Document exists, update the average review if the node exists
        var docData = docSnapshot.data() as Map<String, dynamic>?;
        if (docData != null && docData.containsKey("averageReview")) {
          double pastAverageRating = docData["averageReview"] ?? 0.0;
          int reviewCount = docData["reviewCount"] ?? 0;
          double updatedAverageRating =
              ((pastAverageRating * reviewCount) + newRating!) /
                  (reviewCount + 1);

          productRef.update({
            "averageReview": updatedAverageRating,
            "reviewCount": reviewCount + 1,
          });
        } else {
          // If averageReview node does not exist, create it
          productRef.update({
            "averageReview": newRating,
            "reviewCount": 1,
          });
        }
      } else {
        // Document does not exist, set the initial average review
        productRef.set({
          "averageReview": newRating,
          "reviewCount": 1,
        });
      }
    });
  }
}
