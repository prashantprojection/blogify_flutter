import 'package:flutter/material.dart';

class GradientOverlay extends StatelessWidget {
  final Alignment begin;
  final Alignment end;
  final List<Color>? colors;
  final List<double>? stops;

  const GradientOverlay({
    Key? key,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.colors,
    this.stops,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors ??
              [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
              ],
          stops: stops,
        ),
      ),
    );
  }

  // Factory constructor for common dark overlay
  factory GradientOverlay.dark() {
    return GradientOverlay(
      colors: [
        Colors.black.withOpacity(0.6),
        Colors.black.withOpacity(0.8),
      ],
    );
  }

  // Factory constructor for common light overlay
  factory GradientOverlay.light() {
    return GradientOverlay(
      colors: [
        Colors.white.withOpacity(0.6),
        Colors.white.withOpacity(0.8),
      ],
    );
  }

  // Factory constructor for common transparent to dark overlay
  factory GradientOverlay.transparentToDark() {
    return GradientOverlay(
      colors: [
        Colors.transparent,
        Colors.black.withOpacity(0.6),
      ],
    );
  }
}
