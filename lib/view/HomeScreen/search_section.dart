import 'package:citta_23/models/search_model.dart';
import 'package:citta_23/repository/search_repository.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/consts/vars.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  var categoryType = CategoryType.fashion;
  // final List _products = [];
  final List _fashionProducts = [];
  final _firestoreInstance = FirebaseFirestore.instance;
  bool _isLoading = false;
  final List<Map<String, dynamic>> _newItems = [];
  final List<Map<String, dynamic>> _hotSelling = [];
  final List<Map<String, dynamic>> _lighteningDeals = [];

  bool isSearch = false;
  @override
  initState() {
    super.initState();
    fetchCategoryProducts();
    fetchPopularPack();
    fetchFashionProducts();
  }

  fetchCategoryProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn = await _firestoreInstance.collection('products').get();
      debugPrint('Data fetched from Firestore: ${qn.docs}');

      setState(() {
        _newItems.clear();
        _hotSelling.clear();
        _lighteningDeals.clear();

        for (var doc in qn.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          var product = {
            'sellerId': data['sellerId'],
            'id': data['id'],
            'imageUrl': data['imageUrl'],
            'title': data['title'],
            'price': data['price'],
            'detail': data['detail'],
            'weight': data['weight'],
            'category': data['category'],
            'averageReview': data['averageReview'] ?? 0.0, // Default to 0.0
          };

          debugPrint('Fetched product: $product');

          switch (product['category']) {
            case 'New Items':
              _newItems.add(product);
              break;
            case 'Hot Selling':
              _hotSelling.add(product);
              break;
            case 'Lightening Deals':
              product['discount'] =
                  data['discount'] ?? 'N/A'; // Default to 'N/A'
              _lighteningDeals.add(product);
              break;
          }
        }

        // Ensure at least one product is added to _newItems and _hotSelling if initially empty
        if (_newItems.isEmpty || _hotSelling.isEmpty) {
          for (var doc in qn.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            var product = {
              'sellerId': data['sellerId'],
              'id': data['id'],
              'imageUrl': data['imageUrl'],
              'title': data['title'],
              'price': data['price'],
              'detail': data['detail'],
              'weight': data['weight'],
              'category': data['category'],
              'averageReview': data['averageReview'] ?? 0.0,
            };
            if (product['category'] == 'New Items' &&
                !_newItems.contains(product)) {
              _newItems.add(product);
            } else if (product['category'] == 'Hot Selling' &&
                !_hotSelling.contains(product)) {
              _hotSelling.add(product);
            }
          }
        }

        _isLoading = false;

        debugPrint('New Items: $_newItems');
        debugPrint('Hot Selling: $_hotSelling');
        debugPrint('Lightening Deals: $_lighteningDeals');
      });
    } catch (e) {
      debugPrint('Error fetching products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  final List<Map<String, dynamic>> _popularPacks = [];
  fetchPopularPack() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn =
          await _firestoreInstance.collection('bundle pack').get();

      setState(() {
        _popularPacks.clear();
        for (var doc in qn.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Access individual products in the bundle
          Map<String, dynamic> product1 = data['product1'] ?? {};
          Map<String, dynamic> product2 = data['product2'] ?? {};
          Map<String, dynamic> product3 = data['product3'] ?? {};
          Map<String, dynamic> product4 = data['product4'] ?? {};
          Map<String, dynamic> product5 = data['product5'] ?? {};
          Map<String, dynamic> product6 = data['product6'] ?? {};

          _popularPacks.add({
            'product1': {
              'amount': product1['amount'] ?? '',
              'image': product1['image'] ?? '',
              'title': product1['title'] ?? '',
            },
            'product2': {
              'amount': product2['amount'] ?? '',
              'image': product2['image'] ?? '',
              'title': product2['title'] ?? '',
            },
            'product3': {
              'amount': product3['amount'] ?? '',
              'image': product3['image'] ?? '',
              'title': product3['title'] ?? '',
            },
            'product4': {
              'amount': product4['amount'] ?? '',
              'image': product4['image'] ?? '',
              'title': product4['title'] ?? '',
            },
            'product5': {
              'amount': product5['amount'] ?? '',
              'image': product5['image'] ?? '',
              'title': product5['title'] ?? '',
            },
            'product6': {
              'amount': product6['amount'] ?? '',
              'image': product6['image'] ?? '',
              'title': product6['title'] ?? '',
            },
            // simple card
            'sellerId': data['sellerId'],
            'id': data['id'],
            'imageUrl': data['imageUrl'],
            'title': data['title'],
            'price': data['price'],
            'salePrice': data['salePrice'] ?? '',
            'detail': data['detail'],
            'weight': data['weight'] ?? '',
            'size': data['size'],
            'averageReview': data['averageReview'] ?? 0.0,
          });
        }
      });

      return qn.docs;
    } catch (e) {
      // Log the error or handle it as necessary
      print('Error fetching popular packs: $e');
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  fetchFashionProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn = await _firestoreInstance.collection('fashion').get();

      setState(() {
        _fashionProducts.clear();
        for (var doc in qn.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          _fashionProducts.add({
            'sellerId': data['sellerId'],
            'id': data['id'],
            'imageUrl': data['imageUrl'],
            'title': data['title'],
            'price': data['price'],
            // 'salePrice': data['salePrice'] ?? '', // Uncomment if you need this field
            'detail': data['detail'],
            'color': data['color'],
            'size': data['size'],
            'averageReview': data['averageReview'] ?? 0.0,
          });
        }
      });

      return qn.docs;
    } catch (e) {
      // Log the error or handle it as necessary
      print('Error fetching fashion products: $e');
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void addToCart(
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
      // Product is not in the cart, add it
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
        'salePrice': dPrice,
        'deleteId': uuid,
        'weght': weight,
        "size": size,
        "color": color,
        "dPrice": dprice,
        // Add other product details as needed
      });
      Utils.toastMessage('Successfully added to cart');
    }
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.6,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 16,
        ),
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) {
          Product product = productProvider.products[index];
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

          String dPrice(
              String originalPriceString, String discountPercentageString) {
            // Convert strings to double
            debugPrint("this is the discount:$discountPercentageString");
            debugPrint("this is the total:$originalPriceString");

            double originalPrice = double.parse(originalPriceString);
            double discountPercentage = double.parse(discountPercentageString);

            // Calculate discounted price
            double discountedPrice = originalPrice * (discountPercentage / 100);

            // Return the discounted price as a formatted string
            return discountedPrice.toStringAsFixed(
                0); // You can adjust the number of decimal places as needed
          }

          return HomeCard(
            oofProd: product.discount != "N/A" ? true : false,
            percentage: product.discount,
            ontap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return product.isFashion
                    ? FashionDetail(
                        sellerId: product.sellerId,
                        productId: product.id,
                        title: product.title,
                        imageUrl: product.imageUrl,
                        salePrice: product.price,
                        detail: product.detail,
                        colors: product.colors,
                        sizes: product.sizes,
                      )
                    : ProductDetailScreen(
                        title: product.title,
                        productId: product.id,
                        sellerId: product.sellerId,
                        imageUrl: product.imageUrl,
                        price: product.price,
                        salePrice: product.discount != "N/A"
                            ? calculateDiscountedPrice(
                                product.price, product.discount)
                            : product.price,
                        weight: product.weight,
                        detail: product.detail,
                        disPrice: product.discountPrice,
                      );
              }));
            },
            sellerId: product.sellerId,
            productId: product.id,
            name: product.title,
            price: product.price,
            dPrice: product.discount != "N/A"
                ? calculateDiscountedPrice(product.price, product.discount)
                : product.price,
            borderColor: AppColor.buttonBgColor,
            fillColor: AppColor.appBarButtonColor,
            img: product.imageUrl,
            iconColor: AppColor.buttonBgColor,
            addCart: () {
              if (productProvider.products.isNotEmpty &&
                  index >= 0 &&
                  index < productProvider.products.length) {
                addToCart(
                  product.imageUrl,
                  product.title,
                  product.price,
                  product.id,
                  product.sellerId,
                  product.sizes.isNotEmpty ? product.sizes[0] : "N/A",
                  product.colors.isNotEmpty ? product.colors[0] : "N/A",
                  product.weight,
                  product.discount != 'N/A'
                      ? dPrice(product.price, product.discount)
                      : "0",
                );
              }
            },
            productRating: product.averageReview,
          );
        },
      ),
    );
  }
}
