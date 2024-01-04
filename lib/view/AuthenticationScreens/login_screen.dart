// ignore_for_file: use_build_context_synchronously
import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/authButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../res/consts/firebase_const.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.signInWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        Utils.toastMessage('SuccessFully Login');
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.dashboardScreen, (route) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const VerticalSpeacing(40.0),
                  Container(
                    height: 80.0,
                    width: 215.0,
                    color: AppColor.logoBgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  const VerticalSpeacing(50.0),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Welcome to our \n',
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w300,
                            color: AppColor.fontColor,
                          ),
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Vegan Life Style',
                            style: TextStyle(
                                color: AppColor.buttonBgColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 30.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpeacing(80.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldCustom(
                          controller: emailController,
                          maxLines: 1,
                          text: 'Email Address',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains("@")) {
                              return "Please enter a valid Email adress";
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextFieldCustom(
                          controller: passwordController,
                          maxLines: 1,
                          text: 'Your Password',
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "Please enter a valid password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.restscreen,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password?",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpeacing(30),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RoundedButton(
                          title: "Login",
                          onpress: () {
                            _submitFormOnLogin();
                          }),
                  const VerticalSpeacing(30.0),
                  const AuthButton(),
                  const VerticalSpeacing(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t Have Account?",
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
                              context, RoutesName.registerScreen);
                        },
                        child: Text(
                          "Sign up",
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
                  const VerticalSpeacing(90.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
