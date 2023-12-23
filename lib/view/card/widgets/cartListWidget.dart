import 'package:citta_23/view/card/widgets/emptyCartWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../res/components/colors.dart';
import '../../../utils/utils.dart';
import 'cart_page_widget.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({super.key});
// get items from userCart
  Future<List<QueryDocumentSnapshot>> getCartItems() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference cartCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    QuerySnapshot cartSnapshot = await cartCollectionRef.get();
    return cartSnapshot.docs;
  }

  // delete items from userCart
  Future<void> deleteCartItem(
      DocumentReference documentReference, BuildContext context) async {
    try {
      await documentReference.delete();
      Utils.toastMessage('Item Successfully Delete');
    } catch (e) {
      // ignore: use_build_context_synchronously
      Utils.flushBarErrorMessage('Error deleting product: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCartItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitFadingFour(
              color: AppColor.primaryColor,
            ),
          ); // Loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<QueryDocumentSnapshot> cartItems =
              snapshot.data as List<QueryDocumentSnapshot>;

          if (cartItems.isEmpty) {
            // Display a center text when there are no items in the cart
            return const Center(
              child: EmptyCart(),
            );
          }

          // Build the UI using the cart items
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              var item = cartItems[index].data() as Map<String, dynamic>;
              var documentReference = cartItems[index].reference;
              return Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: CartWidget(
                  title: item[
                      'title'], // You can customize this based on your data
                  price: item['salePrice'],
                  img: item['imageUrl'],
                  onDelete: () {
                    deleteCartItem(documentReference, context);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
