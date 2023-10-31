import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import 'widgets/price_slider.dart';

class FilterPopUp extends StatefulWidget {
  const FilterPopUp({super.key});

  @override
  State<FilterPopUp> createState() => _FilterPopUpState();
}

class _FilterPopUpState extends State<FilterPopUp> {
  bool button1 = true;
  bool button2 = false;

  bool button3 = false;

  bool button4 = false;
  bool button5 = true;
  bool button6 = false;

  bool button7 = false;

  bool button8 = false;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Filter",
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
            const VerticalSpeacing(30),
            const PriceRangeSlider(),
            Text(
              "Categories",
              style: GoogleFonts.getFont(
                "Gothic A1",
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColor.fontColor,
                ),
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
                    setState(() {
                      button1 = !button1;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          button1 ? AppColor.primaryColor : Colors.transparent,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        "Office Supplies",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: TextStyle(
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
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      button2 = !button2;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          button2 ? AppColor.primaryColor : Colors.transparent,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        "Gardening",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: TextStyle(
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
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      button3 = !button3;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          button3 ? AppColor.primaryColor : Colors.transparent,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        "Vagetabals",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: TextStyle(
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
                ),
              ],
            ),
            const VerticalSpeacing(14),
            InkWell(
              onTap: () {
                setState(() {
                  button4 = !button4;
                });
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: button4 ? AppColor.primaryColor : Colors.transparent,
                  border: Border.all(color: AppColor.primaryColor),
                ),
                child: Center(
                  child: Text(
                    "See All",
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: TextStyle(
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
            ),
            const VerticalSpeacing(
              30,
            ),
            Text(
              "Brand",
              style: GoogleFonts.getFont(
                "Gothic A1",
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColor.fontColor,
                ),
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
                    setState(() {
                      button5 = !button5;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          button5 ? AppColor.primaryColor : Colors.transparent,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        "Any",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: button5
                                ? AppColor.buttonTxColor
                                : AppColor.fontColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      button6 = !button6;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          button6 ? AppColor.primaryColor : Colors.transparent,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        "Square",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: button6
                                ? AppColor.buttonTxColor
                                : AppColor.fontColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      button7 = !button7;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          button7 ? AppColor.primaryColor : Colors.transparent,
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        "ACI Limited",
                        style: GoogleFonts.getFont(
                          "Gothic A1",
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: button7
                                ? AppColor.buttonTxColor
                                : AppColor.fontColor,
                          ),
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
                  button8 = !button8;
                });
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: button8 ? AppColor.primaryColor : Colors.transparent,
                  border: Border.all(color: AppColor.primaryColor),
                ),
                child: Center(
                  child: Text(
                    "See All",
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: button8
                            ? AppColor.buttonTxColor
                            : AppColor.fontColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const VerticalSpeacing(
              30,
            ),
            Text(
              "Rating",
              style: GoogleFonts.getFont(
                "Gothic A1",
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColor.fontColor,
                ),
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
                    Navigator.pop(context);
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
            )
          ],
        ),
      ),
    );
  }
}
