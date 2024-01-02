// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';
import '../../../res/components/widgets/verticalSpacing.dart';
import '../../../routes/routes_name.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 150,
          color: const Color(0xffEEEEEE),
          child: Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/EmptyCart.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const VerticalSpeacing(14.0),
        const Text(
          'Empty Cart',
          style: TextStyle(
              fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        const VerticalSpeacing(14.0),
        SizedBox(
          width: 100.0,
          height: 30.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              shape: const RoundedRectangleBorder(),
            ),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.dashboardScreen);
            },
            child: const Text(
              'Adding',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
