import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({super.key,required this.title});

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
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
        ),
        FlutterSwitch(
          value: switchValue,
          onToggle: (value) {
            setState(() {
              switchValue = value;
            });
          },
          width: 50.0, // Adjust the width to make it square
          height: 26.0, // Adjust the height to make it square
          toggleSize: 28.0, // Adjust the toggle size
          activeColor: Colors.pink,
          inactiveColor: Colors.grey,
          borderRadius: 0.0,
        ),
      ],
    );
  }
}
