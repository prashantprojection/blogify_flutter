import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final CrossAxisAlignment alignment;
  final double? fontSize;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.alignment = CrossAxisAlignment.start,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.headingMedium.copyWith(
                fontSize: fontSize ?? 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: 8),
          Text(
            subtitle!,
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}
