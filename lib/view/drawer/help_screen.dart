import 'package:flutter/material.dart';
import '../../res/components/colors.dart';
import '../../res/components/widgets/verticalSpacing.dart';
import 'widget/top_questions.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String? expandedQuestion;
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> questionsAndAnswers = [
    {
      "question": "How do I return my items?",
      "answer": "Answer for item return"
    },
    {
      "question": "How to use collection point?",
      "answer": "Answer for collection point"
    },
    {"question": "What is Grocery?", "answer": "Answer for grocery"},
    {
      "question": "How can I add a new delivery address?",
      "answer": "Answer for delivery address"
    },
    {
      "question": "How can I avail Sticker Price?",
      "answer": "Answer for sticker price"
    },
    {"question": "My Account?", "answer": "Answer for account"},
    {
      "question": "Payments & Wallet?",
      "answer": "Answer for payments and wallet"
    },
    {
      "question": "Shipping & Delivery?",
      "answer": "Answer for shipping and delivery"
    },
    {
      "question": "Vouchers & Promotions?",
      "answer": "Answer for vouchers and promotions"
    },
    {"question": "Ordering?", "answer": "Answer for ordering"},
  ];

  List<Map<String, String>> filteredQuestionsAndAnswers = [];

  @override
  void initState() {
    super.initState();
    filteredQuestionsAndAnswers = questionsAndAnswers;
    searchController.addListener(_filterQuestions);
  }

  void _filterQuestions() {
    String query = searchController.text.toLowerCase();
    debugPrint("Current query: $query");

    setState(() {
      if (query.isEmpty) {
        filteredQuestionsAndAnswers = questionsAndAnswers;
        isSearch = false;
        debugPrint("Query is empty, showing all questions.");
      } else {
        filteredQuestionsAndAnswers = questionsAndAnswers
            .where((qa) => qa['question']!.toLowerCase().contains(query))
            .toList();
        isSearch = true;
        debugPrint(
            "Filtered results length: ${filteredQuestionsAndAnswers.length}");
      }
    });
  }

  void _toggleQuestion(String question) {
    setState(() {
      expandedQuestion = (expandedQuestion == question) ? null : question;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildQuestionTile(Map<String, String> qa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopQuestion(
          question: qa['question']!,
          onpress: () => _toggleQuestion(qa['question']!),
        ),
        if (expandedQuestion == qa['question'])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              qa['answer']!,
              style: const TextStyle(
                fontFamily: 'CenturyGothic',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.fontColor,
              ),
            ),
          ),
        const VerticalSpeacing(8),
      ],
    );
  }

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
          padding: const EdgeInsets.all(20.0),
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
                      controller: searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              left: 16), // Align the icon with the hint text
                          child: Icon(
                            Icons.search,
                            size:
                                20, // Slightly increase the size for better alignment
                          ),
                        ),
                        filled: true,
                        fillColor: AppColor.appBarButtonColor,
                        hintText: 'Search here...',
                        hintStyle: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize:
                              14, // Adjust the font size for better alignment
                          fontWeight: FontWeight.w400,
                          color: AppColor.grayColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal:
                                16), // Adjust vertical padding for alignment
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.grayColor,
                      ),
                      onChanged: (value) {
                        setState(() {
                          isSearch = value.isNotEmpty;
                        });
                      }),
                ),
                const VerticalSpeacing(12),
                isSearch
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: ListView.builder(
                          itemCount: filteredQuestionsAndAnswers.length,
                          itemBuilder: (context, index) {
                            debugPrint(
                                "Rendering question: ${filteredQuestionsAndAnswers[index]['question']}");

                            return _buildQuestionTile(
                                filteredQuestionsAndAnswers[index]);
                          },
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          ...questionsAndAnswers
                              .take(5)
                              .map(_buildQuestionTile)
                              .toList(),
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
                          ...questionsAndAnswers
                              .skip(5)
                              .map(_buildQuestionTile)
                              .toList(),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
