import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';

class Badge extends ConsumerWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const Badge({
    super.key,
    required this.text,
    required this.color,
    this.textColor,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
      ),
      child: Text(
        text,
        style: theme.typography.body.copyWith(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
