import 'package:flutter/material.dart';

import '../../../res/components/colors.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.grayColor // Color of the dotted line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0; // Thickness of the line

    // Define the pattern for the dotted line
    final dashWidth = 5.0; // Width of each dash
    final dashSpace = 5.0; // Space between dashes

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