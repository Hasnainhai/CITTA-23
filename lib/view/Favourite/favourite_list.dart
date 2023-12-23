import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import 'widgets/favourite_list_cart.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key});

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  final _firestoreInstance = FirebaseFirestore.instance;
  //fetch user favourite data
  Future<List<Map<String, dynamic>?>> getUserFavorites() async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Retrieve the favorite list for the current user
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestoreInstance
          .collection('favoriteList')
          .doc(uid)
          .collection('favorites')
          .get();

      // Convert the snapshot data to a list of maps
      List<Map<String, dynamic>?> favoritesList = snapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
          .toList();

      return favoritesList;
    } catch (e) {
      // Handle errors
      Utils.flushBarErrorMessage(
          'Error while fetching user favourite $e', context);
      // print('Error fetching user favorites: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'My Favourite List',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            children: const [
              Column(
                children: [
                  VerticalSpeacing(25.0),
                  FavouristListCart(
                      img: 'images/orio.png',
                      title: 'Oreo Biscut',
                      price: '\$10',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'images/sulpherfree.png',
                      title: 'Sulphuerfree Bura',
                      price: '\$5',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'images/cauliflower.png',
                      title: 'Cauliflower',
                      price: '\$13',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'images/tomato.png',
                      title: '2 Kg',
                      price: '\$26',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'images/girlGuide.png',
                      title: 'Girl Guide Biscuit',
                      price: '\$18',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'images/Arnotts.png',
                      title: "Arnott's",
                      price: '\$15',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'images/orio.png',
                      title: 'Oreo Biscut',
                      price: '\$10',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'images/cauliflower.png',
                      title: 'Cauliflower',
                      price: '\$13',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
