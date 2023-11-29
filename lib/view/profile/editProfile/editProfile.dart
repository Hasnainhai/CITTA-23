// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously
import 'dart:io';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/loading_manager.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../res/consts/firebase_const.dart';
import '../../../utils/utils.dart';
import 'widgets/image_pickerWidget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatefulWidget {
  String profilePic;
  String name;
  String email;
  String phNo;
  EditProfile({
    Key? key,
    required this.profilePic,
    required this.name,
    required this.email,
    required this.phNo,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  // ignore: unnecessary_string_interpolations
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phNoController = TextEditingController();

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
                    maxLines: 2,
                  ),
                  TextFieldCustom(
                    controller: phNoController,
                    text: 'Ph No',
                    hintText: widget.phNo,
                    maxLines: 2,
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
                            if (nameController.text.isEmpty) {
                              nameController.text = widget.name;
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushNamed(
                                  context, RoutesName.profileScreen);
                              Utils.toastMessage('SuccessFully Update');
                            } else if (emailController.text.isEmpty) {
                              emailController.text = widget.email;
                            } else if (phNoController.text.isEmpty) {
                              phNoController.text = widget.phNo;
                            } else if (image == null) {
                              widget.profilePic;
                              // final imageUrl =
                              //     await uploadImageToFirestore(image!, uid);
                              // setState(() {
                              //   widget.profilePic = imageUrl;
                              //   _isLoading = false;
                              // });
                              // Navigator.pushNamed(
                              //     context, RoutesName.profileScreen);
                              // Utils.toastMessage('SuccessFully Update');
                              // setState(() {
                              //   _isLoading = false;
                              // });
                            } else {
                              String _uid = user!.uid;
                              try {
                                // Upload the picked image to Firestore
                                if (image != null) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final imageUrl = await uploadImageToFirestore(
                                      image!, _uid);
                                  setState(() {
                                    widget.profilePic = imageUrl;
                                  });
                                }
                                // Update user data in Firestore
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_uid)
                                    .update({
                                  'name': nameController.text,
                                  'email': emailController.text,
                                  'phNo': phNoController.text,
                                });
                                Navigator.pushNamed(
                                    context, RoutesName.profileScreen);
                                Utils.toastMessage('SuccessFully Update');
                                setState(() {
                                  widget.name = nameController.text;
                                  widget.email = emailController.text;
                                  widget.phNo = phNoController.text;
                                });
                              } catch (err) {
                                setState(() {
                                  _isLoading = false;
                                });
                                Utils.flushBarErrorMessage(
                                    err.toString(), context);
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
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
