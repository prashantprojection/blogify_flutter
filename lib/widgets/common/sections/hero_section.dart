import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:blogify_flutter/widgets/common/buttons/custom_button.dart';
import 'package:blogify_flutter/widgets/common/backgrounds/aurora_background.dart';

class HeroSection extends ConsumerWidget {
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
    super.key,
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
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Stack(
      children: [
        // Aurora Background
        Positioned.fill(
          child: AuroraBackground.fromTheme(
            primary: theme.colors.primary,
            secondary: theme.colors.secondary,
            accent: theme.colors.accent,
            blur: kIsWeb ? 40 : 80,
          ),
        ),
        // Content
        Container(
          width: double.infinity,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 150, horizontal: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.title.copyWith(
                  color: theme.colors.textPrimary,
                  fontSize: titleFontSize ?? 64,
                  height: 1.1,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 24),
                Text(
                  subtitle!,
                  style: theme.typography.headline.copyWith(
                    color: theme.colors.textPrimary,
                    fontSize: subtitleFontSize ?? 24,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
              if (description != null) ...[
                const SizedBox(height: 16),
                Text(
                  description!,
                  style: theme.typography.headline.copyWith(
                    color: theme.colors.textPrimary,
                    fontSize: descriptionFontSize ?? 20,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
              if (actions != null) ...[
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: actions!,
                ),
              ],
            ],
          ),
        ),
      ],
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
        ),
        if (secondaryActionLabel != null && onSecondaryAction != null) ...[
          const SizedBox(width: 24),
          CustomButton(
            label: secondaryActionLabel,
            onPressed: onSecondaryAction,
            type: CustomButtonType.outlined,
          ),
        ],
      ],
    );
  }
}
