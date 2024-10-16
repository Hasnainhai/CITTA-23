import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/homeScreen.dart';
import 'package:citta_23/view/menu/menu.dart';
import 'package:citta_23/view/profile/profile_screen.dart';

import '../../../res/consts/firebase_const.dart';
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
  DateTime? currentBackPressTime;

  void onItemClick(int index) {
    setState(() {
      selectIndex = index;
      tabController!.index = selectIndex;
    });
  }

  String? _name;
  String? _pImage;
  final User? user = authInstance.currentUser;
  String defaultProfile =
      'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg';

  Future<void> getUserData() async {
    final googleAuth = FirebaseAuth.instance.currentUser;
    _name = googleAuth?.displayName ?? 'You';
    _pImage = googleAuth?.photoURL ?? defaultProfile;
    if (user != null) {
      try {
        String _uid = user!.uid;
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .get();
        if (userDoc != null || userDoc.data() != null) {
          _name = userDoc.get('name');
          _pImage = userDoc.get('profilePic');
        }
      } catch (error) {
        Utils.flushBarErrorMessage('$error', context);
      }
    }
  }

  Stream<int> getCartItemCountStream() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Stream<int>.empty();
    }

    String userId = currentUser.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    tabController = TabController(length: 4, vsync: this);
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();

    if (tabController!.index == 0 ||
        tabController!.index == 1 ||
        tabController!.index == 2 ||
        tabController!.index == 3) {
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: 'Press back again to exit');
        return Future.value(false); // Prevents exiting
      }
      return Future.value(true); // Allows exiting
    } else {
      return Future.value(true); // Allows normal back navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
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
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColor.fontColor,
          ),
          selectedLabelStyle: const TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColor.fontColor,
          ),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: ('Home'),
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_outlined,
              ),
              label: ('Categories'),
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_outlined,
              ),
              label: ('Wish List'),
            ),
            BottomNavigationBarItem(
              icon: _pImage == null
                  ? const Icon(Icons.account_circle)
                  : CircleAvatar(
                      radius: 14.0,
                      backgroundImage: NetworkImage(_pImage.toString()),
                    ),
              label: _name == null
                  ? 'You'
                  : _name!.substring(0, _name!.length > 6 ? 6 : _name!.length),
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
        floatingActionButton: StreamBuilder<int>(
          stream: getCartItemCountStream(),
          builder: (context, snapshot) {
            int itemCount = snapshot.data ?? 0;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
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
                      if (FirebaseAuth.instance.currentUser == null) {
                        showSignupDialog(context);
                      } else {
                        Navigator.pushNamed(context, RoutesName.cartScreen);
                      }
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: Center(
                      child:
                          Image.asset('images/card.png', height: 15, width: 15),
                    ),
                  ),
                ),
                if (itemCount > 0)
                  Positioned(
                    right: -4,
                    top: -15,
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.2),
                            blurRadius: 10.0,
                            offset: const Offset(4, 4),
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$itemCount',
                          style: const TextStyle(
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

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
                  'REGISTER',
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
