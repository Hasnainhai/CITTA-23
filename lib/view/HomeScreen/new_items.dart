import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/routes_name.dart';
import 'DashBoard/tapBar.dart';
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

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection('products').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          'imageUrl': qn.docs[i]['imageUrl'],
          'title': qn.docs[i]['title'],
          'price': qn.docs[i]['price'],
          'salePrice': qn.docs[i]['salePrice'],
        });
      }
    });
    return qn.docs;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const VerticalSpeacing(16),
              Expanded(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: false,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10, // Horizontal spacing
                    mainAxisSpacing: 10, // Vertical spacing
                  ),
                  itemBuilder: (_, index) {
                    // Check if _products is not empty and index is within valid range
                    if (_products.isNotEmpty && index < _products.length) {
                      return HomeCard(
                        ontap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.productdetailscreen,
                          );
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
                      // Handle the case when the list is empty or index is out of range
                      return const Center(
                        child: CircularProgressIndicator(),
                      ); // or some default widget
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
