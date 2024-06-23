import 'package:citta_23/repository/menu_repository.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MenuCategorySection extends StatefulWidget {
  const MenuCategorySection({super.key, required this.category});
  final String category;

  @override
  State<MenuCategorySection> createState() => _MenuCategorySectionState();
}

class _MenuCategorySectionState extends State<MenuCategorySection> {
  String dPrice(String originalPriceString, String discountPercentageString) {
    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);
    double discountedPrice = originalPrice * (discountPercentage / 100);
    return discountedPrice.toStringAsFixed(0);
  }

  String calculateDiscountedPrice(
      String originalPriceString, String discountPercentageString) {
    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);
    double p = originalPrice * (discountPercentage / 100);
    double discountedPrice = originalPrice - p;
    return discountedPrice.toInt().toString();
  }

  void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          shape: const RoundedRectangleBorder(),
          icon: const Icon(
            Icons.no_accounts_outlined,
            size: 80,
            color: AppColor.primaryColor,
          ),
          title: const Text('You don\'t have any account, please'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.loginscreen);
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(),
                  side: const BorderSide(
                    color: AppColor.primaryColor,
                    width: 2.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.registerScreen);
                },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addToCart(
    String img,
    String title,
    String salePrice,
    String sellerId,
    String productId,
    String weight,
    String disPrice,
    String color,
    String size,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      showSignupDialog(context);
      return;
    }

    final userId = currentUser.uid;
    CollectionReference cartCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    QuerySnapshot cartSnapshot = await cartCollectionRef
        .where('imageUrl', isEqualTo: img)
        .limit(1)
        .get();

    if (cartSnapshot.docs.isNotEmpty) {
      Utils.toastMessage('Product is already in the cart');
    } else {
      var uuid = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(uuid)
          .set({
        'sellerId': sellerId,
        'id': productId,
        'imageUrl': img,
        'title': title,
        'salePrice': salePrice,
        'deleteId': uuid,
        'size': size,
        'weight': weight,
        'dPrice': disPrice,
        'color': color,
      });
      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuRepository>(
      builder: (context, menuRepository, child) {
        return Expanded(
          child: FutureBuilder<QuerySnapshot>(
            future: menuRepository.categoryReference.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var item = data[index];
                      var productData = item.data() as Map<String, dynamic>;

                      var product = {
                        'sellerId': productData['sellerId'],
                        'id': productData['id'],
                        'imageUrl': productData['imageUrl'],
                        'title': productData['title'],
                        'price': productData['price'],
                        'detail': productData['detail'],
                        'weight': productData['weight'],
                        'averageReview':
                            productData.containsKey('averageReview')
                                ? productData['averageReview']
                                : 0.0,
                        'category': productData['category'],
                        'discount': productData.containsKey('discount')
                            ? productData['discount']
                            : '0',
                        'size': productData.containsKey('size')
                            ? productData['size']
                            : ['N/A'],
                        'color': productData.containsKey('color')
                            ? productData['color']
                            : ['N/A'],
                      };

                      return HomeCard(
                        oofProd: item['category'] == 'Lightening Deals',
                        percentage: item['category'] == 'Lightening Deals'
                            ? item['discount']
                            : "0",
                        name: item['title'],
                        price: item['price'],
                        dPrice: item['category'] == 'Lightening Deals'
                            ? "${calculateDiscountedPrice(item['price'], item['discount'])}₹"
                            : item['price'] + '₹',
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.appBarButtonColor,
                        img: item['imageUrl'],
                        iconColor: AppColor.buttonBgColor,
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                // Handle size and color fields
                                List<String> sizes = product['size'] is List
                                    ? List<String>.from(product['size'])
                                    : ['N/A'];
                                List<String> colors = product['color'] is List
                                    ? List<String>.from(product['color'])
                                    : ['N/A'];

                                return sizes.isNotEmpty && sizes[0] != 'N/A'
                                    ? FashionDetail(
                                        title: product['title'].toString(),
                                        imageUrl: product['imageUrl'],
                                        salePrice: product['category'] ==
                                                "Lightening Deals"
                                            ? calculateDiscountedPrice(
                                                product['price'].toString(),
                                                product['discount'].toString())
                                            : product['price'].toString(),
                                        detail: product['detail'].toString(),
                                        sellerId:
                                            product['sellerId'].toString(),
                                        productId: product['id'].toString(),
                                        colors: colors,
                                        sizes: sizes,
                                        price: product['price'].toString(),
                                        disPrice: product['category'] ==
                                                "Lightening Deals"
                                            ? dPrice(product['discount'],
                                                product['price'])
                                            : "0",
                                      )
                                    : ProductDetailScreen(
                                        title: product['title'].toString(),
                                        productId: product['id'].toString(),
                                        sellerId:
                                            product['sellerId'].toString(),
                                        imageUrl: product['imageUrl'],
                                        price: product['price'].toString(),
                                        salePrice: product['category'] ==
                                                "Lightening Deals"
                                            ? calculateDiscountedPrice(
                                                product['price'].toString(),
                                                product['discount'].toString())
                                            : product['price'].toString(),
                                        weight: product.containsKey('weight') &&
                                                product['weight'] != null
                                            ? product['weight'].toString()
                                            : 'N/A',
                                        detail: product['detail'].toString(),
                                        disPrice: product['category'] ==
                                                "Lightening Deals"
                                            ? (int.parse(product['discount']) /
                                                    100 *
                                                    int.parse(product['price']))
                                                .toString()
                                            : '0',
                                      );
                              },
                            ),
                          );
                        },
                        addCart: () {
                          var product = item.data() as Map<String, dynamic>;

                          // Handle size and color fields
                          List<String> sizes = product['size'] is List
                              ? List<String>.from(product['size'])
                              : ['N/A'];
                          List<String> colors = product['color'] is List
                              ? List<String>.from(product['color'])
                              : ['N/A'];

                          addToCart(
                            product['imageUrl'],
                            product['title'],
                            product['price'],
                            product['sellerId'],
                            product['id'],
                            product.containsKey('weight') &&
                                    product['weight'] != null &&
                                    product['weight'].toString().isNotEmpty
                                ? product['weight'].toString()
                                : 'N/A',
                            product.containsKey('discount') &&
                                    product['discount'] != null &&
                                    product['discount'].isNotEmpty
                                ? dPrice(product['price'].toString(),
                                    product['discount'].toString())
                                : "0",
                            colors.isNotEmpty && colors[0] != 'N/A'
                                ? colors[0]
                                : 'N/A',
                            sizes.isNotEmpty && sizes[0] != 'N/A'
                                ? sizes[0]
                                : 'N/A',
                          );
                        },
                        productId: product['id'],
                        sellerId: product['sellerId'],
                        productRating: product['averageReview'],
                      );
                    },
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
