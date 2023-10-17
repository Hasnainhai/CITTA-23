import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/view/HomeScreen/homeScreen.dart';
import 'package:flutter/material.dart';

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
            HomeScreen()
            // DiscoverScreen(),
            // ChatScreen(),
            // JobPost(),
            // NotificationScreen(),
            // SettingScreen(),
          ],
        ),
        bottomNavigationBar: Stack(
          children: [
            Positioned(
              left: 100,
              right: 100,
              bottom: 0,
              child: Container(
                height: 40,
                width: 40,
                color: AppColor.primaryColor,
                child: const Icon(
                  Icons.shopping_basket_outlined,
                  size: 34,
                ),
              ),
            ),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: ('Discover'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_outlined),
                  label: ('Menu'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_basket_outlined,
                    size: 34,
                  ),
                  label: ('Chat'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_outline_rounded),
                  label: ('Save'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
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
          ],
        ));
  }
}
