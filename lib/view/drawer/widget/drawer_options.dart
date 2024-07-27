import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';

class DrawerOptions extends StatelessWidget {
  const DrawerOptions(
      {super.key,
      required this.icon,
      required this.title,
      required this.onpress});
  final IconData icon;
  final String title;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListTile(
        onTap: onpress,
        leading: Icon(
          icon,
          size: 20,
          color: AppColor.fontColor,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'CenturyGothic',
            fontWeight: FontWeight.w600,
            color: AppColor.fontColor,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColor.primaryColor,
          size: 15.0,
        ),
      ),
    );
  }
}
