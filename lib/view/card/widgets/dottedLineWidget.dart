// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../res/components/colors.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.grayColor // Color of the dotted line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Define the pattern for the dotted line
    const dashWidth = 5.0;
    const dashSpace = 5.0;

    // Calculate the number of dashes needed
    final numberOfDashes = size.width / (dashWidth + dashSpace);

    // Draw the dotted line
    for (var i = 0; i < numberOfDashes; i++) {
      final startX = i * (dashWidth + dashSpace);
      final endX = startX + dashWidth;
      canvas.drawLine(Offset(startX, 0), Offset(endX, 0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
