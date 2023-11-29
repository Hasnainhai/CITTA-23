// ignore_for_file: use_build_context_synchronously

import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../res/consts/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phNoController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    addressController.dispose();
    phNoController.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();
      try {
        await authInstance.createUserWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        final User? user = authInstance.currentUser;
        final uid = user!.uid;
        // user.updateDisplayName(nameController.text);
        // user.reload();
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id': uid,
          'name': nameController.text,
          'email': emailController.text.toLowerCase(),
          'phNo': phNoController.text.toLowerCase(),
          'shipping-address': addressController.text,
          'userWish': [],
          'userCart': [],
          'createdAt': Timestamp.now(),
        });
        Navigator.pushNamed(context, RoutesName.dashboardScreen);
        Utils.toastMessage('SuccessFully Register');
      } on FirebaseException catch (e) {
        Utils.flushBarErrorMessage('${e.message}', context);
        print('Error during Register');
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        Utils.flushBarErrorMessage('$e', context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 29, top: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpeacing(60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Welcome to our",
                            style: GoogleFonts.getFont(
                              "Gothic A1",
                              textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ),
                          Text(
                            "Vegan Life Style",
                            style: GoogleFonts.getFont(
                              "Gothic A1",
                              textStyle: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: GoogleFonts.getFont(
                                "Gothic A1",
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: AppColor.fontColor,
                                ),
                              ),
                            ),
                            const VerticalSpeacing(30),
                            // Name
                            TextFieldCustom(
                              controller: nameController,
                              maxLines: 1,
                              text: "Name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const VerticalSpeacing(30),
                            //Email
                            TextFieldCustom(
                              controller: emailController,
                              maxLines: 1,
                              text: "Email",
                              validator: (value) {
                                if (value!.isEmpty || !value.contains("@")) {
                                  return "Please enter a valid Email adress";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const VerticalSpeacing(30),
                            //phone number
                            TextFieldCustom(
                              controller: phNoController,
                              maxLines: 1,
                              text: "Ph No",
                              validator: (value) {
                                if (value!.isEmpty || value.length < 11) {
                                  return "Please enter a valid PhNo adress";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const VerticalSpeacing(30),
                            // Password
                            TextFieldCustom(
                              controller: passwordController,
                              maxLines: 1,
                              text: "Password",
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return "Please enter a valid password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const VerticalSpeacing(30),
                            // Address
                            TextFieldCustom(
                              controller: addressController,
                              maxLines: 1,
                              text: "Shipping address",
                              validator: (value) {
                                if (value!.isEmpty || value.length < 10) {
                                  return "Please enter a valid  address";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const VerticalSpeacing(30),
                            _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : RoundedButton(
                                    title: "Register",
                                    onpress: () {
                                      _submitFormOnRegister();
                                    }),
                            const VerticalSpeacing(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have account",
                                  style: GoogleFonts.getFont(
                                    "Gothic A1",
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.fontColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.loginscreen);
                                  },
                                  child: Text(
                                    "Log In",
                                    style: GoogleFonts.getFont(
                                      "Gothic A1",
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const VerticalSpeacing(30),
                          ],
                        ),
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
