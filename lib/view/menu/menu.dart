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
  List<String> foodCategories = [
    "Potatoes",
    'Beets',
    'Onion',
    'Garlic',
    'Pumpkin',
    'Tomatoes',
    'Cucumber',
    'Carrots',
    'Radishes',
    'Broccoli',
    "Kale",
    'Pasta',
    'Rice',
    'Sauces & Gravies',
    'Fruits',
    'Baking Mixes',
    'Flour & Sugar',
    'Fresh Meat',
    'Eggs',
    "Lamb",
    'Others',
  ];
  List<String> fashionCategories = [
    'T-Shirts',
    'Shirts',
    'Sweaters',
    'Hoodies',
    'Jeans',
    'Trousers',
    'Shorts',
    'Jackets',
    'Coats',
    'Blazers',
    'Underwear & Socks',
    'Belts',
    'Hats',
    'Gloves',
    'Blouses',
    'Skirts',
    'Leggings',
    'Casual Dresses',
    'Evening Dresses'
        'Handbags',
    "Others"
  ];
  var buttonCategoryType = CategoryType.food;

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const VerticalSpeacing(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (buttonCategoryType == CategoryType.food) {
                      return;
                    }
                    setState(() {
                      buttonCategoryType = CategoryType.food;
                      selectedCategory = null;
                    });
                    Provider.of<MenuRepository>(context, listen: false)
                        .handleFoodButton();
                    Provider.of<MenuUiRepository>(context, listen: false)
                        .switchToType(MenuEnums.DefaultSection);
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Center(
                          child: Container(
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              color: buttonCategoryType == CategoryType.food
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
                                    color:
                                        buttonCategoryType == CategoryType.food
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
                    if (buttonCategoryType == CategoryType.fashion) {
                      return;
                    }
                    setState(() {
                      buttonCategoryType = CategoryType.fashion;
                      selectedCategory = null;
                    });
                    Provider.of<MenuRepository>(context, listen: false)
                        .handleFashionButton();
                    Provider.of<MenuUiRepository>(context, listen: false)
                        .switchToType(MenuEnums.DefaultSection);
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Center(
                          child: Container(
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color:
                                    buttonCategoryType == CategoryType.fashion
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
                                    color: buttonCategoryType ==
                                            CategoryType.fashion
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
            Consumer<MenuRepository>(
              builder: (context, menuRepository, child) {
                return menuRepository.productType == "food"
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                                List.generate(foodCategories.length, (index) {
                              String category = foodCategories[index];
                              bool isSelected = category == selectedCategory;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (selectedCategory == category) {
                                      selectedCategory = null;
                                      Provider.of<MenuUiRepository>(context,
                                              listen: false)
                                          .switchToType(
                                              MenuEnums.DefaultSection);
                                    } else {
                                      selectedCategory = category;
                                      Provider.of<MenuUiRepository>(context,
                                              listen: false)
                                          .switchToType(MenuEnums.Category);
                                    }
                                  });
                                  menuRepository.fetchItems(category);
                                },
                                child: CategoryCart(
                                  text: category,
                                  textColor: isSelected
                                      ? AppColor.whiteColor
                                      : AppColor.primaryColor,
                                  containerColor: isSelected
                                      ? AppColor.primaryColor
                                      : AppColor.bgColor,
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(fashionCategories.length,
                                (index) {
                              String fashion = fashionCategories[index];
                              bool isSelected = fashion == selectedCategory;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (selectedCategory == fashion) {
                                      selectedCategory = null;
                                      Provider.of<MenuUiRepository>(context,
                                              listen: false)
                                          .switchToType(
                                              MenuEnums.DefaultSection);
                                    } else {
                                      selectedCategory = fashion;
                                      Provider.of<MenuUiRepository>(context,
                                              listen: false)
                                          .switchToType(MenuEnums.Category);
                                    }
                                  });
                                  menuRepository.fetchItems(fashion);
                                },
                                child: CategoryCart(
                                  text: fashion,
                                  textColor: isSelected
                                      ? AppColor.whiteColor
                                      : AppColor.primaryColor,
                                  containerColor: isSelected
                                      ? AppColor.primaryColor
                                      : AppColor.bgColor,
                                ),
                              );
                            }),
                          ),
                        ),
                      );
              },
            ),
            Consumer<MenuUiRepository>(
              builder: (context, uiState, _) {
                Widget selectedWidget;

                switch (uiState.selectedType) {
                  case MenuEnums.Category:
                    selectedWidget = MenuCategorySection(
                      category: selectedCategory!,
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
