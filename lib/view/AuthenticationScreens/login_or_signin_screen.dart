import 'package:flutter/material.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import '../../res/components/colors.dart';
import '../../res/components/roundedButton.dart';
import '../../routes/routes_name.dart';

class LoginOrSigninScreen extends StatelessWidget {
  const LoginOrSigninScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/log.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpeacing(80.0),
                    Text(
                      "Welcome to our",
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        color: AppColor.fontColor,
                      ),
                    ),
                    Text(
                      "Vegan Life Style",
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    RoundedButton(
                      title: "Continue with Email or Phone",
                      onpress: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RoutesName.loginOrSignup, (routes) => false);
                      },
                    ),
                    const VerticalSpeacing(20),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RoutesName.registerScreen, (routes) => false);
                      },
                      child: Container(
                        height: 56.0,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: AppColor.buttonTxColor,
                        ),
                        child: const Center(
                          child: Text(
                            "Create an account",
                            style: TextStyle(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const VerticalSpeacing(50),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
