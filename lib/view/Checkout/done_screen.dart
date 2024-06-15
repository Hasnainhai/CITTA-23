import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/myOrder/my_order.dart';
import 'package:flutter/material.dart';
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
              const Text(
                "Order Placed Successfully ",
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.fontColor,
                ),
              ),
              const VerticalSpeacing(14),
              const Text(
                "Thanks for your order. Your order has placed successfully. Please continue your order.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grayColor,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const MyOrders(),
                    ),
                  );
                },
                child: const Text(
                  "Track Order",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.primaryColor,
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
