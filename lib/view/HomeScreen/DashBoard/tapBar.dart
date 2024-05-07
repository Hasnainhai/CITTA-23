// ignore_for_file: file_names

import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/HomeScreen/homeScreen.dart';
import 'package:citta_23/view/menu/menu.dart';
import 'package:citta_23/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../Favourite/favourite_list.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
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
    tabController = TabController(length: 4, vsync: this);
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
          FavouriteList(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: selectIndex,
        onTap: onItemClick,
      ),
      floatingActionButton: Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(
          color: AppColor.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(254, 1, 128, 0.2588),
              blurRadius: 18.0,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.cartScreen);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset('images/card.png'),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
