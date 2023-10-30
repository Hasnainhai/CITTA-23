import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.color,
    required this.img,
    super.key,
  });
  final String img;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              img,
            ),
          ),
          // const SizedBox(width: 20.0),
          const Text(
            'Signup with Google',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
