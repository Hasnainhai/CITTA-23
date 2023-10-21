import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox( {
    super.key,
  });
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool isChecked = false;

  void onChanged() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          border: Border.all(
            color: isChecked ? AppColor.primaryColor : AppColor.primaryColor,
          ),
        ),
        child: isChecked
            ? Center(
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  color: isChecked ? AppColor.primaryColor : Colors.transparent,
                ),
              )
            : null,
      ),
    );
  }
}
