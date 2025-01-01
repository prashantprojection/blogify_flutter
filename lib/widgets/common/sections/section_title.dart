import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
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
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.titleStyle,
    this.subtitleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      AppTheme.headingMedium.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 8),
                  Text(
                    subtitle!,
                    style: subtitleStyle ??
                        AppTheme.bodyLarge.copyWith(
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
        color: iconColor ?? AppTheme.primaryColor,
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
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
