import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.fontColor,
            )),
        title: Text(
          "Product Details",
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
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 26,
          ),
          child: Column(
            children: [
              Container(
                height: 320,
                width: 400,
                decoration: const BoxDecoration(
                  color: Color(0xffEEEEEE),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                  ),
                  child: Column(
                    children: [
                      const VerticalSpeacing(10),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                like = !like; // Toggle the value of like
                              });
                            },
                            child: Container(
                              height: 48,
                              width: 48,
                              color: Colors.white,
                              child: like
                                  ? const Icon(
                                      Icons.favorite,
                                      color: AppColor.primaryColor,
                                    )
                                  : const Icon(Icons.favorite_border_rounded),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        child: Image.asset(
                          "images/purepng.png",
                          height: 200,
                        ),
                      )
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
}
