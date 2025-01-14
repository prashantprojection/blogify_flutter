import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class VintageJewelryTheme {
  // Color definitions
  static const _primaryNavy = Color(0xFF0A1F44);
  static const _goldAccent = Color(0xFFD4AF37);
  static const _cream = Color(0xFFF5F5DC);
  static const _darkGold = Color(0xFFB8860B);
  static const _lightGold = Color(0xFFFFD700);
  static const _deepNavy = Color(0xFF050A1A);
  static const _pearl = Color(0xFFFFFAF0);
  static const _error = Color(0xFFB00020);
  static const _errorContainer = Color(0xFFFDE0E0);
  static const _onErrorContainer = Color(0xFF5F1412);

  // Shared instances for theme configurations
  static const _corners = Corners(
    zero: 0,
    extraSmall: 4,
    small: 8,
    medium: 16,
    large: 24,
    extraLarge: 32,
    maximum: 999,
  );

  // Helper methods
  static Color _withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  // Shared theme colors instance
  static final _themeColors = ThemeColors(
    primary: _goldAccent,
    onPrimary: _deepNavy,
    primaryContainer: _darkGold,
    onPrimaryContainer: _pearl,
    secondary: _primaryNavy,
    onSecondary: _cream,
    secondaryContainer: _deepNavy,
    onSecondaryContainer: _lightGold,
    tertiary: _cream,
    onTertiary: _primaryNavy,
    tertiaryContainer: _pearl,
    onTertiaryContainer: _deepNavy,
    error: _error,
    onError: Colors.white,
    errorContainer: _errorContainer,
    onErrorContainer: _onErrorContainer,
    background: _pearl,
    onBackground: _deepNavy,
    surface: _cream,
    onSurface: _primaryNavy,
    surfaceVariant: _withOpacity(_pearl, 0.7),
    onSurfaceVariant: _withOpacity(_primaryNavy, 0.7),
    outline: _withOpacity(_darkGold, 0.5),
    outlineVariant: _withOpacity(_darkGold, 0.2),
    shadow: _withOpacity(_deepNavy, 0.2),
    scrim: _withOpacity(_deepNavy, 0.4),
    inverseSurface: _deepNavy,
    onInverseSurface: _pearl,
    inversePrimary: _lightGold,
    surfaceTint: _withOpacity(_goldAccent, 0.2),
    surfaceContainerLowest: _withOpacity(_pearl, 0.9),
    surfaceContainerLow: _withOpacity(_pearl, 0.8),
    surfaceContainer: _withOpacity(_pearl, 0.7),
    surfaceContainerHigh: _withOpacity(_pearl, 0.6),
    surfaceContainerHighest: _withOpacity(_pearl, 0.5),
    surfaceDim: _withOpacity(_pearl, 0.4),
    surfaceBright: _withOpacity(_pearl, 1),
    hoverColor: _withOpacity(_goldAccent, 0.08),
    focusColor: _withOpacity(_goldAccent, 0.12),
    highlightColor: _withOpacity(_goldAccent, 0.12),
    splashColor: _withOpacity(_goldAccent, 0.12),
  );

  // Shared typography instance
  static final _typography = ThemeTypography(
    primaryFont: 'Montserrat',
    displayFont: 'Playfair Display',
    accentFont: 'Cormorant Garamond',
    monospaceFont: 'Fira Code',
    handwritingFont: 'Dancing Script',
    defaultColor: _deepNavy,
    display: GoogleFonts.playfairDisplay(
      fontSize: 48,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
      color: _deepNavy,
    ),
    headline: GoogleFonts.playfairDisplay(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.25,
      color: _deepNavy,
    ),
    title: GoogleFonts.cormorantGaramond(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      color: _deepNavy,
    ),
    subtitle: GoogleFonts.cormorantGaramond(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: _deepNavy,
    ),
    body: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: _deepNavy,
    ),
    label: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _deepNavy,
    ),
    caption: GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: _deepNavy,
    ),
    code: GoogleFonts.firaCode(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: _deepNavy,
    ),
    quote: GoogleFonts.cormorantGaramond(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      fontStyle: FontStyle.italic,
      color: _deepNavy,
    ),
    handwriting: GoogleFonts.dancingScript(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      color: _deepNavy,
    ),
  );

  // Helper methods for text styles with color overrides

  static ThemePalette get theme => ThemePalette(
        id: 'vintage_jewelry',
        name: 'Vintage Jewelry',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.2,
        ),
      );
}
