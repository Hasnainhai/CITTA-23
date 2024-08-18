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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('my_orders')
              .orderBy('date', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              Utils.flushBarErrorMessage('${snapshot.error}', context);
              return const Center(child: Text("Something went wrong"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                      "Your order has been",
                      style: TextStyle(
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
                    trailing: Text(
                      data['status'],
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => TrackOrder(
                              title: data['title'],
                              date: formatDateAndTime(data['date']),
                              status: data['status'],
                              weight: data['weight'],
                              items: "1",
                              price: data['salePrice'],
                              orderId: data['uuid'],
                              img: data['imageUrl'],
                            ),
                          ));
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
