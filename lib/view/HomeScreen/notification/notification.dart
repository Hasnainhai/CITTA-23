import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:intl/intl.dart';
import '../../trackOrder/track_order.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  String formatDateAndTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDateTime =
        "${DateFormat.MMMd().format(dateTime)},${DateFormat.y().format(dateTime)},${DateFormat.jm().format(dateTime)}";
    return formattedDateTime;
  }

  Future<List<QueryDocumentSnapshot>> _fetchOrders() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('my_orders')
          // .where("status", isEqualTo: "Delivered")
          .orderBy('date', descending: true)
          .get();
      return snapshot.docs;
    } catch (e) {
      // Handle the error here if needed
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.fontColor,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: _fetchOrders(),
          builder: (BuildContext context,
              AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
            if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Utils.flushBarErrorMessage('${snapshot.error}', context);
              });
              return const Center(child: Text("Something went wrong"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No notifications to show",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
              );
            }
            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      "Your order of '${data['title']}' has been Delivered",
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.fontColor,
                      ),
                    ),
                    subtitle: Text(
                      formatDateAndTime(
                        data['date'],
                      ),
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.fontColor,
                      ),
                    ),
                    leading: Image.network(
                      data['imageUrl'] ?? 'images/logo.png',
                      height: 50,
                      width: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('images/logo.png',
                            height: 50, width: 50);
                      },
                    ),
                    // trailing: const Text(
                    //   "Delivered",
                    //   style: TextStyle(
                    //     fontFamily: 'CenturyGothic',
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w600,
                    //     color: AppColor.primaryColor,
                    //   ),
                    // ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => TrackOrder(
                            title: data['title'],
                            date: formatDateAndTime(data['date']),
                            status: data['status'],
                            weight: data['weight'],
                            items: data['quantity'],
                            price: data['salePrice'],
                            orderId: data['uuid'],
                            img: data['imageUrl'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
