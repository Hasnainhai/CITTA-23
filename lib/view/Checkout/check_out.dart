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
                    MyCheckBox(),
                    // Checkbox(
                    //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //   focusColor: AppColor.primaryColor,
                    //   activeColor: AppColor.primaryColor,
                    //   checkColor: AppColor.whiteColor,
                    //   overlayColor:
                    //       MaterialStateProperty.all(AppColor.primaryColor),
                    //   value: isChecked,
                    //   onChanged: onChanged,
                    // ),
                    const SizedBox(width: 20.0),
                    Text(
                      'Home Address',
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
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

class MyCheckBox extends StatefulWidget {
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool isChecked = false;

  void onChanged() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          border: Border.all(
            color: isChecked ? AppColor.logoBgColor : AppColor.primaryColor,
          ),
        ),
        child: isChecked
            ? Center(
                child: Container(
                  width: 9.0,
                  height: 9.0,
                  color: isChecked ? AppColor.primaryColor : Colors.transparent,
                ),
              )
            : null,
      ),
    );
  }
}
