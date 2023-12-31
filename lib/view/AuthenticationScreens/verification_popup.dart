import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';

class VerficationPopUp extends StatelessWidget {
  const VerficationPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VerticalSpeacing(MediaQuery.of(context).size.height / 16),
            const CircleAvatar(
              radius: 34,
              backgroundColor: AppColor.primaryColor,
              child: Icon(
                Icons.thumb_up,
                color: Colors.white,
              ),
            ),
            VerticalSpeacing(MediaQuery.of(context).size.height / 20),
            const Text(
              "Verified!!",
              style: TextStyle(
                fontFamily: 'CenturyGothic',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.fontColor,
              ),
            ),
            VerticalSpeacing(MediaQuery.of(context).size.height / 20),
            const Text(
              "Hurrah!!  You have successfully verified the account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'CenturyGothic',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.grayColor,
              ),
            ),
            VerticalSpeacing(MediaQuery.of(context).size.height / 20),
            RoundedButton(
                title: "Browse Home",
                onpress: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.dashboardScreen, (route) => false);
                }),
            VerticalSpeacing(MediaQuery.of(context).size.height / 20),
          ],
        ),
      ),
    );
  }
}
