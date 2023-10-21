import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import '../HomeScreen/DashBoard/tapBar.dart';

class CheckOutDoneScreen extends StatelessWidget {
  const CheckOutDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 100,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xffEEEEEE),
                ),
                child: Center(
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "images/done.png",
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const VerticalSpeacing(20),
              Text(
                "Order Placed Successfully ",
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.fontColor,
                  ),
                ),
              ),
              const VerticalSpeacing(14),
              Text(
                "Thanks for your order. Your order has placed successfully. Please continue your order.",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grayColor,
                  ),
                ),
              ),
              const VerticalSpeacing(
                80,
              ),
              RoundedButton(
                  title: "Continue",
                  onpress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const DashBoardScreen()),
                    );
                  }),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Track Order",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
