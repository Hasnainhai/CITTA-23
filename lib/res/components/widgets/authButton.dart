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
      width: 60.0,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: color),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            img,
          ),
        ),
      ),
    );
  }
}
