import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/components/colors.dart';

class AllRelatedProd extends StatefulWidget {
  const AllRelatedProd({super.key});

  @override
  State<AllRelatedProd> createState() => _AllRelatedProdState();
}

class _AllRelatedProdState extends State<AllRelatedProd> {
  //get related products
  final List<Map<String, dynamic>> _relatedProducts = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  bool _isLoading = false;

  fetchRelatedProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn = await _firestoreInstance.collection('products').get();
      debugPrint(
          'Data fetched from Firestore ${qn.docs}'); // Debugging statement

      setState(() {
        _relatedProducts.clear();

        for (var doc in qn.docs) {
          var data = doc.data() as Map<String, dynamic>?;

          if (data != null) {
            var product = {
              'sellerId': data['sellerId'],
              'id': data['id'],
              'imageUrl': data['imageUrl'],
              'title': data['title'],
              'price': data['price'],
              'detail': data['detail'],
              'weight': data['weight'],
              'category': data['category'],
            };

            if (data.containsKey('discount') && data['discount'] != null) {
              product['discount'] = data['discount'].toString();
            }

            debugPrint('Fetched product: $product'); // Debugging statement

            _relatedProducts.add(product);
          }
        }
        _isLoading = false;

        debugPrint('All Products: $_relatedProducts'); // Debugging statement
      });
    } catch (e) {
      debugPrint('Error fetching products: $e'); // Debugging statement
      setState(() {
        _isLoading = false;
      });
    }
  }

  String calculateDiscountedPrice(
      String originalPriceString, String discountPercentageString) {
    // Convert strings to double
    debugPrint("this is the discount:$discountPercentageString");
    debugPrint("this is the total:$originalPriceString");

    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);

    // Calculate discounted price
    double p = originalPrice * (discountPercentage / 100);
    double discountedPrice = originalPrice - p;

    // Return the discounted price as a formatted string
    return discountedPrice.toStringAsFixed(
        0); // You can adjust the number of decimal places as needed
  }

  @override
  void initState() {
    fetchRelatedProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Related Products'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.west)),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _relatedProducts.length,
            itemBuilder: (context, index) {
              if (_relatedProducts.isEmpty) {
                return const Center(
                  child: Text('Empty related products'),
                );
              } else {
                final categoryRelatedProducts = _relatedProducts[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailScreen(
                            title: categoryRelatedProducts['title'].toString(),
                            productId: categoryRelatedProducts['id'].toString(),
                            sellerId:
                                categoryRelatedProducts['sellerId'].toString(),
                            imageUrl: categoryRelatedProducts['imageUrl'],
                            price: categoryRelatedProducts['price'].toString(),
                            salePrice: categoryRelatedProducts['category'] ==
                                    "Lightening Deals"
                                ? calculateDiscountedPrice(
                                    categoryRelatedProducts['price'],
                                    categoryRelatedProducts['discount'])
                                : categoryRelatedProducts['price'].toString(),
                            weight:
                                categoryRelatedProducts['weight'].toString(),
                            detail:
                                categoryRelatedProducts['detail'].toString(),
                            disPrice: categoryRelatedProducts['category'] ==
                                    "Lightening Deals"
                                ? (int.parse(categoryRelatedProducts[
                                            'discount']) /
                                        100 *
                                        int.parse(
                                            categoryRelatedProducts['price']))
                                    .toString()
                                : '0',
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 206,
                      color: const Color(0xffEEEEEE),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 63,
                            width: 84,
                            color: const Color(0xffC4C4C4),
                            child: Center(
                              child: Image.network(
                                categoryRelatedProducts['imageUrl'],
                                height: 50,
                                width: 60,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: '${categoryRelatedProducts['title']}\n',
                                style: const TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.fontColor,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '₹${categoryRelatedProducts['price']}',
                                    style: const TextStyle(
                                      fontFamily: 'CenturyGothic',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.buttonBgColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
