import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/drawer/widget/top_questions.dart';
import 'package:flutter/material.dart';
import '../../res/components/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  bool item = false;
  bool point = false;
  bool grocery = false;
  bool address = false;
  bool price = false;
  bool account = false;
  bool wallet = false;
  bool delivery = false;
  bool promotion = false;
  bool ordering = false;
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
                const VerticalSpeacing(12),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 16,
                      ),
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
                TopQuestion(
                  question: "How do I return my items?",
                  onpress: () {
                    setState(() {
                      item = !item;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(8),
                TopQuestion(
                  question: "How to use collection point?",
                  onpress: () {
                    setState(() {
                      point = !point;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(8),
                TopQuestion(
                  question: "What is Grocery?",
                  onpress: () {
                    setState(() {
                      grocery = !grocery;
                    });
                  },
                ),
                const VerticalSpeacing(8),
                TopQuestion(
                  question: "How can i add new delivery address?",
                  onpress: () {
                    setState(() {
                      address = !address;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(8),
                TopQuestion(
                  question: "How can i avail Sticker Price?",
                  onpress: () {
                    setState(() {
                      price = !price;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
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
                TopQuestion(
                  question: "My Account?",
                  onpress: () {
                    setState(() {
                      account = !account;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(8),
                TopQuestion(
                  question: "Payments & Wallett?",
                  onpress: () {
                    setState(() {
                      wallet = !wallet;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(8),
                TopQuestion(
                  question: "Shiping & Delivery",
                  onpress: () {
                    setState(() {
                      delivery = !delivery;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(8),
                TopQuestion(
                  question: "Vouchers & Promotions?",
                  onpress: () {
                    setState(() {
                      promotion = !promotion;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(8),
                TopQuestion(
                  question: "Orderinge?",
                  onpress: () {
                    setState(() {
                      ordering = !ordering;
                    });
                  },
                ),
                Visibility(
                  visible: item,
                  child: const Text(
                    "Answer",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
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
