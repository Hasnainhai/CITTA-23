import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/deliveryAddress/widgets/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

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
          ),
        ),
        title: Text(
          "Delivery Address",
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.fontColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            const VerticalSpeacing(30.0),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              color: AppColor.whiteColor,
              child: const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    VerticalSpeacing(30.0),
                    address_widget(
                        title: 'Puraton Custom, Chhatak',
                        address: '216/c East Road',
                        phNo: '+8801710071000'),
                    Divider(),
                    VerticalSpeacing(20.0),
                    address_widget(
                        title: 'Thana Ghat Road, Chhatak',
                        address: '216/c East Road',
                        phNo: '+8801710071000'),
                    Divider(),
                    VerticalSpeacing(20.0),
                    address_widget(
                        title: 'Bus Stand, Chhatak',
                        address: '216/c East Road',
                        phNo: '+8801710071000'),
                    Divider(),
                    VerticalSpeacing(20.0),
                    address_widget(
                        title: 'Thana Ghat Road, Chhatak',
                        address: '216/c East Road',
                        phNo: '+8801710071000'),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
