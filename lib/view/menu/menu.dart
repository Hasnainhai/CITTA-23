import 'package:citta_23/repository/menu_repository.dart';
import 'package:citta_23/repository/menu_ui_repository.dart';
import 'package:citta_23/res/components/category_Cart.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/menu_enums.dart';
import 'package:citta_23/view/menu/menu_category_section.dart';
import 'package:citta_23/view/menu/menu_default_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/components/colors.dart';
import '../../res/consts/vars.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  CategoryType? categoryType;

  String category = "Shirt";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const VerticalSpeacing(50.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Choose a Category',
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: AppColor.fontColor,
                ),
              ),
            ),
            const VerticalSpeacing(30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Provider.of<MenuRepository>(context, listen: false)
                        .handleFoodButton();
                    Provider.of<MenuUiRepository>(context, listen: false)
                        .switchToType(MenuEnums.DefaultSection);
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
                                width: 1,
                                color: AppColor.buttonBgColor,
                              ),
                            ),
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
                                  style: TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: categoryType == CategoryType.food
                                        ? AppColor.whiteColor
                                        : AppColor.buttonBgColor,
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
                    Provider.of<MenuRepository>(context, listen: false)
                        .handleFashionButton();
                    Provider.of<MenuUiRepository>(context, listen: false)
                        .switchToType(MenuEnums.DefaultSection);
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
                                  style: TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: categoryType == CategoryType.fashion
                                        ? AppColor.whiteColor
                                        : AppColor.buttonBgColor,
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
            Consumer<MenuRepository>(builder: (context, menuRepository, child) {
              return menuRepository.productType == "food"
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("food");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'food')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("aly");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'aly')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("basit");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'basit')),
                          ],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                category = "Paints";

                                menuRepository.fetchItems("Paints");
                                Provider.of<MenuUiRepository>(context,
                                        listen: false)
                                    .switchToType(MenuEnums.Category);
                              },
                              child: const CategoryCart(text: 'Paints'),
                            ),
                            InkWell(
                                onTap: () {
                                  category = "jacket";
                                  menuRepository.fetchItems("jacket");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'jacket')),
                            InkWell(
                                onTap: () {
                                  category = "Under Wear";

                                  menuRepository.fetchItems("Under Wear");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Under Wear')),
                            InkWell(
                                onTap: () {
                                  category = "Shirt";

                                  menuRepository.fetchItems("Shirt");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Shirt')),
                          ],
                        ),
                      ),
                    );
            }),
            Consumer<MenuUiRepository>(
              builder: (context, uiState, _) {
                Widget selectedWidget;

                switch (uiState.selectedType) {
                  case MenuEnums.Category:
                    selectedWidget = MenuCategorySection(
                      category: category,
                    );
                    break;

                  case MenuEnums.DefaultSection:
                    selectedWidget = const MenuDefaultSection();
                    break;
                }

                return selectedWidget;
              },
            ),
          ],
        ),
      ),
    );
  }
}
