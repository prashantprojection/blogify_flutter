import 'dart:ui';
import 'package:flutter/material.dart';

class ThemeColors {
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;
  final Color surfaceTint;

  // State colors
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
  final Color surfaceDim;
  final Color surfaceBright;

  // State layer colors
  final Color hoverColor;
  final Color focusColor;
  final Color highlightColor;
  final Color splashColor;

  // State opacities
  final double hoverOpacity;
  final double focusOpacity;
  final double pressedOpacity;
  final double draggedOpacity;
  final double disabledOpacity;

  const ThemeColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.surfaceTint,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.hoverColor,
    required this.focusColor,
    required this.highlightColor,
    required this.splashColor,
    this.hoverOpacity = 0.08,
    this.focusOpacity = 0.12,
    this.pressedOpacity = 0.12,
    this.draggedOpacity = 0.16,
    this.disabledOpacity = 0.38,
  });

  // Helper methods for state colors
  Color stateLayerColor(Color color, double opacity) =>
      color.withAlpha((opacity * 255).round());

  // Get hover state color
  Color getHoverColor(Color baseColor) =>
      stateLayerColor(baseColor, hoverOpacity);

  // Get focus state color
  Color getFocusColor(Color baseColor) =>
      stateLayerColor(baseColor, focusOpacity);

  // Get pressed state color
  Color getPressedColor(Color baseColor) =>
      stateLayerColor(baseColor, pressedOpacity);

  // Get dragged state color
  Color getDraggedColor(Color baseColor) =>
      stateLayerColor(baseColor, draggedOpacity);

  // Get disabled state color
  Color getDisabledColor(Color baseColor) =>
      stateLayerColor(baseColor, disabledOpacity);

  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
      surfaceTint: surfaceTint,
    );
  }
}

class ThemeElevation {
  // Default elevation values in logical pixels
  final double none;
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;

  const ThemeElevation({
    this.none = 0.0,
    this.extraSmall = 1.0,
    this.small = 2.0,
    this.medium = 4.0,
    this.large = 8.0,
    this.extraLarge = 16.0,
  });

  /// Creates a copy with new values
  ThemeElevation copyWith({
    double? none,
    double? extraSmall,
    double? small,
    double? medium,
    double? large,
    double? extraLarge,
  }) {
    return ThemeElevation(
      none: none ?? this.none,
      extraSmall: extraSmall ?? this.extraSmall,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
    );
  }
}

class ThemeTypography {
  // Font families for different text purposes
  final String primaryFont; // Main content font
  final String displayFont; // Headers and hero text
  final String accentFont; // Special emphasis text
  final String monospaceFont; // Code blocks, numbers, technical content
  final String handwritingFont; // Personal/casual content
  final Color? defaultColor;

  // Core text styles
  final TextStyle display; // Hero sections, large headers (48+)
  final TextStyle headline; // Major section headers (32-40)
  final TextStyle title; // Content titles, card headers (24-28)
  final TextStyle subtitle; // Secondary titles, descriptions (18-20)
  final TextStyle body; // Main content text (16)
  final TextStyle label; // Buttons, form fields (14)
  final TextStyle caption; // Helper text, timestamps (12)
  final TextStyle code; // Code blocks, technical content
  final TextStyle quote; // Blockquotes, testimonials
  final TextStyle handwriting; // Personal notes, signatures

  const ThemeTypography({
    required this.primaryFont,
    required this.displayFont,
    required this.accentFont,
    required this.monospaceFont,
    required this.handwritingFont,
    this.defaultColor,
    required this.display,
    required this.headline,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.label,
    required this.caption,
    required this.code,
    required this.quote,
    required this.handwriting,
  });

  /// Creates a copy with new values
  ThemeTypography copyWith({
    String? primaryFont,
    String? displayFont,
    String? accentFont,
    String? monospaceFont,
    String? handwritingFont,
    Color? defaultColor,
    TextStyle? display,
    TextStyle? headline,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? body,
    TextStyle? label,
    TextStyle? caption,
    TextStyle? code,
    TextStyle? quote,
    TextStyle? handwriting,
  }) {
    return ThemeTypography(
      primaryFont: primaryFont ?? this.primaryFont,
      displayFont: displayFont ?? this.displayFont,
      accentFont: accentFont ?? this.accentFont,
      monospaceFont: monospaceFont ?? this.monospaceFont,
      handwritingFont: handwritingFont ?? this.handwritingFont,
      defaultColor: defaultColor ?? this.defaultColor,
      display: display ?? this.display,
      headline: headline ?? this.headline,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      body: body ?? this.body,
      label: label ?? this.label,
      caption: caption ?? this.caption,
      code: code ?? this.code,
      quote: quote ?? this.quote,
      handwriting: handwriting ?? this.handwriting,
    );
  }

  /// Updates fonts using Google Fonts
  ThemeTypography withFonts({
    String? primaryFont,
    String? displayFont,
    String? accentFont,
    String? monospaceFont,
    String? handwritingFont,
  }) {
    return copyWith(
      primaryFont: primaryFont ?? this.primaryFont,
      displayFont: displayFont ?? this.displayFont,
      accentFont: accentFont ?? this.accentFont,
      monospaceFont: monospaceFont ?? this.monospaceFont,
      handwritingFont: handwritingFont ?? this.handwritingFont,
      body: primaryFont != null ? body.copyWith(fontFamily: primaryFont) : body,
      label:
          primaryFont != null ? label.copyWith(fontFamily: primaryFont) : label,
      caption: primaryFont != null
          ? caption.copyWith(fontFamily: primaryFont)
          : caption,
      display: displayFont != null
          ? display.copyWith(fontFamily: displayFont)
          : display,
      headline: displayFont != null
          ? headline.copyWith(fontFamily: displayFont)
          : headline,
      title:
          accentFont != null ? title.copyWith(fontFamily: accentFont) : title,
      subtitle: accentFont != null
          ? subtitle.copyWith(fontFamily: accentFont)
          : subtitle,
      code: monospaceFont != null
          ? code.copyWith(fontFamily: monospaceFont)
          : code,
      quote:
          accentFont != null ? quote.copyWith(fontFamily: accentFont) : quote,
      handwriting: handwritingFont != null
          ? handwriting.copyWith(fontFamily: handwritingFont)
          : handwriting,
    );
  }

  /// Updates style properties for all text styles
  ThemeTypography withStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? lineHeight,
    TextDecoration? decoration,
  }) {
    return copyWith(
      display: display.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      headline: headline.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      title: title.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      subtitle: subtitle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      body: body.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      label: label.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      caption: caption.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      code: code.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      quote: quote.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      handwriting: handwriting.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
    );
  }

  /// Updates style for specific text styles
  ThemeTypography withStyleFor({
    TextStyle? display,
    TextStyle? headline,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? body,
    TextStyle? label,
    TextStyle? caption,
    TextStyle? code,
    TextStyle? quote,
    TextStyle? handwriting,
  }) {
    return copyWith(
      display: display != null ? this.display.merge(display) : null,
      headline: headline != null ? this.headline.merge(headline) : null,
      title: title != null ? this.title.merge(title) : null,
      subtitle: subtitle != null ? this.subtitle.merge(subtitle) : null,
      body: body != null ? this.body.merge(body) : null,
      label: label != null ? this.label.merge(label) : null,
      caption: caption != null ? this.caption.merge(caption) : null,
      code: code != null ? this.code.merge(code) : null,
      quote: quote != null ? this.quote.merge(quote) : null,
      handwriting:
          handwriting != null ? this.handwriting.merge(handwriting) : null,
    );
  }

  TextTheme toTextTheme() => TextTheme(
        displayMedium: display,
        headlineMedium: headline,
        titleMedium: title,
        titleSmall: subtitle,
        bodyMedium: body,
        labelMedium: label,
        bodySmall: caption,
      );
}

class Spacing {
  final double zero;
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double maximum;

  const Spacing({
    this.zero = 0,
    this.extraSmall = 4,
    this.small = 8,
    this.medium = 12,
    this.large = 16,
    this.extraLarge = 24,
    this.maximum = 999,
  });
}

class Corners {
  final double zero;
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double maximum;

  const Corners({
    this.zero = 0,
    this.extraSmall = 4,
    this.small = 8,
    this.medium = 12,
    this.large = 16,
    this.extraLarge = 24,
    this.maximum = 999,
  });

  BorderRadius get circular => BorderRadius.circular(medium);
  BorderRadius get roundedZero => BorderRadius.circular(zero);
  BorderRadius get roundedSmall => BorderRadius.circular(small);
  BorderRadius get roundedMedium => BorderRadius.circular(medium);
  BorderRadius get roundedLarge => BorderRadius.circular(large);
  BorderRadius get roundedExtraLarge => BorderRadius.circular(extraLarge);
  BorderRadius get roundedMaximum => BorderRadius.circular(maximum);

  BorderRadius only({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? zero),
        topRight: Radius.circular(topRight ?? zero),
        bottomLeft: Radius.circular(bottomLeft ?? zero),
        bottomRight: Radius.circular(bottomRight ?? zero),
      );

  BorderRadius top(double radius) => BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      );

  BorderRadius bottom(double radius) => BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );

  BorderRadius left(double radius) => BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      );

  BorderRadius right(double radius) => BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );
}

class Shadows {
  final List<BoxShadow> none;
  final List<BoxShadow> small;
  final List<BoxShadow> medium;
  final List<BoxShadow> large;
  final List<BoxShadow> extraLarge;
  final List<BoxShadow> longShadow;
  final List<BoxShadow> innerGlow;
  final List<BoxShadow> neonGlow;
  final List<BoxShadow> layered;
  final List<BoxShadow> outerFlow;
  final Map<String, List<BoxShadow>> custom;

  const Shadows({
    this.none = const [],
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
    required this.longShadow,
    required this.innerGlow,
    required this.neonGlow,
    required this.layered,
    required this.outerFlow,
    this.custom = const {},
  });

  List<BoxShadow>? getCustomShadow(String key) => custom[key];

  factory Shadows.standard({
    Color shadowColor = Colors.black,
    double opacity = 0.1,
  }) =>
      Shadows(
        small: [
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255).round()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        medium: [
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        large: [
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255).round()),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        extraLarge: [
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255).round()),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
        longShadow: List.generate(
          15,
          (index) => BoxShadow(
            color: shadowColor
                .withAlpha(((opacity * 0.8 / (index + 1)) * 255).round()),
            offset: Offset(index.toDouble() * 2, index.toDouble() * 2),
          ),
        ),
        innerGlow: [
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255).round()),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(0, 0),
          ),
        ],
        neonGlow: [
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255).round()),
            blurRadius: 16,
            spreadRadius: 4,
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 127).round()),
            blurRadius: 32,
            spreadRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
        layered: [
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255 * 0.2).round()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255 * 0.14).round()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255 * 0.12).round()),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        outerFlow: [
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255 * 0.2).round()),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: shadowColor.withAlpha((opacity * 255 * 0.1).round()),
            blurRadius: 24,
            spreadRadius: 4,
            offset: const Offset(0, 12),
          ),
        ],
      );
}

class Borders {
  final double none;
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;

  const Borders({
    this.none = 0,
    this.extraSmall = 1,
    this.small = 2,
    this.medium = 3,
    this.large = 4,
    this.extraLarge = 6,
  });
}

class ThemePalette {
  final String id;
  final String name;
  final ThemeColors colors;
  final ThemeTypography typography;
  final ThemeElevation? elevation;
  final Corners corners;
  final Shadows shadows;
  final Spacing spacing;
  final Borders borders;
  const ThemePalette({
    required this.id,
    required this.name,
    required this.colors,
    required this.typography,
    this.elevation,
    this.corners = const Corners(),
    required this.shadows,
    this.spacing = const Spacing(),
    this.borders = const Borders(),
  });

  ThemeData toThemeData() {
    return ThemeData(
      colorScheme: colors.toColorScheme(Brightness.light),
      textTheme: typography.toTextTheme(),
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.surface,
    );
  }
}
