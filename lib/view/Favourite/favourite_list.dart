// ignore_for_file: use_build_context_synchronously
import 'package:citta_23/res/components/loading_manager.dart';
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
  bool _isLoading = true;
  final _firestoreInstance = FirebaseFirestore.instance;
  //fetch user favourite data
  Future<List<Map<String, dynamic>?>> getUserFavorites() async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth.instance.currentUser!.uid;
      print('UID: $uid');
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

  List<Map<String, dynamic>> favoritesList = [];
  //fetch user favourite
  Future<void> fetchUserFavorites() async {
    try {
      List<Map<String, dynamic>?> userFavorites = await getUserFavorites();
      userFavorites.removeWhere((favorite) => favorite == null);

      setState(() {
        favoritesList = userFavorites.map((favorite) => favorite!).toList();
        _isLoading = false; // Set isLoading to false after data is loaded
      });
    } catch (e) {
      Utils.flushBarErrorMessage(
          'Error while fetching user favourite $e', context);
      setState(() {
        _isLoading = false; // Set isLoading to false in case of an error
      });
    }
  }

  void removeFromFavorites() async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth
          .instance.currentUser!.uid; // You need to implement this function

      // Query the 'favoriteList' collection to find the document to delete
      QuerySnapshot querySnapshot = await _firestoreInstance
          .collection('favoriteList')
          .doc(uid)
          .collection('favorites')
          .where('title')
          .get();

      // Delete the document
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await _firestoreInstance
            .collection('favoriteList')
            .doc(uid)
            .collection('favorites')
            .doc(doc.id)
            .delete();
      }

      // Display a success message or perform any other action
      Utils.toastMessage('SuccessFully removed from favourite');
    } catch (e) {
      // Handle errors
      Utils.flushBarErrorMessage('Error removing from favorites: $e', context);
      // print('Error removing from favorites: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserFavorites();
    fetchUserFavorites();
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(
              children: favoritesList.map((favorite) {
                return FavouristListCart(
                  img: favorite['imageUrl'],
                  title: favorite['title'],
                  price: favorite['salePrice'],
                  deleteIcon: Icons.delete_outline,
                  shoppingIcon: Icons.shopping_cart_outlined,
                  ontap: () {
                    removeFromFavorites();
                  },
                  ontap2: () {},
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
