// ignore_for_file: use_build_context_synchronously
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/check_out.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  late Stream<List<Map<String, dynamic>?>> favoriteItemsStream;
  Stream<List<Map<String, dynamic>?>> getFavoriteItemsStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return _firestoreInstance
        .collection('favoriteList')
        .doc(uid)
        .collection('favorites')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => doc.data(),
              )
              .toList(),
        );
  }

  void removeFromFavorites(
    String img,
  ) async {
    try {
      // Get the user's UID
      String uid = FirebaseAuth
          .instance.currentUser!.uid; // You need to implement this function
      // Query the 'favoriteList' collection to find the document to delete
      QuerySnapshot querySnapshot = await _firestoreInstance
          .collection('favoriteList')
          .doc(uid)
          .collection('favorites')
          .where(
            'imageUrl',
            isEqualTo: img.toString(),
          )
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
    }
  }

  @override
  void initState() {
    super.initState();
    favoriteItemsStream = getFavoriteItemsStream();

    // Set _isLoading to false once the stream is loaded
    favoriteItemsStream.listen(
      (_) {
        setState(() {
          _isLoading = false;
        });
      },
      onError: (error) {
        Utils.flushBarErrorMessage('Error loading favorites: $error', context);
        setState(() {
          _isLoading = false;
        });
      },
    );
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
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.blackColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const DashBoardScreen(),
              ),
            );
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
            child: StreamBuilder<List<Map<String, dynamic>?>>(
              stream: favoriteItemsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Map<String, dynamic>?> favoriteItems =
                      snapshot.data ?? [];

                  if (favoriteItems.isEmpty) {
                    return const Center(
                      child: Text('Your favorite list is empty.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: favoriteItems.length,
                    itemBuilder: (context, index) {
                      var favorite = favoriteItems[index];
                      return FavouristListCart(
                        img: favorite!['imageUrl'],
                        title: favorite['title'],
                        price: favorite['salePrice'],
                        deleteIcon: Icons.delete_outline,
                        shoppingIcon: Icons.shopping_cart_outlined,
                        ontap: () {
                          removeFromFavorites(
                            favorite['imageUrl'],
                          );
                        },
                        ontap2: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => CheckOutScreen(
                                  tile: favorite['title'],
                                  price: favorite['salePrice'],
                                  img: favorite['imageUrl'],
                                  id: favorite['id'],
                                  customerId: favorite['sellerId'],
                                  weight: '1',
                                  salePrice: favorite['salePrice'],
                                  productType: "faviroute list"),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
