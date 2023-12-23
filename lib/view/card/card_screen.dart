import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../res/components/roundedButton.dart';
import 'widgets/cartListWidget.dart';
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: const CartItemList(),
                ),
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
                        border:
                            Border.all(color: AppColor.grayColor, width: 1.0),
                        borderRadius: BorderRadius.zero,
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
                      child: RoundedButton(title: 'Apply', onpress: () {}),
                    ),
                  ],
                ),
                const VerticalSpeacing(30.0),
                const ItemPrizingWidget(title: 'Total Item', price: '6'),
                const VerticalSpeacing(12.0),
                SizedBox(
                  height: 1, // Height of the dotted line
                  width: double.infinity, // Infinite width
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                  ),
                ),
                const VerticalSpeacing(12.0),
                const ItemPrizingWidget(title: 'Price', price: '\$60'),
                const VerticalSpeacing(12.0),
                SizedBox(
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
                  child: RoundedButton(
                      title: 'Checkout',
                      onpress: () {
                        Navigator.pushNamed(context, RoutesName.checkOutScreen);
                      }),
                ),
                const VerticalSpeacing(30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
