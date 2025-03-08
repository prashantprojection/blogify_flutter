import 'package:flutter/material.dart';

class SettingsSection {
  final String title;
  final IconData icon;
  final bool isProfile;
  final List<Widget> children;
  final Widget? badge;

  const SettingsSection({
    required this.title,
    required this.icon,
    this.isProfile = false,
    required this.children,
    this.badge,
  });
}

enum BackgroundEffect {
  none,
  canvasReveal,
  warpedGrid,
  animatedPattern;

  String get displayName {
    switch (this) {
      case BackgroundEffect.none:
        return 'No Effect';
      case BackgroundEffect.canvasReveal:
        return 'Canvas Reveal';
      case BackgroundEffect.warpedGrid:
        return 'Warped Grid';
      case BackgroundEffect.animatedPattern:
        return 'Animated Pattern';
    }
  }

  IconData get icon {
    switch (this) {
      case BackgroundEffect.none:
        return Icons.format_color_reset_outlined;
      case BackgroundEffect.canvasReveal:
        return Icons.blur_on_outlined;
      case BackgroundEffect.warpedGrid:
        return Icons.grid_goldenratio;
      case BackgroundEffect.animatedPattern:
        return Icons.pattern;
    }
  }
}
