import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'DashBoard/tapBar.dart';
import 'product_detail_screen.dart';
import 'widgets/homeCard.dart';

class NewItemsScreen extends StatefulWidget {
  const NewItemsScreen({super.key});

  @override
  State<NewItemsScreen> createState() => _NewItemsScreenState();
}

class _NewItemsScreenState extends State<NewItemsScreen> {
  bool isTrue = true;
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

  @override
  initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "New Item",
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
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, index) {
                // Check if _products is not empty and index is within valid range
                if (_products.isNotEmpty && index < _products.length) {
                  return HomeCard(
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(
                            title: _products[index]['title'].toString(),
                            imageUrl: _products[index]['imageUrl'],
                            price: _products[index]['price'].toString(),
                            salePrice: _products[index]['salePrice'].toString(),
                            weight: _products[index]['weight'].toString(),
                            detail: _products[index]['detail'].toString());
                      }));
                    },
                    name: _products[index]['title'].toString(),
                    price: _products[index]['price'].toString(),
                    dPrice: _products[index]['salePrice'].toString(),
                    borderColor: AppColor.buttonBgColor,
                    fillColor: AppColor.appBarButtonColor,
                    cartBorder: isTrue
                        ? AppColor.appBarButtonColor
                        : AppColor.buttonBgColor,
                    img: _products[index]['imageUrl'],
                    iconColor: AppColor.buttonBgColor,
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Shimmer(
                      duration: const Duration(seconds: 3), //Default value
                      interval: const Duration(
                          seconds: 5), //Default value: Duration(seconds: 0)
                      color:
                          AppColor.grayColor.withOpacity(0.2), //Default value
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
      ),
    );
  }
}
