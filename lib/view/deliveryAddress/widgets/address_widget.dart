// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';
import '../../Checkout/widgets/myCheckout.dart';

class address_widget extends StatelessWidget {
  const address_widget({
    super.key,
    required this.title,
    required this.address,
    required this.phNo,
    required this.uuid,
  });
  final String title;
  final String address;
  final String phNo;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const MyCheckBox(),
      title: Text.rich(
        TextSpan(
          text: '\n$title \n',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColor.fontColor,
            ),
          ),
          children: <TextSpan>[
            TextSpan(
              text: '$address\n',
              style: const TextStyle(
                color: AppColor.grayColor,
                fontSize: 14.0,
              ),
            ),
            TextSpan(
              text: '$phNo\n',
              style: const TextStyle(
                color: AppColor.grayColor,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
      titleAlignment: ListTileTitleAlignment.threeLine,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.edit_outlined,
              color: AppColor.fontColor,
              size: 24,
            ),
          ),
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
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
