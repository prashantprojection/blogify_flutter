import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/settings_controller.dart';

class NeonBorderEffect extends ConsumerStatefulWidget {
  final double borderRadius;
  final EdgeInsets margin;

  const NeonBorderEffect({
    Key? key,
    required this.borderRadius,
    required this.margin,
  }) : super(key: key);

  @override
  ConsumerState<NeonBorderEffect> createState() => _NeonBorderEffectState();
}

class _NeonBorderEffectState extends ConsumerState<NeonBorderEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _baseSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateSpeed(double speed) {
    if (_baseSpeed != speed) {
      _baseSpeed = speed;
      // Stop the animation
      _controller.stop();
      // Update the duration - faster speeds will have shorter durations
      _controller.duration = Duration(milliseconds: (1500 / speed).round());
      // Get the current value
      final currentValue = _controller.value;
      // Reset and repeat with new duration
      _controller.reset();
      _controller.value = currentValue;
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    if (!settings.neonEffectEnabled) {
      return const SizedBox.shrink();
    }

    // Update speed when settings change
    _updateSpeed(settings.neonEffectSpeed);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: NeonBorderPainter(
            progress: _controller.value,
            borderRadius: widget.borderRadius,
            margin: widget.margin,
          ),
        );
      },
    );
  }
}

class NeonBorderPainter extends CustomPainter {
  final double progress;
  final double borderRadius;
  final EdgeInsets margin;

  NeonBorderPainter({
    required this.progress,
    required this.borderRadius,
    required this.margin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      margin.left,
      margin.top,
      size.width - margin.horizontal,
      size.height - margin.vertical,
    );

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        rect,
        Radius.circular(borderRadius),
      ));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1.5)
      ..shader = LinearGradient(
        colors: [
          Colors.blue.withOpacity(1),
          Colors.purple.withOpacity(1),
          Colors.blue.withOpacity(1),
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final pathMetrics = path.computeMetrics().toList();

    for (final metric in pathMetrics) {
      final length = metric.length;
      final start = (length * progress) % length;
      final end = (start + length * 0.5) % length;

      if (end > start) {
        canvas.drawPath(
          metric.extractPath(start, end),
          paint,
        );
      } else {
        canvas.drawPath(
          metric.extractPath(start, length),
          paint,
        );
        canvas.drawPath(
          metric.extractPath(0, end),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(NeonBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
