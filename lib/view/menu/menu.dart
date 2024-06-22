import 'package:citta_23/repository/menu_repository.dart';
import 'package:citta_23/repository/menu_ui_repository.dart';
import 'package:citta_23/res/components/category_Cart.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/menu_enums.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/fashion_detail.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:citta_23/view/menu/menu_category_section.dart';
import 'package:citta_23/view/menu/menu_default_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../res/components/colors.dart';
import '../../res/consts/vars.dart';
import '../../routes/routes_name.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  CategoryType? categoryType;
  late CollectionReference _collectionReference;
  String productType = 'food';
  bool isTrue = true;

  void _handleFoodButton() {
    // Change the collection to 'products'
    setState(() {
      productType = 'food';
      _collectionReference = FirebaseFirestore.instance.collection('products');
    });
  }

  void _handleFashionButton() {
    // Change the collection to 'fashion'
    setState(() {
      productType = 'fashion';
      _collectionReference = FirebaseFirestore.instance.collection('fashion');
    });
  }

  String dPrice(String originalPriceString, String discountPercentageString) {
    // Convert strings to double

    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);

    // Calculate discounted price
    double discountedPrice = originalPrice * (discountPercentage / 100);

    // Return the discounted price as a formatted string
    return discountedPrice.toStringAsFixed(
        0); // You can adjust the number of decimal places as needed
  }

  String calculateDiscountedPrice(
      String originalPriceString, String discountPercentageString) {
    // Convert strings to double

    double originalPrice = double.parse(originalPriceString);
    double discountPercentage = double.parse(discountPercentageString);

    // Calculate discounted price
    double p = originalPrice * (discountPercentage / 100);
    double discountedPrice = originalPrice - p;
    String orPrice = discountedPrice.toInt().toString();
    // Convert to integer to remove decimal places and then back to string
    return orPrice;
  }

  // popUp
  void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          shape: const RoundedRectangleBorder(),
          icon: const Icon(
            Icons.no_accounts_outlined,
            size: 80,
            color: AppColor.primaryColor,
          ),
          title: const Text('You don\'t have any account, please'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.loginscreen);
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ),
              const SizedBox(height: 12.0), // Vertical spacing
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(),
                  side: const BorderSide(
                    color: AppColor.primaryColor, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.registerScreen);
                },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addToCart(
      String img,
      String title,
      String dPrice,
      String sellerId,
      String productId,
      String size,
      String weight,
      String color,
      String disPrice) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      showSignupDialog(context);
      return;
    }

    final userId = currentUser.uid;
    // Get the collection reference for the user's cart
    CollectionReference cartCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    // Check if the product is already in the cart
    QuerySnapshot cartSnapshot = await cartCollectionRef
        .where('imageUrl', isEqualTo: img)
        .limit(1)
        .get();

    if (cartSnapshot.docs.isNotEmpty) {
      // Product is already in the cart, show a popup message
      Utils.toastMessage('Product is already in the cart');
    } else {
      // Product is not in the cart, add it
      var uuid = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(uuid)
          .set({
        'sellerId': sellerId,
        'id': productId,
        'imageUrl': img,
        'title': title,
        'salePrice': dPrice,
        'deleteId': uuid,
        "size": size,
        'weight': weight,
        'dPrice': disPrice,
        'color': color,
        // Add other product details as needed
      });
      Utils.toastMessage('Successfully added to cart');
    }
  }

  @override
  void initState() {
    super.initState();
    _collectionReference = FirebaseFirestore.instance.collection('products');
  }

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
                                onTap: () {},
                                child: const CategoryCart(text: 'food')),
                            InkWell(
                                onTap: () {},
                                child: const CategoryCart(text: 'food')),
                            InkWell(
                                onTap: () {},
                                child: const CategoryCart(text: 'food')),
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
                                menuRepository.fetchItems("Paints");
                                Provider.of<MenuUiRepository>(context,
                                        listen: false)
                                    .switchToType(MenuEnums.Category);
                              },
                              child: const CategoryCart(text: 'Paints'),
                            ),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("jacket");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'jacket')),
                            InkWell(
                                onTap: () {
                                  menuRepository.fetchItems("Under Wear");
                                  Provider.of<MenuUiRepository>(context,
                                          listen: false)
                                      .switchToType(MenuEnums.Category);
                                },
                                child: const CategoryCart(text: 'Under Wear')),
                            InkWell(
                                onTap: () {
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
                    selectedWidget = const MenuCategorySection();
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
