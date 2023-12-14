import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import '../../res/consts/vars.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
   CategoryType? categoryType;
  // var categoryType = CategoryType.fashion;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerticalSpeacing(50.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Choose a Category',
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: AppColor.fontColor,
                  ),
                ),
              ),
            ),
            const VerticalSpeacing(30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (categoryType == CategoryType.food) {
                      return;
                    }
                    setState(() {
                      categoryType = CategoryType.food;
                    });
                    Navigator.pushNamed(context, RoutesName.newitemsscreen);
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: Center(
                          child: Container(
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: categoryType == CategoryType.food
                                    ? AppColor.buttonBgColor
                                    : Colors.transparent,
                                border: Border.all(
                                    width: 1, color: AppColor.buttonBgColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 33.0,
                                  width: 63.0,
                                  color: AppColor.categoryLightColor,
                                ),
                                Text(
                                  'Food',
                                  style: GoogleFonts.getFont(
                                    "Gothic A1",
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: categoryType == CategoryType.food
                                          ? AppColor.whiteColor
                                          : AppColor.buttonBgColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 25,
                        top: 0,
                        bottom: 5.0,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset(
                            'images/foodimg.png',
                            height: 59.0,
                            width: 59.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (categoryType == CategoryType.fashion) {
                      return;
                    }
                    setState(() {
                      categoryType = CategoryType.fashion;
                    });
                    Navigator.pushNamed(context, RoutesName.fashionProd);
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: Center(
                          child: Container(
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: categoryType == CategoryType.fashion
                                    ? AppColor.buttonBgColor
                                    : Colors.transparent,
                                border: Border.all(
                                    width: 1, color: AppColor.buttonBgColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 33.0,
                                  width: 63.0,
                                  color: AppColor.categoryLightColor,
                                ),
                                Text(
                                  'Fashion',
                                  style: GoogleFonts.getFont(
                                    "Gothic A1",
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          categoryType == CategoryType.fashion
                                              ? AppColor.whiteColor
                                              : AppColor.buttonBgColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        top: 0,
                        bottom: 12.0,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset(
                            'images/fashionimg.png',
                            height: 56.0,
                            width: 42.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
