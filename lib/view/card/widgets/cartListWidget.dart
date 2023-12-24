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

  final int newQuantity = 1;

  Future<void> updateQuantityAndPrice(
      DocumentReference documentReference, int newQuantity) async {
    try {
      DocumentSnapshot documentSnapshot = await documentReference.get();
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('salePrice')) {
        // Convert 'salePrice' to int
        int currentSalePrice = int.tryParse(data['salePrice'].toString()) ?? 0;

        // Perform the update
        await documentReference.update({
          'salePrice': newQuantity * currentSalePrice,
        });
      } else {
        print('Error: Document data is missing or salePrice is not available.');
      }
    } catch (e) {
      print('Error updating quantity and price: $e');
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
          // Display a message when cart is Empty
          if (cartItems.isEmpty) {
            return const Center(
              child: EmptyCart(),
            );
          }

          // Build the UI using the cart items
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              int quantity = newQuantity;
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
                  items: quantity.toString(),
                  onIncrease: () {
                    updateQuantityAndPrice(documentReference, quantity + 1);
                  },
                  onDecrease: () {
                    if (quantity > 1) {
                      updateQuantityAndPrice(documentReference, quantity - 1);
                    }
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
