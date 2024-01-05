import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({super.key, required this.title});
  final String title;
  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          // ignore: prefer_const_constructors
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColor.fontColor,
          ),
        ),
        FlutterSwitch(
          value: switchValue,
          onToggle: (value) {
            setState(() {
              switchValue = value;
            });
          },
          width: 50.0,
          height: 26.0,
          toggleSize: 28.0,
          activeColor: Colors.pink,
          inactiveColor: Colors.grey,
          borderRadius: 0.0,
        ),
      ],
    );
  }
}
