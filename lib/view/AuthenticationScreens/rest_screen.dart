// ignore_for_file: use_build_context_synchronously

import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/components/colors.dart';
import '../../res/components/custom_field.dart';
import '../../res/components/roundedButton.dart';
import '../../res/consts/firebase_const.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({super.key});
  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if (emailController.text.isEmpty || !emailController.text.contains("@")) {
      Utils.snackBar("Please enter a correct email address", context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: emailController.text.toLowerCase());
        Utils.snackBar("An email has been sent to your email address", context);

        Navigator.pushNamed(context, RoutesName.loginscreen);
      } on FirebaseException catch (error) {
        Utils.flushBarErrorMessage('${error.message}', context);

        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        Utils.flushBarErrorMessage('$error', context);
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
    return LoadingManager(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xffEEEEEE),
        appBar: AppBar(
          backgroundColor: const Color(0xffFFFFFF),
          title: const Text(
            "Forget Password",
            style: TextStyle(
              fontFamily: 'CenturyGothic',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.fontColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: const Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpeacing(24),
                          const Text(
                            "Reset Your Password",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                          const VerticalSpeacing(24),
                          const Text(
                            "Please enter your email. We will send a link to your email to reset your password.",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff8B8B97),
                            ),
                          ),
                          const VerticalSpeacing(30),
                          TextFieldCustom(
                            controller: emailController,
                            maxLines: 1,
                            text: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const VerticalSpeacing(80),
                          RoundedButton(
                              title: "Send Me Link",
                              onpress: () {
                                _forgetPassFCT();
                              }),
                          const VerticalSpeacing(
                            200,
                          ),
                          // const VerticalSpeacing(300),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
