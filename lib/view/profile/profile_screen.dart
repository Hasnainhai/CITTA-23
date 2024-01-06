// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/firebase_const.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/profile/editProfile/editProfile.dart';
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
    // if (googleAuth != null) {
    _name = googleAuth!.displayName;
    _email = googleAuth.email;
    _pImage = googleAuth.photoURL;
    setState(() {
      _isLoading = false;
    });
    // }
    // else {
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
    // }
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
          color: AppColor.buttonTxColor,
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
                alignment: Alignment.center,
                children: [
                  _buildCoverBar(),
                  Positioned(
                    top: 10.0,
                    left: 0.0,
                    child: _buildProfile(),
                  ),
                  Positioned(
                    top: tHeight - top / 2 - 10,
                    child: _builProfileContainer(),
                  ),
                ],
              ),
              const VerticalSpeacing(55.0),
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
      children: [
        const SizedBox(width: 30.0),
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(_pImage == null ? defaultProfile : _pImage!),
            ),
          ],
        ),
        const SizedBox(width: 20.0),
        Text.rich(
          TextSpan(
            text: '\n${_name == null ? 'Name' : _name!} \n',
            style: const TextStyle(
              fontFamily: 'CenturyGothic',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.whiteColor,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '${_email == null ? 'Email' : _email!} \n',
                style: const TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w200,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5.0),
        IconButton(
          onPressed: () {
            if (_name != null && _email != null) {
              // Navigate to EditProfile with existing user details
              Navigator.push(context, MaterialPageRoute(builder: (context) {
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
          icon: const Icon(
            Icons.edit_outlined,
            color: AppColor.whiteColor,
          ),
        )
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
            tColor: const Color(0xff6AA9FF),
            bColor: const Color(0xff005AD5),
            icon: Icons.local_shipping_outlined,
            title: 'My All',
            subtitle: 'Order',
          ),
          profileCenterBtns(
            ontap: () {
              Navigator.pushNamed(context, RoutesName.promosOffer);
            },
            tColor: const Color(0xffFF6A9F),
            bColor: const Color(0xffD50059),
            icon: Icons.card_giftcard_outlined,
            title: 'Offer &',
            subtitle: 'Promos',
          ),
          profileCenterBtns(
            ontap: () {
              Navigator.pushNamed(context, RoutesName.deliveryAddress);
            },
            tColor: const Color(0xff6DF5FC),
            bColor: const Color(0xff3CB6BB),
            icon: Icons.home_outlined,
            title: 'Delivery',
            subtitle: 'Address',
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
                    tColor: const Color(0xff6DF5FC),
                    bColor: const Color(0xff46C5CA),
                    icon: Icons.notifications_outlined,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Notification'),
                const Divider(),
                ProfileWidgets(
                    ontap: () {
                      Navigator.pushNamed(context, RoutesName.restscreen);
                    },
                    tColor: const Color(0xffDF9EF5),
                    bColor: const Color(0xffA24ABF),
                    icon: Icons.lock_outline,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Reset Password'),
                const Divider(),
                ProfileWidgets(
                  ontap: () async {
                    authInstance.signOut();
                    Utils.toastMessage('SuccessFully LogOut');
                    await Navigator.pushNamedAndRemoveUntil(
                        context, RoutesName.loginscreen, (route) => false);
                  },
                  tColor: const Color(0xffFF9CCB),
                  bColor: const Color(0xffEC4091),
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
