import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/toggle_widget.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key, required this.img});
  final String img;
  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
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
        title: const Text(
          "Track Order",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                color: const Color(0xffFFFFFF),
                surfaceTintColor: const Color(0xffFFFFFF),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      const VerticalSpeacing(30),
                      const ToggleWidget(
                        title: "App Notification",
                      ),
                      const Divider(),
                      const VerticalSpeacing(20),
                      const ToggleWidget(
                        title: "Phone Number Notification",
                      ),
                      const Divider(),
                      const VerticalSpeacing(20),
                      const ToggleWidget(
                        title: "Offer Notification",
                      ),
                      const Divider(),
                      VerticalSpeacing(MediaQuery.of(context).size.height / 2),
                    ],
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
