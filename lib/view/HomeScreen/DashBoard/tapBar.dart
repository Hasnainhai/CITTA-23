import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/view/HomeScreen/homeScreen.dart';
import 'package:citta_23/view/card/card_screen.dart';
import 'package:citta_23/view/menu/menu.dart';
import 'package:citta_23/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../Favourite/favourite_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectIndex = 0;
  onItemClick(int index) {
    setState(() {
      selectIndex = index;
      tabController!.index = selectIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeScreen(),
          MenuScreen(),
          CardScreen(),
          FavouriteList(),
          ProfileScreen(),
          // DiscoverScreen(),
          // ChatScreen(),
          // JobPost(),
          // NotificationScreen(),
          // SettingScreen(),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: ('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_alt_outlined,
                ),
                label: ('Menu'),
              ),
                BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                ),
                label: ('Cart')
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark_outline_rounded,
                ),
                label: ('Save'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                label: ('Profile'),
              ),
            ],
            unselectedItemColor: AppColor.grayColor,
            selectedItemColor: AppColor.buttonBgColor,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            // selectedLabelStyle: const TextStyle(fontSize: 16),
            currentIndex: selectIndex,
            onTap: onItemClick,
          ),
          // Positioned(
          //   left: MediaQuery.of(context).size.width / 2 - 30, 
          //   bottom: 0,
          //   child: Container(
          //     color: AppColor.primaryColor,
          //     height: 60,
          //     width: 60,
          //     child: const Center(
          //       child: Icon(
          //         Icons.shopping_basket_outlined,
          //         size: 40,
          //         color: AppColor.whiteColor, 
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
