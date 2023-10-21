import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/Checkout/widgets/address_checkout_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import 'widgets/myCheckout.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool isChecked = false;

  onChanged(bool? value) {
    setState(() {
      isChecked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Checkout ',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back,
          color: AppColor.blackColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              const VerticalSpeacing(24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select delivery address',
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Add New',
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const AddressCheckOutWidget(
                  bgColor: AppColor.logoBgColor,
                  borderColor: AppColor.primaryColor,
                  titleColor: AppColor.primaryColor,
                  title: 'Home Address',
                  phNo: '(309) 071-9396-939',
                  address: '1749 Custom Road, Chhatak'),
              const VerticalSpeacing(20.0),
              const AddressCheckOutWidget(
                  bgColor: AppColor.whiteColor,
                  borderColor: AppColor.grayColor,
                  titleColor: AppColor.blackColor,
                  title: 'Office Address',
                  phNo: '(309)  071-9396-939',
                  address: '152 Nobab Road, Sylhet'),
            ],
          ),
        ),
      ),
    );
  }
}
