import 'package:flutter/material.dart';
import 'dart:math' as math;

class TileRevealPainter extends CustomPainter {
  final double mouseX;
  final double mouseY;
  final Color color;

  TileRevealPainter({
    required this.mouseX,
    required this.mouseY,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(mouseX, mouseY);
    final radius = 60.0;

    // Draw edges that intersect with the cursor's radius
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 6);

    // Function to calculate opacity based on distance
    double getOpacity(double distance) {
      const maxOpacity = 0.8;
      const fadeStart = 0.7;

      if (distance > radius) return 0.0;
      if (distance < radius * fadeStart) return maxOpacity;

      return maxOpacity *
          (1.0 - (distance - radius * fadeStart) / (radius * (1 - fadeStart)));
    }

    // Define the edges as line segments
    final edges = [
      (Offset(0, 0), Offset(size.width, 0)), // Top
      (Offset(size.width, 0), Offset(size.width, size.height)), // Right
      (Offset(0, size.height), Offset(size.width, size.height)), // Bottom
      (Offset(0, 0), Offset(0, size.height)), // Left
    ];

    // Draw edges that intersect with the cursor's radius
    for (final edge in edges) {
      final start = edge.$1;
      final end = edge.$2;
      final edgeVector = end - start;
      final length = edgeVector.distance;

      if (length == 0) continue;

      final direction = edgeVector / length;
      final cursorVector = center - start;
      final projection =
          (cursorVector.dx * direction.dx + cursorVector.dy * direction.dy)
              .clamp(0.0, length);
      final closestPoint = start + direction * projection;
      final distance = (center - closestPoint).distance;

      if (distance <= radius) {
        final visibleRadius = math.sqrt(radius * radius - distance * distance);
        final visibleStart = math.max(0.0, projection - visibleRadius);
        final visibleEnd = math.min(length, projection + visibleRadius);

        if (visibleStart < visibleEnd) {
          final segmentStart = start + direction * visibleStart;
          final segmentEnd = start + direction * visibleEnd;

          final opacity = getOpacity(distance);
          paint.color = color.withOpacity(opacity * 0.7);
          glowPaint.color = color.withOpacity(opacity);

          canvas.drawLine(segmentStart, segmentEnd, paint);
          canvas.drawLine(segmentStart, segmentEnd, glowPaint);
        }
      }
    }

    // Draw gradient fill only if cursor is inside the element
    if (mouseX >= 0 &&
        mouseX <= size.width &&
        mouseY >= 0 &&
        mouseY <= size.height) {
      final gradientPaint = Paint()
        ..shader = RadialGradient(
          center: Alignment(
            (mouseX / size.width) * 2 - 1,
            (mouseY / size.height) * 2 - 1,
          ),
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
          radius: 7,
        ).createShader(Offset.zero & size);

      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        gradientPaint,
      );
    }
  }

  @override
  bool shouldRepaint(TileRevealPainter oldDelegate) {
    return mouseX != oldDelegate.mouseX || mouseY != oldDelegate.mouseY;
  }
}
