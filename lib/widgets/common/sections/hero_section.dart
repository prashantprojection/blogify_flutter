import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/buttons/custom_button.dart';

class HeroSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final CrossAxisAlignment? alignment;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final double? descriptionFontSize;

  const HeroSection({
    Key? key,
    required this.title,
    this.subtitle,
    this.description,
    this.actions,
    this.padding,
    this.decoration,
    this.alignment,
    this.titleFontSize,
    this.subtitleFontSize,
    this.descriptionFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.symmetric(vertical: 150, horizontal: 45),
      decoration: decoration ?? AppTheme.heroBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.headingLarge.copyWith(
              color: Colors.white,
              fontSize: titleFontSize ?? 64,
              height: 1.1,
            ),
            textAlign: TextAlign.start,
          ),
          if (subtitle != null) ...[
            SizedBox(height: 24),
            Text(
              subtitle!,
              style: AppTheme.bodyLarge.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: subtitleFontSize ?? 24,
              ),
              textAlign: TextAlign.start,
            ),
          ],
          if (description != null) ...[
            SizedBox(height: 16),
            Text(
              description!,
              style: AppTheme.bodyLarge.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: descriptionFontSize ?? 20,
              ),
              textAlign: TextAlign.start,
            ),
          ],
          if (actions != null) ...[
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }

  // Factory constructor for common hero section with primary and secondary actions
  factory HeroSection.withActions({
    required String title,
    String? subtitle,
    String? description,
    required String primaryActionLabel,
    required VoidCallback onPrimaryAction,
    String? secondaryActionLabel,
    VoidCallback? onSecondaryAction,
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
    CrossAxisAlignment? alignment,
  }) {
    return HeroSection(
      title: title,
      subtitle: subtitle,
      description: description,
      padding: padding,
      decoration: decoration,
      alignment: alignment,
      actions: [
        CustomButton(
          label: primaryActionLabel,
          onPressed: onPrimaryAction,
          backgroundColor: Colors.white,
          foregroundColor: AppTheme.primaryColor,
        ),
        if (secondaryActionLabel != null && onSecondaryAction != null) ...[
          SizedBox(width: 24),
          CustomButton(
            label: secondaryActionLabel,
            onPressed: onSecondaryAction,
            type: CustomButtonType.outlined,
            foregroundColor: Colors.white,
          ),
        ],
      ],
    );
  }
}
