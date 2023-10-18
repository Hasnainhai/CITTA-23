import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import 'widgets/favourite_list_cart.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'My Favourite List',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            children: const [
              Column(
                children: [
                  VerticalSpeacing(25.0),
                  FavouristListCart(
                      img: 'orio.png',
                      title: 'Oreo Biscut',
                      subTitle: '570 ML',
                      price: '\$10',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'sulpherfree.png',
                      title: 'Sulphuerfree Bura',
                      subTitle: '170 ML',
                      price: '\$5',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'cauliflower.png',
                      title: 'Cauliflower',
                      subTitle: '1 Kg',
                      price: '\$13',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'tomato.png',
                      title: '2 Kg',
                      subTitle: '570 ML',
                      price: '\$26',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'girlGuide.png',
                      title: 'Girl Guide Biscuit',
                      subTitle: '200 Gm',
                      price: '\$18',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'Arnotts.png',
                      title: "Arnott's",
                      subTitle: '700 Gm',
                      price: '\$15',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'orio.png',
                      title: 'Oreo Biscut',
                      subTitle: '570 ML',
                      price: '\$10',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                  FavouristListCart(
                      img: 'cauliflower.png',
                      title: 'Cauliflower',
                      subTitle: '1 Kg',
                      price: '\$13',
                      deleteIcon: Icons.delete_outline,
                      shoppingIcon: Icons.shopping_cart_outlined),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
