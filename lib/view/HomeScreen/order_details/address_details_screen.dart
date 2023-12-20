// ignore_for_file: use_build_context_synchronously

import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/widgets/myCheckout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

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
  bool isLoading = false;
  void clearForm() {
    nameController.clear();

    phoneController.clear();
    address1Controller.clear();
    address2Controller.clear();
    cityController.clear();
    stateController.clear();
    zipCodeController.clear();
  }

  void addAddress() async {
    final isValid = _formKey.currentState!.validate();

    final uuid = const Uuid().v1();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });
        Map<String, dynamic> addressMap = {
          'id': userId,
          'name': phoneController.text,
          'phone': phoneController.text,
          'address1': address1Controller.text,
          "address2": address2Controller.text,
          'city': cityController.text,
          'state': stateController.text,
          'zipcode': zipCodeController.text,
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("my_Address")
            .doc(uuid)
            .set(addressMap);
        clearForm();
        Utils.flushBarErrorMessage('Address has been added', context);
      } on FirebaseException catch (e) {
        Utils.flushBarErrorMessage('${e.message}', context);
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        Utils.flushBarErrorMessage('$error', context);

        setState(() {
          isLoading = false;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
      body: LoadingManager(
        isLoading: isLoading,
        child: SafeArea(
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFieldCustom(
                              maxLines: 1,
                              text: "Phone Number",
                              controller: phoneController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your Phone Number";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFieldCustom(
                              maxLines: 1,
                              text: "Address Link 1",
                              controller: address1Controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your Address";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFieldCustom(
                              maxLines: 1,
                              text: "Address Link 2",
                              controller: address2Controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your Address";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFieldCustom(
                              maxLines: 1,
                              text: "City",
                              controller: cityController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your City name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 120,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    text: 'State',
                                    hintText: '',
                                    controller: stateController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your State name";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: TextFieldCustom(
                                    maxLines: 2,
                                    text: 'Zip Code',
                                    hintText: '',
                                    controller: zipCodeController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your Zipe Code";
                                      } else {
                                        return null;
                                      }
                                    },
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
                                  addAddress();
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
      ),
    );
  }
}
