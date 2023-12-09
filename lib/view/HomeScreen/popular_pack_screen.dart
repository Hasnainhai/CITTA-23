import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:citta_23/view/HomeScreen/bundle_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../res/components/colors.dart';
import 'widgets/homeCard.dart';

class PopularPackScreen extends StatefulWidget {
  const PopularPackScreen({super.key});

  @override
  State<PopularPackScreen> createState() => _PopularPackScreenState();
}

bool isTrue = false;
bool _isLoading = false;
final List _popularPacks = [];
final _firestoreInstance = FirebaseFirestore.instance;

class _PopularPackScreenState extends State<PopularPackScreen> {
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
          _popularPacks.add({
            //for popular packs details screen
            'amount1': qn.docs[i]['product1']['amount'],
            'image1': qn.docs[i]['product1']['image'],
            'title1': qn.docs[i]['product1']['title'],
            'amount2': qn.docs[i]['product2']['amount'],
            'image2': qn.docs[i]['product2']['image'],
            'title2': qn.docs[i]['product2']['title'],
            'amount3': qn.docs[i]['product3']['amount'],
            'image3': qn.docs[i]['product3']['image'],
            'title3': qn.docs[i]['product3']['title'],
            'amount4': qn.docs[i]['product4']['amount'],
            'image4': qn.docs[i]['product4']['image'],
            'title4': qn.docs[i]['product4']['title'],
            'amount5': qn.docs[i]['product5']['amount'],
            'image5': qn.docs[i]['product5']['image'],
            'title5': qn.docs[i]['product5']['title'],
            'amount6': qn.docs[i]['product6']['amount'],
            'image6': qn.docs[i]['product6']['image'],
            'title6': qn.docs[i]['product6']['title'],
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
    fetchPopularPack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height / 7,
        child: LoadingManager(
          isLoading: _isLoading,
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
              child: Expanded(
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
                          Map<String, dynamic> product1 =
                              _popularPacks[index]['product1'] ?? {};
                          Map<String, dynamic> product2 =
                              _popularPacks[index]['product2'] ?? {};
                          Map<String, dynamic> product3 =
                              _popularPacks[index]['product3'] ?? {};
                          Map<String, dynamic> product4 =
                              _popularPacks[index]['product4'] ?? {};
                          Map<String, dynamic> product5 =
                              _popularPacks[index]['product5'] ?? {};
                          Map<String, dynamic> product6 =
                              _popularPacks[index]['product6'] ?? {};
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BundleProductScreen(
                              imageUrl: _popularPacks[index]['imageUrl'] ?? '',
                              title: _popularPacks[index]['title'] ?? '',
                              price: _popularPacks[index]['price'] ?? '',
                              saleprice:
                                  _popularPacks[index]['salePrice'] ?? '',
                              detail: _popularPacks[index]['detail'] ?? '',
                              weight: _popularPacks[index]['weight'] ?? '',
                              size: _popularPacks[index]['size'] ?? '',
                              img1: product1['image'] ?? '',
                              title1: product1['title'] ?? '',
                              amount1: product1['amount'] ?? '',
                              img2: product2['image'] ?? '',
                              title2: product2['title'] ?? '',
                              amount2: product2['amount'] ?? '',
                              img3: product3['image'] ?? '',
                              title3: product3['title'] ?? '',
                              amount3: product3['amount'] ?? '',
                              img4: product4['image'] ?? '',
                              title4: product4['title'] ?? '',
                              amount4: product4['amount'] ?? '',
                              img5: product5['image'] ?? '',
                              title5: product5['title'] ?? '',
                              amount5: product5['amount'] ?? '',
                              img6: product6['image'] ?? '',
                              title6: product6['title'] ?? '',
                              amount6: product6['amount'] ?? '',
                            );
                          }));
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
                      );
                    } else {
                      // Handle the case when the list is empty or index is out of range
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Shimmer(
                          duration: const Duration(seconds: 3), //Default value
                          interval: const Duration(
                              seconds: 5), //Default value: Duration(seconds: 0)
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
                      ); // or some default widget
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
