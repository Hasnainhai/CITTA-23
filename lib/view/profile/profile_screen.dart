// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison
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
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  String? _email;
  String? _name;
  String? address;
  String? _pImage;
  String? _phNo;
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
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    } else {
      try {
        String _uid = user!.uid;
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .get();
        // ... existing code ...
        if (userDoc != null || userDoc.data() != null) {
          _email = userDoc.get('email');
          _name = userDoc.get('name');
          _phNo = userDoc.get('phNo');
          address = userDoc.get('shipping-address');
          _pImage = userDoc.get('profilePic');

          _addressTextController.text = userDoc.get('shipping-address');
          GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
          if (googleUser != null) {
            _name = googleUser.displayName;
            _email = googleUser.email;
            _pImage = googleUser.photoUrl ?? defaultProfile;
            // Assuming you don't have a phone number for Google sign-in
            // _phNo = 'Default Phone Number';
          }
        } else {
          Utils.flushBarErrorMessage('User data not found', context);
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        // Utils.flushBarErrorMessage('$error', context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    //   try {
    // String _uid = user!.uid;
    // final DocumentSnapshot userDoc =
    //     await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    //     if (userDoc == null) {
    //       return;
    //     } else {
    //       _email = userDoc.get('email');
    //       _name = userDoc.get('name');
    //       _phNo = userDoc.get('phNo');
    //       address = userDoc.get('shipping-address');
    //       _pImage = userDoc.get('profilePic');

    //       _addressTextController.text = userDoc.get('shipping-address');
    //     }
    //   } catch (error) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     Utils.flushBarErrorMessage('$error', context);
    //   } finally {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   }
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Address'),
          content: TextField(
            controller: _addressTextController,
            maxLines: 5,
            decoration: const InputDecoration(hintText: "Your address"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String _uid = user!.uid;
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_uid)
                      .update({
                    'shipping-address': _addressTextController.text,
                  });

                  Navigator.pop(context);
                  setState(() {
                    address = _addressTextController.text;
                  });
                } catch (err) {
                  Utils.flushBarErrorMessage(err.toString(), context);
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(color: AppColor.primaryColor),
              ),
            ),
          ],
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
        title: Text(
          'Profile ',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
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
                    top: 20.0,
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
          bottomLeft: Radius.circular(100.0),
          bottomRight: Radius.circular(100.0),
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
            text: '${_name == null ? 'Name' : _name!} \n',
            style: GoogleFonts.getFont(
              "Gothic A1",
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor,
              ),
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
              TextSpan(
                text: _phNo == null ? 'PhNo' : _phNo!,
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
          onPressed: () async {
            GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
            if (googleUser != null) {
              // Fetch user details from Google Sign-In
              setState(() {
                _name = googleUser.displayName;
                _email = googleUser.email;
                _pImage = googleUser.photoUrl ?? defaultProfile;
                // Assuming you don't have a phone number for Google sign-in
                _phNo = 'Default Phone Number';
              });

              // Navigate to EditProfile with the fetched details
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditProfile(
                  profilePic: _pImage ?? defaultProfile,
                  name: _name ?? 'Default Name',
                  email: _email ?? 'Default Email',
                  phNo: _phNo ?? 'Default Phone Number',
                );
              }));
            } else {
              // Handle the case where Google Sign-In failed or user is not signed in with Google
              if (_name != null && _email != null && _phNo != null) {
                // Navigate to EditProfile with existing user details
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfile(
                    profilePic: _pImage ?? defaultProfile,
                    name: _name ?? 'Default Name',
                    email: _email ?? 'Default Email',
                    phNo: _phNo ?? 'Default Phone Number',
                  );
                }));
              } else {
                Utils.flushBarErrorMessage('Error occurred', context);
                // Handle the case where one or more variables are null.
              }
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
                    _showAddressDialog();
                  },
                  tColor: const Color(0xffCDFF9D),
                  bColor: const Color(0xff40C269),
                  icon: Icons.local_shipping_outlined,
                  trIcon: Icons.arrow_forward_ios,
                  title: address == null ? 'user' : address!,
                ),
                const Divider(),
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
                    ontap: () {
                      Navigator.pushNamed(context, RoutesName.paymentScreen);
                    },
                    tColor: const Color(0xff9E93F4),
                    bColor: const Color(0xff7465EC),
                    icon: Icons.wallet_outlined,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Payment'),
                const Divider(),
                ProfileWidgets(
                  ontap: () async {
                    authInstance.signOut();
                    Utils.toastMessage('SuccessFully LogOut');
                    await Navigator.pushNamed(context, RoutesName.loginscreen);
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
