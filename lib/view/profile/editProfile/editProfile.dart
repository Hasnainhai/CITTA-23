// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously

import 'dart:io';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';
import 'widgets/image_pickerWidget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatefulWidget {
  String profilePic;
  String name;
  String email;
  EditProfile({
    super.key,
    required this.profilePic,
    required this.name,
    required this.email,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  // ignore: unnecessary_string_interpolations
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  void pickImage() async {
    final pickedImage = await pickImageFromGallery(context);

    setState(() {
      image = pickedImage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  Future<String> uploadImageToFirestore(File imageFile, String uid) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Upload image to Firebase Storage
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images/$uid.png');
      await storageRef.putFile(imageFile);

      // Get download URL
      final imageUrl = await storageRef.getDownloadURL();

      // Update Firestore document with the new profile image URL
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profilePic': imageUrl,
      });

      return imageUrl;
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      Utils.flushBarErrorMessage('$error', context);
      return ''; // Return an empty string or handle the error as needed
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'Edit Profile',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const VerticalSpeacing(20),
                      Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                  widget.profilePic,
                                ),
                                foregroundImage: image == null
                                    ? null
                                    : FileImage(
                                        image!,
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: AppColor.primaryColor,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: AppColor.whiteColor,
                                    ),
                                    onPressed: () {
                                      pickImage();
                                    },
                                    color: AppColor.splashBgColor,
                                    iconSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpeacing(29.0),
                  TextFieldCustom(
                    controller: nameController,
                    text: 'Name',
                    hintText: widget.name,
                    maxLines: 2,
                  ),
                  TextFieldCustom(
                    controller: emailController,
                    text: 'Email',
                    hintText: widget.email,
                    maxLines: 10,
                  ),
                  const VerticalSpeacing(24.0),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RoundedButton(
                          title: 'Update',
                          onpress: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              //user Id
                              String userId =
                                  FirebaseAuth.instance.currentUser!.uid;
                              //updating nameController;
                              if (nameController.text.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userId)
                                    .update({
                                  'name': nameController.text,
                                });
                                widget.name = nameController.text;
                              }
                              //updating emailController;
                              if (emailController.text.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userId)
                                    .update({
                                  'email': emailController.text,
                                });
                                widget.email = emailController.text;
                              }
                              if (image != null) {
                                final imageUrl = await uploadImageToFirestore(
                                    image!, userId);
                                //updating imageUrl
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userId)
                                    .update({
                                  'imageUrl': imageUrl,
                                });
                              }
                              Utils.toastMessage('Successfully Updated');
                              Navigator.pushNamed(
                                  context, RoutesName.profileScreen);
                            } catch (err) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushNamed(
                                  context, RoutesName.profileScreen);
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                        ),
                  const VerticalSpeacing(20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
