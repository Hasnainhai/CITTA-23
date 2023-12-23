import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:citta_23/view/HomeScreen/bundle_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../res/components/colors.dart';
import 'widgets/homeCard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PopularPackScreen extends StatefulWidget {
  const PopularPackScreen({super.key});
  @override
  State<PopularPackScreen> createState() => _PopularPackScreenState();
}

bool isTrue = false;
bool _isLoading = false;
final _firestoreInstance = FirebaseFirestore.instance;

class _PopularPackScreenState extends State<PopularPackScreen> {
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
        for (int i = 0; i < qn.docs.length; i++) {
          // Access individual products in the bundle
          Map<String, dynamic> product1 = qn.docs[i]['product1'] ?? {};
          Map<String, dynamic> product2 = qn.docs[i]['product2'] ?? {};
          Map<String, dynamic> product3 = qn.docs[i]['product3'] ?? {};
          Map<String, dynamic> product4 = qn.docs[i]['product4'] ?? {};
          Map<String, dynamic> product5 = qn.docs[i]['product5'] ?? {};
          Map<String, dynamic> product6 = qn.docs[i]['product6'] ?? {};
          _popularPacks.add({
            //for popular packs details screen
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
            //simple card
            'imageUrl': qn.docs[i]['imageUrl'],
            'title': qn.docs[i]['title'],
            'price': qn.docs[i]['price'],
            'salePrice': qn.docs[i]['salePrice'],
            'detail': qn.docs[i]['detail'],
            'weight': qn.docs[i]['weight'],
            'size': qn.docs[i]['size'],
          });
        }
      });
      return qn.docs;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void addToCart(String img, String title, String dPrice) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
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
      await cartCollectionRef.add({
        'imageUrl': img,
        'title': title,
        'salePrice': dPrice,
        // Add other product details as needed
      });
      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  initState() {
    super.initState();
    fetchPopularPack();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: _isLoading,
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height / 7,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.createmyownpackscreen,
                  );
                },
                child: Container(
                  height: 52,
                  color: AppColor.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColor.buttonTxColor,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Create Own Pack",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColor.buttonTxColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
              color: AppColor.fontColor,
            ),
          ),
          title: Text(
            "Popular Pack",
            style: GoogleFonts.getFont(
              "Gothic A1",
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColor.fontColor,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  itemCount: _popularPacks.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5, // Horizontal spacing
                    mainAxisSpacing: 10, // Vertical spacing
                  ),
                  itemBuilder: (_, index) {
                    // Check if _products is not empty and index is within valid range
                    if (_popularPacks.isNotEmpty &&
                        index < _popularPacks.length) {
                      return HomeCard(
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                // Check if _popularPacks is not null and index is within bounds
                                if (_popularPacks.isNotEmpty &&
                                    index >= 0 &&
                                    index < _popularPacks.length) {
                                  Map<String, dynamic> selectedPack =
                                      _popularPacks[index];
                                  return BundleProductScreen(
                                    imageUrl: selectedPack['imageUrl'] ?? '',
                                    id: selectedPack['id'] ?? "",
                                    productId: selectedPack['sellerId'] ?? '',
                                    title: selectedPack['title'] ?? '',
                                    price: selectedPack['price'] ?? '',
                                    saleprice: selectedPack['salePrice'] ?? '',
                                    detail: selectedPack['detail'] ?? '',
                                    weight: selectedPack['weight'] ?? '',
                                    size: selectedPack['size'] ?? '',
                                    img1: selectedPack['product1']?['image'] ??
                                        '',
                                    title1: selectedPack['product1']
                                            ?['title'] ??
                                        '',
                                    amount1: selectedPack['product1']
                                            ?['amount'] ??
                                        '',
                                    img2: selectedPack['product2']?['image'] ??
                                        '',
                                    title2: selectedPack['product2']
                                            ?['title'] ??
                                        '',
                                    amount2: selectedPack['product2']
                                            ?['amount'] ??
                                        '',
                                    img3: selectedPack['product3']?['image'] ??
                                        '',
                                    title3: selectedPack['product3']
                                            ?['title'] ??
                                        '',
                                    amount3: selectedPack['product3']
                                            ?['amount'] ??
                                        '',
                                    img4: selectedPack['product4']?['image'] ??
                                        '',
                                    title4: selectedPack['product4']
                                            ?['title'] ??
                                        '',
                                    amount4: selectedPack['product4']
                                            ?['amount'] ??
                                        '',
                                    img5: selectedPack['product5']?['image'] ??
                                        '',
                                    title5: selectedPack['product5']
                                            ?['title'] ??
                                        '',
                                    amount5: selectedPack['product5']
                                            ?['amount'] ??
                                        '',
                                    img6: selectedPack['product6']?['image'] ??
                                        '',
                                    title6: selectedPack['product6']
                                            ?['title'] ??
                                        '',
                                    amount6: selectedPack['product6']
                                            ?['amount'] ??
                                        '',
                                  );
                                } else {
                                  Utils.flushBarErrorMessage(
                                      'error occure while fetching bundle products',
                                      context);
                                }
                                return Container();
                              },
                            ),
                          );
                        },
                        name: _popularPacks[index]['title'].toString(),
                        price: _popularPacks[index]['price'].toString(),
                        dPrice: _popularPacks[index]['salePrice'].toString(),
                        borderColor: AppColor.buttonBgColor,
                        fillColor: AppColor.appBarButtonColor,
                        cartBorder: isTrue
                            ? AppColor.appBarButtonColor
                            : AppColor.buttonBgColor,
                        img: _popularPacks[index]['imageUrl'],
                        iconColor: AppColor.buttonBgColor,
                        // add to cart logic
                        addCart: () {
                          if (_popularPacks.isNotEmpty &&
                              index >= 0 &&
                              index < _popularPacks.length) {
                            addToCart(
                              _popularPacks[index]['imageUrl'],
                              _popularPacks[index]['title'],
                              _popularPacks[index]['salePrice'],
                            );
                          }
                        },
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Shimmer(
                          duration: const Duration(seconds: 3),
                          interval: const Duration(seconds: 5),
                          color: AppColor.grayColor
                              .withOpacity(0.2), //Default value
                          colorOpacity: 0.2, //Default value
                          enabled: true, //Default value
                          direction:
                              const ShimmerDirection.fromLTRB(), //Default Value
                          child: Container(
                            height: 100,
                            width: 150,
                            color: AppColor.grayColor.withOpacity(0.2),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
