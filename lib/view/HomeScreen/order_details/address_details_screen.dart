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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

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
            child: Form(
              key: _formKey,
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
                          TextFieldCustom(
                            maxLines: 1,
                            text: "Full Name",
                            controller: nameController,
                          ),
                          TextFieldCustom(
                            maxLines: 1,
                            text: "Phone Number",
                            controller: phoneController,
                          ),
                          TextFieldCustom(
                            maxLines: 1,
                            text: "Address Link 1",
                            controller: address1Controller,
                          ),
                          TextFieldCustom(
                            maxLines: 1,
                            text: "Address Link 2",
                            controller: address2Controller,
                          ),
                          TextFieldCustom(
                            maxLines: 1,
                            text: "City",
                            controller: cityController,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: TextFieldCustom(
                                  maxLines: 1,
                                  text: 'State',
                                  hintText: '',
                                  controller: stateController,
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: TextFieldCustom(
                                  maxLines: 2,
                                  text: 'Zip Code',
                                  hintText: '',
                                  controller: zipCodeController,
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
      ),
    );
  }
}
