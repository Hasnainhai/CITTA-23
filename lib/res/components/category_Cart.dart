// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class CategoryCart extends StatefulWidget {
  const CategoryCart({
    super.key,
    required this.text,
    required this.textColor,
    required this.containerColor,
  });

  final String text;
  final Color textColor;
  final Color containerColor;
  @override
  _CategoryCartState createState() => _CategoryCartState();
}

class _CategoryCartState extends State<CategoryCart> {
  @override
  Widget build(BuildContext context) {
    // final currentUIType =
    //     Provider.of<HomeUiSwithchRepository>(context, listen: false)
    //         .selectedType;

    // if (currentUIType == UIType.DefaultSection) {
    //   setState(() {
    //     _backgroundColor = AppColor.boxColor;
    //     _textColor = AppColor.textColor1;
    //   });
    // }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IntrinsicWidth(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: widget.containerColor,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: widget.textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
