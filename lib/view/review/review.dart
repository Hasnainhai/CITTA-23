// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/firebase_const.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/review/rating_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import '../../res/components/custom_field.dart';

class Rating extends StatefulWidget {
  const Rating({
    Key? key,
    required this.productId,
    required this.productType,
  }) : super(key: key);
  final String productId;
  final String productType;
  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    RatingRepository ratingRepository = RatingRepository();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.fontColor,
            )),
        title: Text(
          "Submit Review",
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                Map<String, dynamic> userData =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    const VerticalSpeacing(20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: const NetworkImage(
                                  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                              foregroundImage: NetworkImage(
                                userData['profilePic'] ??
                                    FirebaseAuth.instance.currentUser!.photoURL,
                              ),
                              // User Image URL
                            ),
                            const VerticalSpeacing(30),
                            Text(
                              userData['name'] ??
                                  FirebaseAuth
                                      .instance.currentUser!.displayName,
                              style: GoogleFonts.getFont(
                                "Gothic A1",
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.fontColor,
                                ),
                              ),
                            ),
                            const VerticalSpeacing(25),
                            Text(
                              "How would you rate the quality of this Products",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                "Gothic A1",
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.fontColor,
                                ),
                              ),
                            ),
                            const VerticalSpeacing(25),
                            RatingBar.builder(
                                initialRating: 4,
                                minRating: 1,
                                allowHalfRating: true,
                                glowColor: Colors.amber,
                                itemCount: 5,
                                itemSize: 55,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {
                                  countRatingStars = rating;
                                }),
                            const VerticalSpeacing(25),
                            TextFieldCustom(
                              controller: commentController,
                              maxLines: 6,
                              hintText: "Additional comments...",
                              text: 'Leave a your valuable comments',
                            ),
                            const VerticalSpeacing(30),
                            RoundedButton(
                              title: 'Submmit Review',
                              onpress: () async {
                                if (commentController.text.isNotEmpty) {
                                  ratingRepository.giveRatings(
                                      widget.productId,
                                      commentController.text,
                                      context,
                                      userData['name'] ??
                                          FirebaseAuth.instance.currentUser!
                                              .displayName,
                                      userData['profilePic'] ??
                                          FirebaseAuth
                                              .instance.currentUser!.photoURL,
                                      widget.productType);
                                } else {
                                  Utils.flushBarErrorMessage(
                                      "Must write your Review", context);
                                }
                              },
                            ),
                            const VerticalSpeacing(40),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      )),
    );
  }
}
