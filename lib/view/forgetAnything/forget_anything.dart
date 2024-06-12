import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';

import '../../res/components/colors.dart';

class ForgetAnything extends StatelessWidget {
  const ForgetAnything({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(165),
        child: AppBar(
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
            ),
          ),
          title: const Text(
            "Forget Anything?",
            style: TextStyle(
              fontFamily: 'CenturyGothic',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
          flexibleSpace: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VerticalSpeacing(16),
                Text(
                  "You haven't finished checking out yet.\nDon't miss out anything?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColor.fontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 30.0),
            Expanded(
              child: Container(
                height: double.infinity,
                color: const Color(0xffF7F7F7),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor,
                      ),
                    ),
                    Text(
                      '400',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.grayColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                color: AppColor.primaryColor,
                child: const Center(
                  child: Text(
                    'Continue to checkout',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
