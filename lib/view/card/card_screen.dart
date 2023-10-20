import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/card/widgets/cart_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import 'widgets/dottedLineWidget.dart';
import 'widgets/item_prizing.dart';

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
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpeacing(25.0),
                  const CartWidget(
                      title: 'Sulpherfree Bura',
                      subtitle: '570 ML',
                      price: '\$20',
                      img: 'images/sulpherfree.png'),
                  const VerticalSpeacing(20.0),
                  const CartWidget(
                      title: 'Cauliflower',
                      subtitle: '1 Kg',
                      price: '\$10',
                      img: 'images/cauliflower.png'),
                  const VerticalSpeacing(20.0),
                  const CartWidget(
                      title: 'Tomato',
                      subtitle: '1 Kg',
                      price: '\$12',
                      img: 'images/tomato.png'),
                  const VerticalSpeacing(20.0),
                  const CartWidget(
                      title: 'Girl Guide Biscuits',
                      subtitle: '200 Gm',
                      price: '\$11',
                      img: 'images/sulpherfree.png'),
                  const VerticalSpeacing(30.0),
                  Text(
                    'Add Coupon',
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColor.fontColor,
                      ),
                    ),
                  ),
                  const VerticalSpeacing(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 46,
                        width: MediaQuery.of(context).size.width * 0.55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter Voucher Code',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 46.0,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor),
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              'Apply',
                              style: GoogleFonts.getFont(
                                "Gothic A1",
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(30.0),
                  const ItemPrizingWidget(title: 'Total Item', price: '6'),
                  const VerticalSpeacing(12.0),
                  const ItemPrizingWidget(title: 'Weight', price: '33 Kg'),
                  const VerticalSpeacing(12.0),
                  Container(
                    height: 1, // Height of the dotted line
                    width: double.infinity, // Infinite width
                    child: CustomPaint(
                      painter: DottedLinePainter(),
                    ),
                  ),
                  const VerticalSpeacing(12.0),
                  const ItemPrizingWidget(title: 'Price', price: '\$60'),
                  const VerticalSpeacing(12.0),
                  const ItemPrizingWidget(title: 'Discount', price: '\$6'),
                  const VerticalSpeacing(12.0),
                  Container(
                    height: 1, // Height of the dotted line
                    width: double.infinity, // Infinite width
                    child: CustomPaint(
                      painter: DottedLinePainter(),
                    ),
                  ),
                  const VerticalSpeacing(12.0),
                  const ItemPrizingWidget(title: 'Total Price', price: '\$66'),
                  const VerticalSpeacing(30.0),
                  SizedBox(
                    height: 46.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.checkOutScreen);
                      },
                      child: Center(
                        child: Text(
                          'Checkout',
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpeacing(30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
