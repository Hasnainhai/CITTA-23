import 'package:citta_23/repository/search_repository.dart';
import 'package:citta_23/repository/ui_repository.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/ui_enums.dart';
import 'package:citta_23/view/HomeScreen/defaullt_section.dart';
import 'package:citta_23/view/HomeScreen/search_section.dart';
import 'package:citta_23/view/drawer/drawer.dart';
import 'package:citta_23/view/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isLoading = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return LoadingManager(
      isLoading: _isLoading,
      child: Scaffold(
        drawer: const DrawerScreen(),
        key: scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10,
            ),
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40.0,
                          width: 40.0,
                          color: AppColor.appBarButtonColor,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                scaffoldKey.currentState?.openDrawer();
                              },
                              icon: const Icon(
                                Icons.notes,
                                color: AppColor.menuColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width / 1.35,
                          color: AppColor.appBarButtonColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: AppColor.menuColor,
                                ),
                              ),
                              Consumer<ProductProvider>(
                                  builder: (context, productProvider, _) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: TextField(
                                      controller: searchController,
                                      decoration: const InputDecoration(
                                        hintText: 'Search Products...',
                                        hintStyle: TextStyle(
                                          fontFamily: 'CenturyGothic',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
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
                                      onChanged: (value) {
                                        if (searchController.text.isNotEmpty) {
                                          productProvider.filterProducts(value);
                                          Provider.of<HomeUiSwithchRepository>(
                                                  context,
                                                  listen: false)
                                              .switchToType(
                                                  UIType.SearchSection);
                                        } else {
                                          Provider.of<HomeUiSwithchRepository>(
                                                  context,
                                                  listen: false)
                                              .switchToType(
                                                  UIType.DefaultSection);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }),
                              Container(
                                height: 40.0,
                                width: 40.0,
                                color: AppColor.primaryColor,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const FilterPopUp();
                                      }));
                                    },
                                    icon: const Icon(
                                      Icons.tune_outlined,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpeacing(16.0),
                    Container(
                      height: 78.0,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/banner.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const VerticalSpeacing(16.0),
                    Consumer<HomeUiSwithchRepository>(
                      builder: (context, uiState, _) {
                        Widget selectedWidget;

                        switch (uiState.selectedType) {
                          case UIType.SearchSection:
                            selectedWidget = const SearchSection();
                            break;
                          case UIType.DefaultSection:
                            selectedWidget = const DefaultSection();
                            break;
                        }

                        return selectedWidget;
                      },
                    ),
                    const VerticalSpeacing(20.0),
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
