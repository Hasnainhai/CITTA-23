import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
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
              // AddressCheckOutWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressCheckOutWidget extends StatelessWidget {
  const AddressCheckOutWidget({
    super.key, required this.bgColor, required this.borderColor, required this.titleColor, required this.title, required this.phNo, required this.address,
  });
  final Color bgColor;
  final Color borderColor;
  final Color titleColor;
  final String title;
  final String phNo;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColor.logoBgColor,
          border: Border.all(width: 2, color: AppColor.primaryColor)),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCheckBox(),
            const SizedBox(width: 15.0),
            Text.rich(
              TextSpan(
                text: 'Home Address\n ',
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: '(309) 071-9396-939\n',
                    style: TextStyle(
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  TextSpan(
                    text: '1749 Custom Road, Chhatak',
                    style: TextStyle(
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
