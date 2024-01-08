// ignore_for_file: library_private_types_in_public_api

import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String formatDateAndTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDateTime =
        "${DateFormat.MMMd().format(dateTime)},${DateFormat.y().format(dateTime)},${DateFormat.jm().format(dateTime)}";
    return formattedDateTime;
  }

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
        title: const Text(
          'My Order',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColor.blackColor,
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
                  tabs: const <Widget>[
                    Tab(
                      text: 'All',
                    ),
                    Tab(text: 'Running'),
                    Tab(text: 'Previous'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        // Provide the TabController
        controller: _tabController,
        children: <Widget>[
          // Content for the "All" tab
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
                    Utils.flushBarErrorMessage('${snapshot.error}', context);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
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
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No orders to show"),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: myOrderCard(
                          orderId: data['uuid'],
                          date: formatDateAndTime(
                            data['date'],
                          ),
                          status: data['status'],
                          ontap: () {
                            Navigator.pushNamed(context, RoutesName.trackOrder);
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
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
                    Utils.flushBarErrorMessage('${snapshot.error}', context);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
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

                  // Filter documents where status is "Delivery send"
                  List<DocumentSnapshot> deliverySendOrders = snapshot
                      .data!.docs
                      .where((document) =>
                          (document.data() as Map<String, dynamic>)['status'] ==
                          'processing')
                      .toList();

                  if (deliverySendOrders.isEmpty) {
                    return const Center(
                      child: Text("No orders to show"),
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        deliverySendOrders.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: myOrderCard(
                          orderId: data['uuid'],
                          date: formatDateAndTime(
                            data['date'],
                          ),
                          status: data['status'],
                          ontap: () {
                            Navigator.pushNamed(context, RoutesName.trackOrder);
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),

          // Content for the "Previous" tab
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
                    Utils.flushBarErrorMessage('${snapshot.error}', context);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
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
                  List<DocumentSnapshot> deliverySendOrders = snapshot
                      .data!.docs
                      .where((document) =>
                          (document.data() as Map<String, dynamic>)['status'] ==
                          'Delivered')
                      .toList();

                  if (deliverySendOrders.isEmpty) {
                    return const Center(
                      child: Text("No orders to show"),
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        deliverySendOrders.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: myOrderCard(
                          orderId: data['uuid'],
                          date: formatDateAndTime(
                            data['date'],
                          ),
                          status: data['status'],
                          ontap: () {
                            Navigator.pushNamed(context, RoutesName.trackOrder);
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
