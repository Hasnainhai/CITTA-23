// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/firebase_const.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/profile/editProfile/editProfile.dart';
import 'package:citta_23/view/profile/my_review.dart';
import 'package:citta_23/view/profile/widgets/profileCenterBtn.dart';
import 'package:citta_23/view/profile/widgets/profile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/components/loading_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? address;
  String? _pImage;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  String defaultProfile =
      'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg';
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });

    final googleAuth = FirebaseAuth.instance.currentUser;
    _name = googleAuth?.displayName ?? 'You';
    _email = googleAuth?.email ?? 'Email';
    _pImage = googleAuth?.photoURL ?? defaultProfile;
    setState(() {
      _isLoading = false;
    });
    if (user != null) {
      try {
        String _uid = user!.uid;
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .get();
        if (userDoc != null || userDoc.data() != null) {
          _email = userDoc.get('email');
          _name = userDoc.get('name');
          _pImage = userDoc.get('profilePic');
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

// popUp
  void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          shape: const RoundedRectangleBorder(),
          icon: const Icon(
            Icons.no_accounts_outlined,
            size: 80,
            color: AppColor.primaryColor,
          ),
          title: const Text('You don\'t have any account, please'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.loginscreen);
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ),
              const SizedBox(height: 12.0), // Vertical spacing
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(),
                  side: const BorderSide(
                    color: AppColor.primaryColor, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.registerScreen);
                },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final double tHeight = 200.0;
  final double top = 130.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: const Text(
          'Profile ',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.transparent,
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  _buildCoverBar(),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 24.0, right: 24.0),
                    child: _buildProfile(),
                  ),
                  Positioned(
                    top: tHeight - top / 2 - 10,
                    child: _builProfileContainer(),
                  ),
                ],
              ),
              const VerticalSpeacing(70.0),
              _buildProfileFeatures(),
            ],
          ),
        ),
      ),
    );
  }

  _buildCoverBar() {
    return Container(
      height: tHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        color: AppColor.primaryColor,
      ),
    );
  }

  _buildProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Avatar and Text
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage(_pImage == null ? defaultProfile : _pImage!),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name == null ? 'You' : _name!,
                  style: const TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.whiteColor,
                  ),
                ),
                Text(
                  _email == null
                      ? 'Email'
                      : (_email!.length > 20
                          ? '${_email!.substring(0, 20)}...'
                          : _email!),
                  style: const TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Sign Up button
        if (_pImage == defaultProfile)
          InkWell(
            onTap: () {
              showSignupDialog(context);
            },
            child: Container(
              height: 40.0,
              width: 80.0,
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
              ),
              child: const Center(
                child: Text(
                  'sign Up',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  _builProfileContainer() {
    return Container(
      height: top,
      width: 350,
      color: AppColor.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          profileCenterBtns(
            ontap: () {
              Navigator.pushNamed(context, RoutesName.myOrder);
            },
            tColor: const Color(0xffFF6A9F),
            bColor: const Color(0xffD50059),
            icon: Icons.local_shipping_outlined,
            title: 'My All',
            subtitle: 'Order',
          ),
          profileCenterBtns(
            ontap: () {
              Navigator.pushNamed(context, RoutesName.deliveryAddress);
            },
            tColor: const Color(0xffFF6A9F),
            bColor: const Color(0xffD50059),
            icon: Icons.location_on_outlined,
            title: 'Delivery',
            subtitle: 'Address',
          ),
          profileCenterBtns(
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const MyReview(),
                ),
              );
            },
            tColor: const Color(0xffFF6A9F),
            bColor: const Color(0xffD50059),
            icon: Icons.star,
            title: 'Your',
            subtitle: 'Reviews',
          ),
        ],
      ),
    );
  }

  _buildProfileFeatures() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.42,
      width: MediaQuery.of(context).size.width * 0.9,
      color: AppColor.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                ProfileWidgets(
                    ontap: () {
                      Navigator.pushNamed(
                          context, RoutesName.notificationscreen);
                    },
                    tColor: const Color(0xffFF6A9F),
                    bColor: const Color(0xffD50059),
                    icon: Icons.notifications_outlined,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Notification'),
                const Divider(),
                ProfileWidgets(
                    ontap: () {
                      Navigator.pushNamed(context, RoutesName.restscreen);
                    },
                    tColor: const Color(0xffFF6A9F),
                    bColor: const Color(0xffD50059),
                    icon: Icons.lock_outline,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Reset Password'),
                const Divider(),
                ProfileWidgets(
                    ontap: () {
                      if (_name != null && _email != null) {
                        // Navigate to EditProfile with existing user details
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProfile(
                            profilePic: _pImage ?? defaultProfile,
                            name: _name ?? 'Default Name',
                            email: _email!.length > 12
                                ? "${_email!.substring(0, 12)}..."
                                : _email ?? 'Default Email',
                          );
                        }));
                      } else {
                        Utils.flushBarErrorMessage('Error occurred', context);
                      }
                    },
                    tColor: const Color(0xffFF6A9F),
                    bColor: const Color(0xffD50059),
                    icon: Icons.edit,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Edit Profile'),
                const Divider(),
                ProfileWidgets(
                    ontap: () {},
                    tColor: const Color(0xffFF6A9F),
                    bColor: const Color(0xffD50059),
                    icon: Icons.help_outline,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Help Center'),
                const Divider(),
                ProfileWidgets(
                  ontap: () async {
                    authInstance.signOut();
                    Utils.toastMessage('SuccessFully LogOut');
                    await Navigator.pushNamedAndRemoveUntil(
                        context, RoutesName.loginscreen, (route) => false);
                  },
                  tColor: const Color(0xffFF6A9F),
                  bColor: const Color(0xffD50059),
                  icon: Icons.logout_outlined,
                  trIcon: Icons.arrow_forward_ios,
                  title: 'Log Out',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
