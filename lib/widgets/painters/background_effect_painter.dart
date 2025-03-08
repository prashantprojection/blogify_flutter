import 'package:flutter/material.dart';
import 'dart:math' as math;

class CanvasRevealPainter extends CustomPainter {
  final double mouseX;
  final double mouseY;
  final Color color;
  final List<Rect> uiElements;

  CanvasRevealPainter({
    required this.mouseX,
    required this.mouseY,
    required this.color,
    required this.uiElements,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(mouseX, mouseY);
    final radius = 60.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 6);

    double getOpacity(double distance) {
      const maxOpacity = 0.8;
      const fadeStart = 0.7;

      if (distance > radius) return 0.0;
      if (distance < radius * fadeStart) return maxOpacity;

      return maxOpacity *
          (1.0 - (distance - radius * fadeStart) / (radius * (1 - fadeStart)));
    }

    for (final rect in uiElements) {
      final edges = [
        (Offset(rect.left, rect.top), Offset(rect.right, rect.top)), // Top
        (
          Offset(rect.right, rect.top),
          Offset(rect.right, rect.bottom)
        ), // Right
        (
          Offset(rect.left, rect.bottom),
          Offset(rect.right, rect.bottom)
        ), // Bottom
        (Offset(rect.left, rect.top), Offset(rect.left, rect.bottom)), // Left
      ];

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
          final visibleRadius =
              math.sqrt(radius * radius - distance * distance);
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

      if (rect.contains(center)) {
        final gradientPaint = Paint()
          ..shader = RadialGradient(
            center: Alignment(
              ((mouseX - rect.left) / rect.width) * 2 - 1,
              ((mouseY - rect.top) / rect.height) * 2 - 1,
            ),
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
            radius: 7.0,
          ).createShader(rect);

        canvas.drawRect(rect, gradientPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CanvasRevealPainter oldDelegate) {
    return mouseX != oldDelegate.mouseX ||
        mouseY != oldDelegate.mouseY ||
        uiElements != oldDelegate.uiElements;
  }
}

class WarpedGridPainter extends CustomPainter {
  final double animation;
  final Color color;
  final List<Offset> gridPoints;

  WarpedGridPainter({
    required this.animation,
    required this.color,
    required this.gridPoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final cellWidth = size.width / 20;
    final cellHeight = size.height / 20;

    for (var point in gridPoints) {
      final x = point.dx * cellWidth;
      final y = point.dy * cellHeight;

      final warpX = x +
          math.sin((y / size.height) * math.pi * 2 + animation * math.pi * 2) *
              20;
      final warpY = y +
          math.cos((x / size.width) * math.pi * 2 + animation * math.pi * 2) *
              20;

      canvas.drawCircle(Offset(warpX, warpY), 2, paint);

      if (point.dx < 19) {
        final nextX = (point.dx + 1) * cellWidth;
        final nextY = point.dy * cellHeight;
        final nextWarpX = nextX +
            math.sin((nextY / size.height) * math.pi * 2 +
                    animation * math.pi * 2) *
                20;
        final nextWarpY = nextY +
            math.cos((nextX / size.width) * math.pi * 2 +
                    animation * math.pi * 2) *
                20;
        canvas.drawLine(
            Offset(warpX, warpY), Offset(nextWarpX, nextWarpY), paint);
      }

      if (point.dy < 19) {
        final nextX = point.dx * cellWidth;
        final nextY = (point.dy + 1) * cellHeight;
        final nextWarpX = nextX +
            math.sin((nextY / size.height) * math.pi * 2 +
                    animation * math.pi * 2) *
                20;
        final nextWarpY = nextY +
            math.cos((nextX / size.width) * math.pi * 2 +
                    animation * math.pi * 2) *
                20;
        canvas.drawLine(
            Offset(warpX, warpY), Offset(nextWarpX, nextWarpY), paint);
      }
    }
  }

  @override
  bool shouldRepaint(WarpedGridPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

class AnimatedPatternPainter extends CustomPainter {
  final double animation;
  final Color color;

  AnimatedPatternPainter({
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const spacing = 40.0;
    final rows = (size.height / spacing).ceil();
    final cols = (size.width / spacing).ceil();

    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < cols; j++) {
        final x = j * spacing;
        final y = i * spacing;
        final offset = math.sin((x + y) / 100 + animation * math.pi * 2) * 10;

        final path = Path();
        path.moveTo(x, y + offset);
        path.lineTo(x + spacing / 2, y + spacing / 2 + offset);
        path.lineTo(x + spacing, y + offset);

        canvas.drawPath(path, paint);

        canvas.drawCircle(Offset(x, y + offset), 3, paint);
        canvas.drawCircle(Offset(x + spacing, y + offset), 3, paint);
      }
    }
  }

  @override
  bool shouldRepaint(AnimatedPatternPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
