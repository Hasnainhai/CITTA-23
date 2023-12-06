import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            'imageUrl': qn.docs[i]['imageUrl'],
            'title': qn.docs[i]['title'],
            'price': qn.docs[i]['price'],
            'salePrice': qn.docs[i]['salePrice'],
            'detail': qn.docs[i]['detail'],
            // 'weight': qn.docs[i]['weight'],
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemCount: _popularPacks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5, // Horizontal spacing
                mainAxisSpacing: 10, // Vertical spacing
              ),
              itemBuilder: (_, index) {
                // Check if _products is not empty and index is within valid range
                if (_popularPacks.isNotEmpty && index < _popularPacks.length) {
                  return HomeCard(
                    ontap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return ProductDetailScreen(
                      //       title: _products[index]['title'].toString(),
                      //       imageUrl: _products[index]['imageUrl'],
                      //       price: _products[index]['price'].toString(),
                      //       salePrice: _products[index]['salePrice'].toString(),
                      //       weight: _products[index]['weight'].toString(),
                      //       detail: _products[index]['detail'].toString());
                      // }));
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  ); // or some default widget
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
