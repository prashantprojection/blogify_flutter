import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';

class SectionHeader extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final CrossAxisAlignment alignment;
  final double? fontSize;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.alignment = CrossAxisAlignment.start,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.typography.title.copyWith(
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
            style: theme.typography.body.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}
