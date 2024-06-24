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
                                  menuRepository.fetchItems("Fruits");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Fruits')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Vegetables");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Vegetables')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Milk");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Milk')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Cheese");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Cheese')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Yogurt");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Yogurt')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Meat");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Meat')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Milk");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Herbs')),
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
                                menuRepository.fetchItems("T-Shirts");
                                Provider.of<MenuUiRepository>(context,
                                        listen: false)
                                    .switchToType(MenuEnums.Category);
                              },
                              child: const CategoryCart(text: 'T-Shirts'),
                            ),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Shirts");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Shirts')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Sweaters");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Sweaters')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Hoodies");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Hoodies')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Jeans");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Jeans')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Trousers");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Trousers')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Shorts");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Shorts')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Jackets");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Jackets')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Coats");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Coats')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Blazers");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Blazers')),
                            InkWell(
                                onTap: () {
                                  menuRepository
                                      .fetchItems("Underwear & Socks");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(
                                    text: 'Underwear & Socks')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Belts");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Belts')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Hats");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Hats')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Gloves");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Gloves')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Blouses");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Blouses')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Skirts");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Skirts')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Leggings");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Leggings')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Casual Dresses");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child:
                                    const CategoryCart(text: 'Casual Dresses')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Evening Dresses");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(
                                    text: 'Evening Dresses')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Handbags");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Handbags')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Others...");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Others...')),
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
