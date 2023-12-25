import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/card/widgets/cart_page_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../res/components/roundedButton.dart';
import 'widgets/dottedLineWidget.dart';
import 'widgets/emptyCartWidget.dart';
import 'widgets/item_prizing.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int totalItems = 0;
  Future<void> refreshCartItems() async {
    try {
      List<QueryDocumentSnapshot> cartItems = await getCartItems();
      setState(() {
        // Update the total items count with the new data
        totalItems = cartItems.length;
      });
    } catch (e) {
      print('Error refreshing cart items: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // refreshCartItems();

    getCartItems().then((cartItems) {
      setState(() {
        totalItems = cartItems.length;
      });
    });
  }

  // other stuff
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
      // Get the productId before deleting the item
      DocumentSnapshot snapshot = await documentReference.get();
      String productId = snapshot['id'];

      // Delete the item
      await documentReference.delete();

      // Show a message in the UI that the item is deleted
      Utils.toastMessage('Item Successfully Deleted');
    } catch (e) {
      // Show an error message if deletion fails
      Utils.flushBarErrorMessage('Error deleting product: $e', context);
    }
  }

  Future<void> refreshData() async {
    // Call your getCartItems function or any other logic to fetch updated data
    // ...

    // Example: Fetch cart items again
    await getCartItems();
    setState(() {
      // Update the state with the new data
      // ...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Cart Page',
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
      body: RefreshIndicator(
        onRefresh: refreshCartItems,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // cart widget stuff
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child: FutureBuilder(
                      future: getCartItems(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          return RefreshIndicator(
                            onRefresh: refreshData,
                            child: ListView.builder(
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                var item = cartItems[index].data()
                                    as Map<String, dynamic>;
                                var documentReference =
                                    cartItems[index].reference;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: CartWidget(
                                    sellerId: item['sellerId'],
                                    productId: item['id'],
                                    title: item[
                                        'title'], // You can customize this based on your data
                                    price: item['salePrice'],
                                    img: item['imageUrl'],
                                    onDelete: () {
                                      deleteCartItem(
                                          documentReference, context);
                                    },
                                    items: '',
                                    onIncrease: () {},
                                    onDecrease: () {},
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const VerticalSpeacing(30.0),
                  Text(
                    'Add Coupon',
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColor.fontColor,
                      ),
                    ),
                  ),
                  const VerticalSpeacing(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 46,
                        width: MediaQuery.of(context).size.width * 0.55,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColor.grayColor, width: 1.0),
                          borderRadius: BorderRadius.zero,
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter Voucher Code',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 46.0,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: RoundedButton(title: 'Apply', onpress: () {}),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(30.0),
                  ItemPrizingWidget(
                      title: 'Total Item', price: totalItems.toString()),
                  const VerticalSpeacing(12.0),
                  SizedBox(
                    height: 1, // Height of the dotted line
                    width: double.infinity, // Infinite width
                    child: CustomPaint(
                      painter: DottedLinePainter(),
                    ),
                  ),
                  const VerticalSpeacing(12.0),
                  const ItemPrizingWidget(title: 'Price', price: '\$60'),
                  const VerticalSpeacing(12.0),
                  SizedBox(
                    height: 1, // Height of the dotted line
                    width: double.infinity, // Infinite width
                    child: CustomPaint(
                      painter: DottedLinePainter(),
                    ),
                  ),
                  const VerticalSpeacing(12.0),
                  const ItemPrizingWidget(title: 'Total Price', price: '\$66'),
                  const VerticalSpeacing(30.0),
                  SizedBox(
                    height: 46.0,
                    width: double.infinity,
                    child: RoundedButton(
                        title: 'Checkout',
                        onpress: () {
                          Navigator.pushNamed(
                              context, RoutesName.checkOutScreen);
                        }),
                  ),
                  const VerticalSpeacing(30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class CartItemList extends StatefulWidget {
//   const CartItemList({super.key});

//   @override
//   State<CartItemList> createState() => _CartItemListState();
// }

// class _CartItemListState extends State<CartItemList> {
// // get items from userCart
//   Future<List<QueryDocumentSnapshot>> getCartItems() async {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     CollectionReference cartCollectionRef = FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('cart');

//     QuerySnapshot cartSnapshot = await cartCollectionRef.get();

//     return cartSnapshot.docs;
//   }

//   // delete items from userCart
//   Future<void> deleteCartItem(
//       DocumentReference documentReference, BuildContext context) async {
//     try {
//       // Get the productId before deleting the item
//       DocumentSnapshot snapshot = await documentReference.get();
//       String productId = snapshot['id'];

//       // Delete the item
//       await documentReference.delete();

//       // Show a message in the UI that the item is deleted
//       Utils.toastMessage('Item Successfully Deleted');

//       // Trigger a refresh in the UI (you can call a function to reload the data)
//       // For example, if you have a function called refreshData(), you can call it here.
//       // refreshData();
//     } catch (e) {
//       // Show an error message if deletion fails
//       Utils.flushBarErrorMessage('Error deleting product: $e', context);
//     }
//   }

//   Future<void> refreshData() async {
//     // Call your getCartItems function or any other logic to fetch updated data
//     // ...

//     // Example: Fetch cart items again
//     await getCartItems();
//     setState(() {
//       // Update the state with the new data
//       // ...
//     });
//   }

 


//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: getCartItems(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: SpinKitFadingFour(
//               color: AppColor.primaryColor,
//             ),
//           ); // Loading indicator while fetching data
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<QueryDocumentSnapshot> cartItems =
//               snapshot.data as List<QueryDocumentSnapshot>;
//           // Display a message when cart is Empty
//           if (cartItems.isEmpty) {
//             return const Center(
//               child: EmptyCart(),
//             );
//           }

//           // Build the UI using the cart items
//           return RefreshIndicator(
//             onRefresh: refreshData,
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 var item = cartItems[index].data() as Map<String, dynamic>;
//                 var documentReference = cartItems[index].reference;
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 5.0),
//                   child: CartWidget(
//                     sellerId: item['sellerId'],
//                     productId: item['id'],
//                     title: item[
//                         'title'], // You can customize this based on your data
//                     price: item['salePrice'],
//                     img: item['imageUrl'],
//                     onDelete: () {
//                       deleteCartItem(documentReference, context);
//                     },
//                     items: quantity.toString(),
//                     onIncrease: () {},
//                     onDecrease: () { },
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }
