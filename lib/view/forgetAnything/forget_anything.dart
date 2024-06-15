import 'package:citta_23/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';
import '../Checkout/widgets/card_checkout_screen.dart';

class ForgetAnything extends StatefulWidget {
  const ForgetAnything({
    super.key,
    required this.subTotal,
    required this.productList,
  });

  final String subTotal;
  final List<Map<String, dynamic>> productList;

  @override
  _ForgetAnythingState createState() => _ForgetAnythingState();
}

class _ForgetAnythingState extends State<ForgetAnything> {
  String _currentSubTotal = '';

  @override
  void initState() {
    super.initState();
    _currentSubTotal = widget.subTotal;
  }

  Future<List<Map<String, dynamic>>> fetchRelatedProducts(
      BuildContext context) async {
    List<Map<String, dynamic>> relatedProducts = [];

    try {
      QuerySnapshot fashionSnapshot =
          await FirebaseFirestore.instance.collection('fashion').get();
      QuerySnapshot productsSnapshot =
          await FirebaseFirestore.instance.collection('products').get();

      for (var doc in fashionSnapshot.docs) {
        relatedProducts.add(doc.data() as Map<String, dynamic>);
      }
      for (var doc in productsSnapshot.docs) {
        relatedProducts.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Utils.flushBarErrorMessage(
          'Error fetching related products: $e', context);
    }

    return relatedProducts;
  }

  Future<void> addToCart(
      String img,
      String title,
      String dPrice,
      String sellerId,
      String productId,
      String size,
      String color,
      String weight,
      String dprice) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Utils.toastMessage('Please SignUp first');
      return;
    }

    final userId = currentUser.uid;
    // Get the collection reference for the user's cart
    CollectionReference cartCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    // Check if the product is already in the cart
    QuerySnapshot cartSnapshot = await cartCollectionRef
        .where('imageUrl', isEqualTo: img)
        .limit(1)
        .get();

    if (cartSnapshot.docs.isNotEmpty) {
      // Product is already in the cart, show a popup message
      Utils.toastMessage('Product is already in the cart');
    } else {
      var uuid = const Uuid().v1();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(uuid)
          .set({
        'sellerId': sellerId,
        'id': productId,
        'imageUrl': img,
        'title': title,
        'salePrice': dPrice,
        'deleteId': uuid,
        'weight': weight,
        'size': size,
        'color': color,
        'dPrice': dprice,
      });

      setState(() {
        // Update subtotal after adding to cart
        _currentSubTotal =
            (double.parse(_currentSubTotal) + double.parse(dPrice))
                .toStringAsFixed(2);
      });

      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(125),
        child: AppBar(
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
            ),
          ),
          title: const Text(
            "Forget Anything?",
            style: TextStyle(
              fontFamily: 'CenturyGothic',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
          flexibleSpace: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "You haven't finished checking out yet.\nDon't miss out anything?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColor.fontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalSpeacing(16),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchRelatedProducts(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching related products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No related products found'));
          }

          final relatedProducts = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
            itemCount: relatedProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 4 / 4,
            ),
            itemBuilder: (context, index) {
              final product = relatedProducts[index];
              return HomeCard(
                name: product['title'],
                price: '\$${product['price']}',
                dPrice: '00', // Adjust as needed
                borderColor: AppColor.primaryColor,
                fillColor: AppColor.bgColor,
                img: product['imageUrl'],
                iconColor: AppColor.primaryColor,
                ontap: () {},
                addCart: () {
                  addToCart(
                    product['imageUrl'],
                    product['title'],
                    product['price'],
                    product['sellerId'],
                    product['id'],
                    'N/A', //  actual size logic
                    'N/A', //  actual color logic
                    'N/A',
                    '00', //  needed
                  );
                },
                productId: product['id'],
                sellerId: product['sellerId'],
                productRating: product.containsKey('averageReview')
                    ? product['averageReview']
                    : 0.0,
              );
            },
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 30.0),
            Expanded(
              child: Container(
                height: double.infinity,
                color: const Color(0xffF7F7F7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor,
                      ),
                    ),
                    Text(
                      _currentSubTotal,
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.grayColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) {
                      return CardCheckOutScreen(
                        productType: 'cart',
                        productList: widget.productList,
                        subTotal: _currentSubTotal,
                      );
                    }),
                  );
                },
                child: Container(
                  height: double.infinity,
                  color: AppColor.primaryColor,
                  child: const Center(
                    child: Text(
                      'Continue to checkout',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
