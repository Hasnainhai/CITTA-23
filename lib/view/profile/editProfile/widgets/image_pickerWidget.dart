import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery(
  BuildContext context,
) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
  return image;
}

Future<File?> pickImageFromlience(
  BuildContext context,
) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
  return image;
}

Future<File?> pickImageFromid1(
  BuildContext context,
) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
  return image;
}

Future<File?> pickImageFromid2(
  BuildContext context,
) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
  return image;
}
