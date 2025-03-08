import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math' as math;

class AuroraBackground extends StatelessWidget {
  final List<Color> colors;
  final double blur;
  final List<Alignment> positions;

  const AuroraBackground({
    super.key,
    required this.colors,
    this.blur = 100,
    this.positions = const [
      Alignment(-0.8, -0.8),
      Alignment(0.8, -0.5),
      Alignment(-0.5, 0.8),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.first.withOpacity(0.05),
      ),
      child: Stack(
        children: [
          ...List.generate(
            colors.length,
            (index) => Positioned.fill(
              child: Transform.rotate(
                angle: index * math.pi / colors.length,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: positions[index % positions.length],
                      radius: 1.1,
                      colors: [
                        colors[index].withOpacity(0.3),
                        colors[index].withOpacity(0.0),
                      ],
                      stops: const [0.0, 0.7],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: kIsWeb ? blur * 0.5 : blur,
                  sigmaY: kIsWeb ? blur * 0.5 : blur,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Factory constructor for theme-based aurora
  factory AuroraBackground.fromTheme({
    required Color primary,
    required Color secondary,
    required Color accent,
    double blur = 100,
  }) {
    return AuroraBackground(
      colors: [
        primary,
        secondary,
        accent,
      ],
      blur: blur,
      positions: const [
        Alignment(-0.8, -0.8),
        Alignment(0.8, -0.5),
        Alignment(-0.5, 0.8),
      ],
    );
  }
}
