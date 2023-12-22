import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/Checkout/widgets/myCheckout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';

class AddressDetailSceen extends StatefulWidget {
  const AddressDetailSceen({super.key});

  @override
  State<AddressDetailSceen> createState() => _AddressDetailSceenState();
}

class _AddressDetailSceenState extends State<AddressDetailSceen> {
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
            )),
        title: Text(
          "New Address",
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const VerticalSpeacing(
                  20,
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        const TextFieldCustom(maxLines: 1, text: "Full Name"),
                        const TextFieldCustom(
                            maxLines: 1, text: "Phone Number"),
                        const TextFieldCustom(
                            maxLines: 1, text: "Address Link 1"),
                        const TextFieldCustom(
                            maxLines: 1, text: "Address Link 2"),
                        const TextFieldCustom(maxLines: 1, text: "City"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: const TextFieldCustom(
                                maxLines: 1,
                                text: 'State',
                                hintText: '',
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: const TextFieldCustom(
                                maxLines: 2,
                                text: 'Zip Code',
                                hintText: '',
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpeacing(20),
                        Row(
                          children: [
                            const MyCheckBox(),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Make Default Shipping Address",
                              style: GoogleFonts.getFont(
                                "Gothic A1",
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.fontColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpeacing(20),
                        RoundedButton(
                            title: "Save Address",
                            onpress: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.checkOutScreen,
                              );
                            }),
                        const VerticalSpeacing(40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
