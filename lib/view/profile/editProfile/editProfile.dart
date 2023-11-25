// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:io';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/custom_field.dart';
import 'package:citta_23/res/components/roundedButton.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'widgets/image_pickerWidget.dart';

class EditProfile extends StatefulWidget {
  String profilePic;
  String name;
  String email;
  EditProfile({
    Key? key,
    required this.profilePic,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        const VerticalSpeacing(20.0),
                        Text(
                          widget.name,
                          style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryColor),
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
                const VerticalSpeacing(24.0),
                RoundedButton(
                  title: 'Update',
                  onpress: () {
                    if (nameController.text.isEmpty) {
                      nameController.text = widget.name;
                    } else if (emailController.text.isEmpty) {
                      emailController.text = widget.email;
                    } else {
                      // userAuth.updateUserInformation(
                      //   name: nameController.text,
                      //   lastName: lastNameController.text,
                      //   profilePic: image,
                      //   phoneNumber: phoneController.text,
                      //   context: context,
                      // );
                    }
                  },
                ),
                const VerticalSpeacing(20.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
