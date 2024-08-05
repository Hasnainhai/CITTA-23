import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/drawer/widget/top_questions.dart';
import 'package:flutter/material.dart';
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
              color: AppColor.primaryColor,
            )),
        title: const Text(
          "Help Center",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
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
                const Text(
                  "Hi! How can we help?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                const VerticalSpeacing(24),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColor.appBarButtonColor,
                      hintText: 'Search here...',
                      hintStyle: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grayColor,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.grayColor,
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const VerticalSpeacing(12),
                const Text(
                  "Top Questions",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                const VerticalSpeacing(8),
                const TopQuestion(question: "How do I return my items?"),
                const VerticalSpeacing(8),
                const TopQuestion(question: "How to use collection point?"),
                const VerticalSpeacing(8),
                const TopQuestion(question: "What is Grocery?"),
                const VerticalSpeacing(8),
                const TopQuestion(
                    question: "How can i add new delivery address?"),
                const VerticalSpeacing(8),
                const TopQuestion(
                  question: "How can i avail Sticker Price?",
                ),
                const VerticalSpeacing(12),
                const Text(
                  "Topics",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
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
