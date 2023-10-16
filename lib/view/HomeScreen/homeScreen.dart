import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/view/HomeScreen/widgets/Home_design.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<IconData> iconList = [
    Icons.home,
    Icons.menu,
    Icons.save,
    Icons.person_2_rounded,
  ];
  final List<Widget> pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage(),
  ];
  final List<String> pagesName = [
    'Home',
    'Menu',
    'Save',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40.0,
              width: 40.0,
              color: AppColor.appBarButtonColor,
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notes,
                    color: AppColor.menuColor,
                  ),
                ),
              ),
            ),
          ),
          title: Container(
            height: 40.0,
            width: 190.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on,
                      color: AppColor.menuColor,
                    ),
                  ),
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Current Location \n',
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.fontColor,
                            ),
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'Chhatak,Syhlet',
                              style: TextStyle(
                                color: AppColor.grayColor,
                                fontWeight: FontWeight.w200,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.expand_more,
                    color: AppColor.buttonBgColor,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40.0,
                width: 40.0,
                color: AppColor.appBarButtonColor,
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: AppColor.menuColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBottomNavigationBar.builder(
                onTap: (index){
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: iconList.length,
                tabBuilder: (int index, bool isActive) {
                  final color = isActive ? Colors.blue : Colors.grey;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        iconList[index],
                        size: 24,
                        color: color,
                      ),
                      Text(
                        pagesName[index],
                        style: TextStyle(color: color),
                      ),
                    ],
                  );
                },
                activeIndex: _currentIndex,
                splashColor: Colors.blue,
                splashSpeedInMilliseconds: 300,
                splashRadius: 20,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.defaultEdge,
                // onTap: (index) {
                //   setState(() {
                //     _currentIndex = index;
                //   });
                // },
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: (MediaQuery.of(context).size.width / 2) - 30.0,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.pink,
                ),
                child: const Center(
                  child: Icon(
                    Icons.shopping_basket_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'First Paage',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Second Page'),
    );
  }
}

class ThirdPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Third Page'),
    );
  }
}

class FourthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Fourth Page'),
    );
  }
}
