import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';

class SectionTitle extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Text(
                  title,
                  style: titleStyle ??
                      theme.typography.title.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 8),
                  Text(
                    subtitle!,
                    style: subtitleStyle ??
                        theme.typography.body.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: 16),
            trailing!,
          ],
        ],
      ),
    );
  }

  // Factory constructor for section with icon
  factory SectionTitle.withIcon({
    required String title,
    String? subtitle,
    required IconData icon,
    Color? iconColor,
    double? iconSize,
    Widget? trailing,
    EdgeInsetsGeometry? padding,
  }) {
    return SectionTitle(
      title: title,
      subtitle: subtitle,
      padding: padding,
      leading: Icon(
        icon,
        color: iconColor ?? Colors.white,
        size: iconSize ?? 32,
      ),
      trailing: trailing,
    );
  }

  // Factory constructor for section with action button
  factory SectionTitle.withAction({
    required String title,
    String? subtitle,
    required String actionLabel,
    required VoidCallback onAction,
    EdgeInsetsGeometry? padding,
  }) {
    return SectionTitle(
      title: title,
      subtitle: subtitle,
      padding: padding,
      trailing: TextButton(
        onPressed: onAction,
        child: Text(
          actionLabel,
        ),
      ),
    );
  }
}
