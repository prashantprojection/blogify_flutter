import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class PirateShipTheme {
  // Color definitions - Nautical Color Palette
  static const _primary = Color(0xFF191970); // Midnight Blue
  static const _onPrimary = Color(0xFFF0F8FF); // Soft Moonlight White
  static const _primaryContainer = Color(0xFF000080); // Deeper Midnight
  static const _onPrimaryContainer = Color(0xFFF0F8FF);

  static const _secondary = Color(0xFF008080); // Deep Ocean Teal
  static const _onSecondary = Color(0xFFF0F8FF);
  static const _secondaryContainer = Color(0xFF006666);
  static const _onSecondaryContainer = Color(0xFFF0F8FF);

  static const _tertiary = Color(0xFFD2691E); // Burnt Orange
  static const _onTertiary = Color(0xFFF0F8FF);
  static const _tertiaryContainer = Color(0xFFA0522D);
  static const _onTertiaryContainer = Color(0xFFF0F8FF);

  static const _error = Color(0xFFB22222); // Fire Brick Red
  static const _onError = Color(0xFFF0F8FF);
  static const _errorContainer = Color(0xFF8B0000);
  static const _onErrorContainer = Color(0xFFF0F8FF);

  static const _background = Color(0xFF0A1929); // Deep Ocean Night
  static const _onBackground = Color(0xFFF0F8FF);
  static const _surface = Color(0xFF0A1929);
  static const _onSurface = Color(0xFFF0F8FF);

  // Shared instances for theme configurations
  static const _corners = Corners(
    zero: 0,
    extraSmall: 4,
    small: 8,
    medium: 12,
    large: 16,
    extraLarge: 24,
    maximum: 999,
  );

  // Helper methods
  static Color _withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  // Shared theme colors instance
  static final _themeColors = ThemeColors(
    primary: _primary,
    onPrimary: _onPrimary,
    primaryContainer: _primaryContainer,
    onPrimaryContainer: _onPrimaryContainer,
    secondary: _secondary,
    onSecondary: _onSecondary,
    secondaryContainer: _secondaryContainer,
    onSecondaryContainer: _onSecondaryContainer,
    tertiary: _tertiary,
    onTertiary: _onTertiary,
    tertiaryContainer: _tertiaryContainer,
    onTertiaryContainer: _onTertiaryContainer,
    error: _error,
    onError: _onError,
    errorContainer: _errorContainer,
    onErrorContainer: _onErrorContainer,
    background: _background,
    onBackground: _onBackground,
    surface: _surface,
    onSurface: _onSurface,
    surfaceVariant: _withOpacity(_surface, 0.9),
    onSurfaceVariant: _withOpacity(_onSurface, 0.9),
    outline: _withOpacity(_secondary, 0.2),
    outlineVariant: _withOpacity(_secondary, 0.15),
    shadow: _withOpacity(Colors.black, 0.3),
    scrim: _withOpacity(Colors.black, 0.5),
    inverseSurface: _onSurface,
    onInverseSurface: _surface,
    inversePrimary: _onPrimary,
    surfaceTint: _withOpacity(_secondary, 0.2),
    surfaceContainerLowest: _withOpacity(_surface, 0.95),
    surfaceContainerLow: _withOpacity(_surface, 0.9),
    surfaceContainer: _withOpacity(_surface, 0.85),
    surfaceContainerHigh: _withOpacity(_surface, 0.8),
    surfaceContainerHighest: _withOpacity(_surface, 0.75),
    surfaceDim: _withOpacity(_surface, 0.7),
    surfaceBright: _withOpacity(_surface, 1),
    hoverColor: _withOpacity(_secondary, 0.08),
    focusColor: _withOpacity(_secondary, 0.12),
    highlightColor: _withOpacity(_secondary, 0.12),
    splashColor: _withOpacity(_secondary, 0.12),
  );

  // Shared typography instance
  static final _typography = ThemeTypography(
    primaryFont: 'Pirata One',
    displayFont: 'MedievalSharp',
    accentFont: 'Cinzel Decorative',
    monospaceFont: 'Source Code Pro',
    handwritingFont: 'Satisfy',
    defaultColor: _onSurface,
    display: GoogleFonts.medievalSharp(
      fontSize: 56,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      height: 1.2,
      color: _onSurface,
    ),
    headline: GoogleFonts.medievalSharp(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.3,
      color: _onSurface,
    ),
    title: GoogleFonts.pirataOne(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.4,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.cinzelDecorative(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.4,
      color: _onSurface,
    ),
    body: GoogleFonts.sourceCodePro(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.6,
      color: _onSurface,
    ),
    label: GoogleFonts.pirataOne(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: 1.4,
      color: _onSurface,
    ),
    caption: GoogleFonts.sourceCodePro(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.3,
      color: _onSurface,
    ),
    code: GoogleFonts.sourceCodePro(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.5,
      color: _onSurface,
    ),
    quote: GoogleFonts.satisfy(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      height: 1.6,
      fontStyle: FontStyle.italic,
      color: _onSurface,
    ),
    handwriting: GoogleFonts.satisfy(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.4,
      color: _onSurface,
    ),
  );

  static ThemePalette get theme => ThemePalette(
        id: 'pirate_ship',
        name: 'Pirate Ship',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.3,
        ),
      );
}
