// ignore_for_file: use_build_context_synchronously

import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/consts/firebase_const.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:flutter/material.dart';
import 'widget/drawer_options.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 120.0,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColor.buttonTxColor,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.buttonTxColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          DrawerOptions(
            icon: Icons.history,
            title: 'About Us',
            onpress: () {
              Navigator.pushNamed(
                context,
                RoutesName.aboutusscreen,
              );
            },
          ),
          const Divider(),
          DrawerOptions(
            icon: Icons.star_rate_rounded,
            title: 'FAQs',
            onpress: () {
              Navigator.pushNamed(
                context,
                RoutesName.faqsscreen,
              );
            },
          ),
          const Divider(),
          DrawerOptions(
            icon: Icons.my_library_books_outlined,
            title: 'Terms & Conditions',
            onpress: () {
              Navigator.pushNamed(
                context,
                RoutesName.termsandconditionscreen,
              );
            },
          ),
          const Divider(),
          DrawerOptions(
            icon: Icons.help_outline,
            title: 'Help Center',
            onpress: () {
              Navigator.pushNamed(
                context,
                RoutesName.helpscreen,
              );
            },
          ),
          const Divider(),
          DrawerOptions(
            icon: Icons.phone,
            title: 'Contact Us',
            onpress: () {
              Navigator.pushNamed(
                context,
                RoutesName.contactusscreen,
              );
            },
          ),
          const Divider(),
          DrawerOptions(
            icon: Icons.logout_rounded,
            title: 'Logout',
            onpress: () async {
              await authInstance.signOut();
              Utils.snackBar('Successfully LogOut', context);

              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesName.loginscreen, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
