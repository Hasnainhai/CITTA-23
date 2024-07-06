import 'dart:io';

import 'package:another_flushbar/flushbar_route.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:image_picker/image_picker.dart';

int? totalPrice;
String? initialPrice;
String? finalIndex;

class Utils {
  static void focusNode(
      BuildContext context, FocusNode current, FocusNode focusNext) {
    current.unfocus();
    FocusScope.of(context).requestFocus(focusNext);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        borderRadius: BorderRadius.circular(0.0),
        titleSize: 20.0,
        padding: const EdgeInsets.all(16.0),
        positionOffset: 20,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColor.primaryColor,
        flushbarPosition: FlushbarPosition.TOP,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
          size: 30.0,
        ),
      )..show(context),
    );
  }

  static void snackBar(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        margin: const EdgeInsets.symmetric(horizontal: 60.0),
        message: message,
        borderRadius: BorderRadius.circular(0.0),
        titleSize: 20.0,
        padding: const EdgeInsets.all(16.0),
        positionOffset: 20,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColor.primaryColor,
        flushbarPosition: FlushbarPosition.TOP,
        icon: const Icon(
          Icons.check,
          color: AppColor.whiteColor,
        ),
      )..show(context),
    );
  }

  Future<File?> pickImageFromGallery(
    BuildContext context,
  ) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(
          pickedImage.path,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return image;
  }
}
