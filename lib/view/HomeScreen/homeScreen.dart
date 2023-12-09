// ignore_for_file: equal_keys_in_map

import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/bundle_product_screen.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../res/components/colors.dart';
import '../../res/components/widgets/verticalSpacing.dart';
import '../drawer/drawer.dart';
import 'widgets/homeCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List _products = [];

  final _firestoreInstance = FirebaseFirestore.instance;
  bool _isLoading = false;
  fetchProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      QuerySnapshot qn = await _firestoreInstance.collection('products').get();

      setState(() {
        _products.clear();
        for (int i = 0; i < qn.docs.length; i++) {
          _products.add({
            'imageUrl': qn.docs[i]['imageUrl'],
            'title': qn.docs[i]['title'],
            'price': qn.docs[i]['price'],
            'salePrice': qn.docs[i]['salePrice'],
            'detail': qn.docs[i]['detail'],
            'weight': qn.docs[i]['weight'],
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

  @override
  initState() {
    super.initState();
    fetchProducts();
    fetchPopularPack();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    bool isTrue = true;
    return LoadingManager(
      isLoading: _isLoading,
      child: Scaffold(
        drawer: const DrawerScreen(),
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40.0,
              width: 40.0,
              color: AppColor.appBarButtonColor,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.notes,
                    color: AppColor.menuColor,
                  ),
                ),
              ),
            ),
          ),
          // title: SizedBox(
          //   height: 40.0,
          //   width: 190.0,
          //   child: Center(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.location_on,
          //             color: AppColor.menuColor,
          //           ),
          //         ),
          //         Column(
          //           children: [
          //             Text.rich(
          //               TextSpan(
          //                 text: 'Current Location \n',
          //                 style: GoogleFonts.getFont(
          //                   "Gothic A1",
          //                   textStyle: const TextStyle(
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w400,
          //                     color: AppColor.fontColor,
          //                   ),
          //                 ),
          //                 children: const <TextSpan>[
          //                   TextSpan(
          //                     text: 'Chhatak,Syhlet',
          //                     style: TextStyle(
          //                       color: AppColor.grayColor,
          //                       fontWeight: FontWeight.w200,
          //                       fontSize: 12.0,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //         const Icon(
          //           Icons.expand_more,
          //           color: AppColor.buttonBgColor,
          //           size: 30,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40.0,
                width: 40.0,
                color: AppColor.appBarButtonColor,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.searchscreen,
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: AppColor.menuColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 180.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/bannerImg.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const VerticalSpeacing(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: Center(
                              child: Container(
                                height: 45.0,
                                width: MediaQuery.of(context).size.width * 0.4,
                                color: AppColor.buttonBgColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 33.0,
                                      width: 63.0,
                                      color: AppColor.categoryLightColor,
                                    ),
                                    Text(
                                      'Food',
                                      style: GoogleFonts.getFont(
                                        "Gothic A1",
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 25,
                            top: 0,
                            bottom: 5.0,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                'images/foodimg.png',
                                height: 59.0,
                                width: 59.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: Center(
                              child: Container(
                                height: 45.0,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: AppColor.buttonBgColor)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 33.0,
                                      width: 63.0,
                                      color: AppColor.categoryLightColor,
                                    ),
                                    Text(
                                      'Fashion',
                                      style: GoogleFonts.getFont(
                                        "Gothic A1",
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.buttonBgColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 0,
                            bottom: 12.0,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                'images/fashionimg.png',
                                height: 56.0,
                                width: 42.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Pack",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.popularpackscreen,
                          );
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.buttonBgColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(16.0),
                  // Popular packs here
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
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
                                          imageUrl:
                                              selectedPack['imageUrl'] ?? '',
                                          title: selectedPack['title'] ?? '',
                                          price: selectedPack['price'] ?? '',
                                          saleprice:
                                              selectedPack['salePrice'] ?? '',
                                          detail: selectedPack['detail'] ?? '',
                                          weight: selectedPack['weight'] ?? '',
                                          size: selectedPack['size'] ?? '',
                                          img1: selectedPack['product1']
                                                  ?['image'] ??
                                              '',
                                          title1: selectedPack['product1']
                                                  ?['title'] ??
                                              '',
                                          amount1: selectedPack['product1']
                                                  ?['amount'] ??
                                              '',
                                          img2: selectedPack['product2']
                                                  ?['image'] ??
                                              '',
                                          title2: selectedPack['product2']
                                                  ?['title'] ??
                                              '',
                                          amount2: selectedPack['product2']
                                                  ?['amount'] ??
                                              '',
                                          img3: selectedPack['product3']
                                                  ?['image'] ??
                                              '',
                                          title3: selectedPack['product3']
                                                  ?['title'] ??
                                              '',
                                          amount3: selectedPack['product3']
                                                  ?['amount'] ??
                                              '',
                                          img4: selectedPack['product4']
                                                  ?['image'] ??
                                              '',
                                          title4: selectedPack['product4']
                                                  ?['title'] ??
                                              '',
                                          amount4: selectedPack['product4']
                                                  ?['amount'] ??
                                              '',
                                          img5: selectedPack['product5']
                                                  ?['image'] ??
                                              '',
                                          title5: selectedPack['product5']
                                                  ?['title'] ??
                                              '',
                                          amount5: selectedPack['product5']
                                                  ?['amount'] ??
                                              '',
                                          img6: selectedPack['product6']
                                                  ?['image'] ??
                                              '',
                                          title6: selectedPack['product6']
                                                  ?['title'] ??
                                              '',
                                          amount6: selectedPack['product6']
                                                  ?['amount'] ??
                                              '',
                                        );
                                      } else {
                                        // Handle the case where _popularPacks is null or index is out of bounds
                                        // You can navigate to an error screen or display a message
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
                              dPrice:
                                  _popularPacks[index]['salePrice'].toString(),
                              borderColor: AppColor.buttonBgColor,
                              fillColor: AppColor.appBarButtonColor,
                              cartBorder: isTrue
                                  ? AppColor.appBarButtonColor
                                  : AppColor.buttonBgColor,
                              img: _popularPacks[index]['imageUrl'],
                              iconColor: AppColor.buttonBgColor,
                            );
                          } else {
                            // Handle the case when the list is empty or index is out of range
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Shimmer(
                                duration:
                                    const Duration(seconds: 3), //Default value
                                interval: const Duration(
                                    seconds:
                                        5), //Default value: Duration(seconds: 0)
                                color: AppColor.grayColor
                                    .withOpacity(0.2), //Default value
                                colorOpacity: 0.2, //Default value
                                enabled: true, //Default value
                                direction: const ShimmerDirection
                                    .fromLTRB(), //Default Value
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
                  ),

                  const VerticalSpeacing(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Our New Item",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.newitemsscreen,
                          );
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.buttonBgColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(16.0),
                  // Our New Items
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Expanded(
                      child: GridView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (_, index) {
                          // Check if _products is not empty and index is within valid range
                          if (_products.isNotEmpty &&
                              index < _products.length) {
                            return HomeCard(
                              ontap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProductDetailScreen(
                                      title:
                                          _products[index]['title'].toString(),
                                      imageUrl: _products[index]['imageUrl'],
                                      price:
                                          _products[index]['price'].toString(),
                                      salePrice: _products[index]['salePrice']
                                          .toString(),
                                      weight:
                                          _products[index]['weight'].toString(),
                                      detail: _products[index]['detail']
                                          .toString());
                                }));
                              },
                              name: _products[index]['title'].toString(),
                              price: _products[index]['price'].toString(),
                              dPrice: _products[index]['salePrice'].toString(),
                              borderColor: AppColor.buttonBgColor,
                              fillColor: AppColor.appBarButtonColor,
                              cartBorder: isTrue
                                  ? AppColor.appBarButtonColor
                                  : const Color.fromRGBO(203, 1, 102, 1),
                              img: _products[index]['imageUrl'],
                              iconColor: AppColor.buttonBgColor,
                            );
                          } else {
                            // Handle the case when the list is empty or index is out of range
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Shimmer(
                                duration:
                                    const Duration(seconds: 3), //Default value
                                interval: const Duration(
                                    seconds:
                                        5), //Default value: Duration(seconds: 0)
                                color: AppColor.grayColor
                                    .withOpacity(0.2), //Default value
                                colorOpacity: 0.2, //Default value
                                enabled: true, //Default value
                                direction: const ShimmerDirection
                                    .fromLTRB(), //Default Value
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
