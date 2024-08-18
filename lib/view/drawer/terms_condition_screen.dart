import 'package:flutter/material.dart';
import '../../res/components/colors.dart';
import '../../res/components/widgets/verticalSpacing.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.primaryColor,
            )),
        title: const Text(
          "Term & Conditions",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.fontColor,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize:
              Size.fromHeight(1.0), // Set the height of the bottom border
          child: Divider(
            height: 1.0, // Set the height of the Divider line
            color: AppColor.primaryColor, // Set the color of the Divider line
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "General site usage last revised\nDecember 12-01-2020.?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(8),
                Text(
                  "Welcome to www.saydulmoon.info. Officia irure irure anim nisi exercitation velit cupidatat qui Lorem id ad. Amet quis occaecat quis voluptate cupidatat quis irure irure consequat irure.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(12),
                Text(
                  "1.Agreement",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(8),
                Text(
                  "Officia irure irure anim nisi exercitation velit cupidatat qui Lorem id ad. Amet quis occaecat quis voluptate cupidatat quis irure irure consequat irure.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(12),
                Text(
                  "2. Account",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(8),
                Text(
                  "Officia irure irure anim nisi exercitation velit cupidatat qui Lorem id ad. Amet quis occaecat quis voluptate cupidatat quis irure irure consequat irure..",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(12),
                Text(
                  "3. Relationship With Groceries",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(8),
                Text(
                  "Officia irure irure anim nisi exercitation velit cupidatat qui Lorem id ad. Amet quis occaecat quis voluptate cupidatat quis irure irure consequat irure.Officia irure irure anim nisi exercitation velit cupidatat qui Lorem id ad. Amet quis occaecat quis ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
