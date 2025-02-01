import 'package:flutter/material.dart';

class RoundedCornerBorderPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double radius;

  RoundedCornerBorderPainter({
    required this.color,
    this.thickness = 6, // Default thickness
    this.radius = 12, // Default corner radius
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded edges for smoother curves

    final Path path = Path()
      ..moveTo(0, size.height * 0.7) // Vertical line
      ..lineTo(0, radius) // Stops before curve starts
      ..quadraticBezierTo(0, 0, radius, 0) // Curve at the corner
      ..lineTo(size.width * 0.7, 0); // Horizontal line

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RoundedCornerBorderPainter oldDelegate) => oldDelegate.color != color || oldDelegate.thickness != thickness || oldDelegate.radius != radius;
}
