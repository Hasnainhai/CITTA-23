import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration:
              InputDecoration(filled: true, fillColor: Color(0xffEEEEEE)),
        )
      ],
    );
  }
}
