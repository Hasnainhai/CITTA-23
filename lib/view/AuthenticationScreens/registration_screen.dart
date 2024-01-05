// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/profile/editProfile/widgets/image_pickerWidget.dart';
import 'package:citta_23/view/profile/widgets/common_firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  File? image;

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
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
        String profileUrl =
            'https://nakedsecurity.sophos.com/wp-content/uploads/sites/2/2013/08/facebook-silhouette_thumb.jpg';
        if (image != null) {
          CommonFirebaseStorage commonStorage = CommonFirebaseStorage();

          profileUrl = await commonStorage.storeFileFileToFirebase(
              'profile/$uid', image!);
        }
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id': uid,
          'name': nameController.text,
          'email': emailController.text.toLowerCase(),
          'createdAt': Timestamp.now(),
          'profilePic': profileUrl,
        });
        Navigator.pushNamed(context, RoutesName.dashboardScreen);
        Utils.toastMessage('SuccessFully Register');
      } on FirebaseException catch (e) {
        Utils.flushBarErrorMessage('${e.message}', context);
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

  void pickImage() async {
    final pickedImage = await pickImageFromGallery(context);

    setState(() {
      image = pickedImage;
    });
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Welcome to our",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                          Text(
                            "Vegan Life Style",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    color: AppColor.grayColor.withOpacity(0.2),
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
                            const Text(
                              "Register",
                              style: TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 20,
                                color: AppColor.fontColor,
                              ),
                            ),
                            Center(
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: AppColor.primaryColor,
                                      foregroundImage: image == null
                                          ? null
                                          : FileImage(
                                              image!,
                                            ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                        height: 28,
                                        width: 28,
                                        color: Colors.white,
                                        child: const Icon(Icons.add)),
                                    onTap: () {
                                      pickImage();
                                    },
                                  ),
                                ],
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
                                const Text(
                                  "Already have account",
                                  style: TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.fontColor,
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
                                  child: const Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontFamily: 'CenturyGothic',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor,
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
