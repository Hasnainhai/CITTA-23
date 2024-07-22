import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/view/HomeScreen/total_reviews/widgets/detail_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyReview extends StatefulWidget {
  const MyReview({super.key});

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Profile ',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('yourReviews')
                .orderBy("time", descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    'No comments and ratings available',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColor.fontColor,
                    ),
                  ),
                );
              }

              // Limit the number of items to 2
              final limitedDocs = snapshot.data!.docs.take(2).toList();

              return ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: limitedDocs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data =
                      limitedDocs[index].data() as Map<String, dynamic>;
                  return DetailRating(
                    userName: data['userName'],
                    img: data['productImg'],
                    comment: data['comment'],
                    rating: data['currentUserRating'].toString(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10),
              );
            },
          ),
        ),
      ),
    );
  }
}
