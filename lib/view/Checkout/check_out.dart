import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';

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
            const VerticalSpeacing(15.0),
            Container(
              height: 92,
              width: MediaQuery.of(context).size.width,
              color: AppColor.logoBgColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        focusColor: AppColor.primaryColor,
                        activeColor: AppColor.primaryColor,
                        checkColor: AppColor.whiteColor,
                        overlayColor:
                            MaterialStateProperty.all(AppColor.primaryColor),
                        value: isChecked,
                        onChanged: onChanged,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
