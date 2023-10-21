import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';
import '../../../res/components/widgets/toggle_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          "Notification",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      const VerticalSpeacing(30),
                      const ToggleWidget(
                        title: "App Notification",
                      ),
                      const Divider(),
                      const VerticalSpeacing(20),
                      const ToggleWidget(
                        title: "Phone Number Notification",
                      ),
                      const Divider(),
                      const VerticalSpeacing(20),
                      const ToggleWidget(
                        title: "Offer Notification",
                      ),
                      const Divider(),
                      VerticalSpeacing(MediaQuery.of(context).size.height / 2),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
