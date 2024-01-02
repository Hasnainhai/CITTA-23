// ignore_for_file: file_names

import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onpress;
  const RoundedButton({
    super.key,
    required this.title,
    required this.onpress,
    this.loading = false,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          color: AppColor.buttonBgColor,
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: AppColor.whiteColor,
                )
              : Text(
                  title,
                  style: const TextStyle(
                    color: AppColor.buttonTxColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
