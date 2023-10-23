import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/drawer/widget/top_questions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
              color: AppColor.fontColor,
            )),
        title: Text(
          "Help Center",
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
            top: 20,
            bottom: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi! How can we help?",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(24),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Search Here",
                      helperStyle: TextStyle(color: AppColor.grayColor),
                      filled: true,
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                const VerticalSpeacing(24),
                Text(
                  "Top Questions",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(14),
                const TopQuestion(question: "How do I return my items?"),
                const VerticalSpeacing(14),
                const TopQuestion(question: "How to use collection point?"),
                const VerticalSpeacing(14),
                const TopQuestion(question: "What is Grocery?"),
                const VerticalSpeacing(14),
                const TopQuestion(
                    question: "How can i add new delivery address?"),
                const VerticalSpeacing(14),
                const TopQuestion(
                  question: "How can i avail Sticker Price?",
                ),
                const VerticalSpeacing(24),
                Text(
                  "Topics",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(14),
                const TopQuestion(question: "My Account?"),
                const VerticalSpeacing(14),
                const TopQuestion(question: "Payments & Wallett?"),
                const VerticalSpeacing(14),
                const TopQuestion(question: "Shiping & Delivery"),
                const VerticalSpeacing(14),
                const TopQuestion(question: "Vouchers & Promotions?"),
                const VerticalSpeacing(14),
                const TopQuestion(
                  question: "Orderinge?",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
