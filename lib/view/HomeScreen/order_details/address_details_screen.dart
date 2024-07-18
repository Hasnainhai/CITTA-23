// ignore_for_file: use_build_context_synchronously
import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/widgets/myCheckout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  bool isLoading = false;
  void clearForm() {
    nameController.clear();
    lastNameController.clear();
    phoneController.clear();
    address1Controller.clear();
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
          'uuid': uuid,
          'name': nameController.text + lastNameController.text,
          'phone': phoneController.text,
          'address1': address1Controller.text,
          "address2": address1Controller.text,
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
        Fluttertoast.showToast(msg: "Address has been added");
        Navigator.pop(context);
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
    lastNameController.dispose();

    phoneController.dispose();
    address1Controller.dispose();
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
        title: const Text(
          "New Address",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.blackColor,
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
                              text: "First Name",
                              controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your first name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFieldCustom(
                              maxLines: 1,
                              text: "Last Name",
                              controller: lastNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your last name";
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
                            const Row(
                              children: [
                                MyCheckBox(),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Make Default Shipping Address",
                                  style: TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.blackColor,
                                  ),
                                ),
                              ],
                            ),
                            const VerticalSpeacing(20),
                            RoundedButton(
                                title: "Save Address",
                                onpress: () {
                                  addAddress();
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
