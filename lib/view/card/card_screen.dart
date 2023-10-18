import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/HomeScreen/widgets/increase_container.dart';
import 'package:citta_23/view/card/widgets/cart_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Cart Page',
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
          child: ListView(
        children: const[
          Column(
            children: [
              VerticalSpeacing(25.0),
              CartWidget(
                  title: 'Sulpherfree Bura',
                  subtitle: '570 ML',
                  price: '\$20',
                  img: 'images/sulpherfree.png'),
                    VerticalSpeacing(20.0),
                    CartWidget(
                  title: 'Cauliflower',
                  subtitle: '1 Kg',
                  price: '\$10',
                  img: 'images/cauliflower.png'),
                    VerticalSpeacing(20.0),
                    CartWidget(
                  title: 'Tomato',
                  subtitle: '1 Kg',
                  price: '\$12',
                  img: 'images/tomato.png'),
                    VerticalSpeacing(20.0),
                    CartWidget(
                  title: 'Girl Guide Biscuits',
                  subtitle: '200 Gm',
                  price: '\$11',
                  img: 'images/sulpherfree.png'),
                    VerticalSpeacing(20.0),
                    CartWidget(
                  title: 'Sulpherfree Bura',
                  subtitle: '570 ML',
                  price: '\$20',
                  img: 'images/sulpherfree.png'),
                    VerticalSpeacing(20.0),
                    CartWidget(
                  title: 'Cauliflower',
                  subtitle: '1 Kg',
                  price: '\$10',
                  img: 'images/cauliflower.png'),
                    VerticalSpeacing(20.0),
                    CartWidget(
                  title: 'Tomato',
                  subtitle: '1 Kg',
                  price: '\$12',
                  img: 'images/tomato.png'),
                    VerticalSpeacing(20.0),
                    CartWidget(
                  title: 'Girl Guide Biscuits',
                  subtitle: '200 Gm',
                  price: '\$11',
                  img: 'images/sulpherfree.png'),
            ],
          ),
        ],
      )),
    );
  }
}
