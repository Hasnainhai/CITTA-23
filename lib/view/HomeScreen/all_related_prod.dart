import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';

class AllRelatedProd extends StatefulWidget {
  const AllRelatedProd({super.key});

  @override
  State<AllRelatedProd> createState() => _AllRelatedProdState();
}

class _AllRelatedProdState extends State<AllRelatedProd> {
  final List<Map<String, dynamic>> _relatedProducts = [];
  final _firestoreInstance = FirebaseFirestore.instance;
  bool _isLoading = false;

  fetchRelatedProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn = await _firestoreInstance.collection('products').get();
      debugPrint('Data fetched from Firestore ${qn.docs}');

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
              'discount': data.containsKey('discount')
                  ? data['discount'].toString()
                  : '0',
              'averageReview': data.containsKey('averageReview')
                  ? data['averageReview']
                  : 0.0,
              'color': data.containsKey('color') ? data['color'] : [],
              'size': data.containsKey('size') ? data['size'] : [],
            };

            debugPrint('Fetched product: $product');
            _relatedProducts.add(product);
          }
        }
        _isLoading = false;
        debugPrint('All Products: $_relatedProducts');
      });
    } catch (e) {
      debugPrint('Error fetching products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String calculateDiscountedPrice(
      String originalPriceString, String discountPercentageString) {
    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);

    double p = originalPrice * (discountPercentage / 100);
    double discountedPrice = originalPrice - p;

    return discountedPrice.toStringAsFixed(0);
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
          child: _relatedProducts.isEmpty
              ? const Center(child: Text('No Products...'))
              : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _relatedProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final product = _relatedProducts[index];
                      return HomeCard(
                        ontap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductDetailScreen(
                              sellerId: product['sellerId'],
                              productId: product['id'],
                              title: product['title'].toString(),
                              imageUrl: product['imageUrl'],
                              salePrice: product['price'],
                              detail: product['detail'].toString(),
                              price: product['price'],
                              weight: product['weight'],
                              disPrice: product['price'],
                            );
                          }));
                        },
                        sellerId: product['sellerId'],
                        productId: product['id'],
                        name: product['title'].toString(),
                        price: '',
                        dPrice: "${product['price']}₹",
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.appBarButtonColor,
                        img: product['imageUrl'],
                        iconColor: AppColor.buttonBgColor,
                        addCart: () {
                          // addToCart(
                          //   product['imageUrl'],
                          //   product['title'],
                          //   product['price'],
                          //   product['id'],
                          //   product['sellerId'],
                          //   product['size'].isNotEmpty
                          //       ? product['size'][0]
                          //       : 'N/A',
                          //   product['color'].isNotEmpty
                          //       ? product['color'][0]
                          //       : 'N/A',
                          //   "N/A",
                          //   '0',
                          // );
                        },
                        productRating: product['averageReview'],
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
