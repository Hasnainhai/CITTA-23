import 'package:flutter/material.dart';

import '../../../res/components/colors.dart';

class ProfileWidgets extends StatelessWidget {
  const ProfileWidgets({
    super.key,
    required this.tColor,
    required this.bColor,
    required this.icon,
    required this.trIcon,
    required this.title,
  });
  final Color tColor;
  final Color bColor;
  final IconData icon;
  final IconData trIcon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [tColor, tColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 1.0],
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColor.whiteColor,
          ),
        ),
      ),
      titleAlignment: ListTileTitleAlignment.threeLine,
      title: Text(title),
      trailing: Icon(trIcon),
    );
  }
}