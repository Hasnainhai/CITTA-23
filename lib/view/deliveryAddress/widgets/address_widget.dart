// ignore_for_file: camel_case_types

import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/deliveryAddress/edit_delivery_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../res/components/colors.dart';
import '../../Checkout/widgets/myCheckout.dart';

class address_widget extends StatelessWidget {
  const address_widget({
    super.key,
    required this.title,
    required this.address,
    required this.phNo,
    required this.uuid,
    required this.name,
    required this.address1,
    required this.zipcode,
    required this.state,
  });
  final String title;
  final String address;
  final String phNo;
  final String uuid;
  final String name;
  final String address1;
  final String zipcode;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColor.primaryColor), // Set border color to grey
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    VerticalSpeacing(6),
                    MyCheckBox(),
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColor.fontColor,
                      ),
                    ),
                    Text(
                      address,
                      style: const TextStyle(
                        color: AppColor.grayColor,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      phNo,
                      style: const TextStyle(
                        color: AppColor.grayColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => EditAddressScreen(
                            name: name,
                            address1: address1,
                            zipCode: zipcode,
                            city: title,
                            address2: address,
                            phoneNumber: phNo,
                            state: state,
                            uuid: uuid),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    color: AppColor.fontColor,
                    size: 20,
                  ),
                ),
                const VerticalSpeacing(8),
                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("my_Address")
                        .doc(uuid)
                        .delete();
                    Fluttertoast.showToast(msg: "Address has been delete");
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColor.fontColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
