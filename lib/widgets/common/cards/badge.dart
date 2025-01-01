import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';

class Badge extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const Badge({
    Key? key,
    required this.text,
    required this.color,
    this.textColor,
    this.fontSize,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
      ),
      child: Text(
        text,
        style: AppTheme.bodySmall.copyWith(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
