// ignore_for_file: library_private_types_in_public_api

import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'myOrder_Widgets/myOrder_card.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with the number of tabs
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose of the TabController when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RoutesName.dashboardScreen,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
        title: Text(
          'My Order',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColor.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(70.0), // Adjust the height as needed
          child: SafeArea(
            child: Column(
              children: <Widget>[
                TabBar(
                  indicatorColor:
                      AppColor.primaryColor, // Color of the selection indicator
                  labelColor: AppColor
                      .primaryColor, // Color of the selected tab's label
                  unselectedLabelColor: AppColor.grayColor,
                  controller: _tabController, // Provide the TabController
                  tabs: <Widget>[
                    Tab(
                      text: 'All',
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('my_orders')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            int ordersLength = snapshot.data!.docs.length;
                            return Text('($ordersLength)');
                          } else if (snapshot.hasError) {
                            return const Text('Error');
                          } else {
                            return const Text('(Loading...)');
                          }
                        },
                      ),
                    ),
                   const  Tab(text: 'Running(14)'),
                    const Tab(text: 'Previous(32)'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Provide the TabController
        children: <Widget>[
          // Content for the "All" tab
          ListView(
            children: [
              Column(
                children: [
                  const VerticalSpeacing(20.0),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('my_orders')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        Utils.flushBarErrorMessage(
                            '${snapshot.error}', context);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Shimmer(
                                duration: const Duration(seconds: 3),
                                interval: const Duration(seconds: 5),
                                color: AppColor.grayColor.withOpacity(0.2),
                                colorOpacity: 0.2,
                                enabled: true,
                                direction: const ShimmerDirection.fromLTRB(),
                                child: Container(
                                  height: 100.0,
                                  width: double.infinity,
                                  color: AppColor.grayColor.withOpacity(0.2),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myOrderCard(
                              orderId: data['uuid'],
                              date: data['date'],
                              status: data['status'],
                              ontap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.trackOrder);
                              },
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  // const VerticalSpeacing(20.0),
                  // myOrderCard(
                  //     orderId: '678494',
                  //     date: '25 NOV',
                  //     status: 'Completed',
                  //     ontap: () {
                  //       Navigator.pushNamed(context, RoutesName.trackOrder);
                  //     }),
                  // const VerticalSpeacing(20.0),
                  // myOrderCard(
                  //     orderId: '847382',
                  //     date: '12 DEC',
                  //     status: 'Shipped',
                  //     ontap: () {
                  //       Navigator.pushNamed(context, RoutesName.trackOrder);
                  //     }),
                  // const VerticalSpeacing(20.0),
                  // myOrderCard(
                  //     orderId: '748398',
                  //     date: '8 JAN',
                  //     status: 'Delivered',
                  //     ontap: () {
                  //       Navigator.pushNamed(context, RoutesName.trackOrder);
                  //     }),
                  // const VerticalSpeacing(20.0),
                  // myOrderCard(
                  //     orderId: '099876',
                  //     date: '16 FEB',
                  //     status: 'Processing',
                  //     ontap: () {
                  //       Navigator.pushNamed(context, RoutesName.trackOrder);
                  //     }),
                  // const VerticalSpeacing(20.0),
                  // myOrderCard(
                  //     orderId: '748398',
                  //     date: '8 JAN',
                  //     status: 'Delivered',
                  //     ontap: () {}),
                  // const VerticalSpeacing(20.0),
                  // myOrderCard(
                  //     orderId: '099876',
                  //     date: '16 FEB',
                  //     status: 'Processing',
                  //     ontap: () {}),
                ],
              ),
            ],
          ),
          // Content for the "Running" tab
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                      orderId: '236743',
                      date: '22 OCT',
                      status: 'Processing',
                      ontap: () {
                        Navigator.pushNamed(context, RoutesName.trackOrder);
                      },
                    ),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '678494',
                        date: '20 NOV',
                        status: 'Completed',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '847382',
                        date: '11 DEC',
                        status: 'Shipped',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '748398',
                        date: '9 JAN',
                        status: 'Delivered',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '099876',
                        date: '17 FEB',
                        status: 'Processing',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '748398',
                        date: '23 JAN',
                        status: 'Delivered',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '099876',
                        date: '13 FEB',
                        status: 'Processing',
                        ontap: () {}),
                  ],
                ),
              ],
            ),
          ),
          // Content for the "Previous" tab
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                      orderId: '236743',
                      date: '28 OCT',
                      status: 'Processing',
                      ontap: () {
                        Navigator.pushNamed(context, RoutesName.trackOrder);
                      },
                    ),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '678494',
                        date: '20 NOV',
                        status: 'Completed',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '847382',
                        date: '10 DEC',
                        status: 'Shipped',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '748398',
                        date: '6 JAN',
                        status: 'Delivered',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '099876',
                        date: '15 FEB',
                        status: 'Processing',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '748398',
                        date: '18 JAN',
                        status: 'Delivered',
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.trackOrder);
                        }),
                    const VerticalSpeacing(20.0),
                    myOrderCard(
                        orderId: '099876',
                        date: '17 FEB',
                        status: 'Processing',
                        ontap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
