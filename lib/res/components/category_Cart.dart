// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';

class CategoryCart extends StatefulWidget {
  const CategoryCart({
    super.key,
    required this.text,
  });

  final String text;

  @override
  _CategoryCartState createState() => _CategoryCartState();
}

class _CategoryCartState extends State<CategoryCart> {
  final Color _backgroundColor = AppColor.bgColor;
  final Color _textColor = AppColor.primaryColor;
  void checkUiType() {}

  @override
  void initState() {
    checkUiType();

    super.initState();
  }

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

    return GestureDetector(
      onTap: () {
        // Provider.of<HomeRepositoryProvider>(context, listen: false)
        //     .categoryFilter(
        //   widget.text,
        // );
        // Provider.of<HomeUiSwithchRepository>(context, listen: false)
        //     .switchToType(
        //   UIType.CategoriesSection,
        // );
        // setState(() {
        //   _backgroundColor = (_backgroundColor == AppColor.boxColor)
        //       ? AppColor.primaryColor
        //       : AppColor.boxColor;
        //   _textColor = (_textColor == AppColor.whiteColor)
        //       ? AppColor.textColor1
        //       : AppColor.whiteColor;
        // });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IntrinsicWidth(
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: _backgroundColor,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: _textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
