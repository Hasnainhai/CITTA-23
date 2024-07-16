import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:citta_23/view/HomeScreen/all_fashionProd.dart';
import 'package:citta_23/view/HomeScreen/popular_pack_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../res/components/colors.dart';
import 'widgets/price_slider.dart';

class FilterPopUp extends StatefulWidget {
  const FilterPopUp({super.key});

  @override
  State<FilterPopUp> createState() => _FilterPopUpState();
}

class _FilterPopUpState extends State<FilterPopUp> {
  bool button1 = false;
  bool button2 = false;

  bool button3 = false;

  bool button4 = false;
  bool button5 = true;
  bool button6 = false;

  bool button7 = false;

  bool button8 = false;
  final List _allCategorits = [];

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Filters",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(30),
                const PriceRangeSlider(),
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                const VerticalSpeacing(
                  20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _allCategorits.add('Fashion');
                        setState(() {
                          button1 = !button1;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                          color: button1
                              ? AppColor.primaryColor
                              : Colors.transparent,
                          border: Border.all(color: AppColor.primaryColor),
                        ),
                        child: Center(
                          child: Text(
                            "Fashion",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: button1
                                  ? AppColor.buttonTxColor
                                  : AppColor.fontColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          button2 = !button2;
                        });
                        _allCategorits.add('Grocery');
                      },
                      child: Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                          color: button2
                              ? AppColor.primaryColor
                              : Colors.transparent,
                          border: Border.all(color: AppColor.primaryColor),
                        ),
                        child: Center(
                          child: Text(
                            "Grocery",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: button2
                                  ? AppColor.buttonTxColor
                                  : AppColor.fontColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          button3 = !button3;
                        });
                        _allCategorits.add('Vagetabals');
                      },
                      child: Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                          color: button3
                              ? AppColor.primaryColor
                              : Colors.transparent,
                          border: Border.all(color: AppColor.primaryColor),
                        ),
                        child: Center(
                          child: Text(
                            "Vagetabals",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: button3
                                  ? AppColor.buttonTxColor
                                  : AppColor.fontColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(14),
                InkWell(
                  onTap: () {
                    setState(() {
                      button4 = !button4;
                    });
                    _allCategorits.add('See All');
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          button4 ? AppColor.primaryColor : Colors.transparent,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: button4
                              ? AppColor.buttonTxColor
                              : AppColor.fontColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalSpeacing(
                  30,
                ),
                const Text(
                  "Rating",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                const VerticalSpeacing(
                  14,
                ),
                RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    allowHalfRating: true,
                    glowColor: Colors.amber,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {}),
                const VerticalSpeacing(
                  50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _allCategorits.remove;
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Clear Filter",
                            style: TextStyle(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_allCategorits.contains('Grocery')) {
                          String title = 'Grocery';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PopularPackScreen(title: title)));
                          _allCategorits.remove('Grocery');
                        } else if (_allCategorits.contains('Vagetabals')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PopularPackScreen(
                                        title: 'Vagetabals',
                                      )));
                          _allCategorits.remove('Vagetabals');
                        } else if (_allCategorits.contains('Fashion')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AllFashionProd()));
                          _allCategorits.remove('Fashion');
                        } else if (_allCategorits.contains('See All')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DashBoardScreen()));
                          _allCategorits.remove('See All');
                        } else if (_allCategorits.contains('See All') ||
                            _allCategorits.contains('Fashion') ||
                            _allCategorits.contains('Vagetabals') ||
                            _allCategorits.contains('Grocery')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DashBoardScreen()));
                          _allCategorits.remove;
                        } else {
                          Utils.snackBar('Please Select a filter', context);
                        }
                      },
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          border: Border.all(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Apply Filter",
                            style: TextStyle(
                              color: AppColor.buttonTxColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
