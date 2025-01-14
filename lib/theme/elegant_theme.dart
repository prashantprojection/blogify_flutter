import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class ElegantTheme {
  // Color definitions - Sophisticated color palette
  static const _primary = Color(0xFF2C3E50); // Deep blue-gray
  static const _onPrimary = Color(0xFFF5F5F5);
  static const _primaryContainer = Color(0xFF34495E);
  static const _onPrimaryContainer = Color(0xFFECF0F1);

  static const _secondary = Color(0xFF8E44AD); // Rich purple
  static const _onSecondary = Color(0xFFF5F5F5);
  static const _secondaryContainer = Color(0xFF9B59B6);
  static const _onSecondaryContainer = Color(0xFFECF0F1);

  static const _tertiary = Color(0xFFE67E22); // Warm orange
  static const _onTertiary = Color(0xFF1A1A1A);
  static const _tertiaryContainer = Color(0xFFD35400);
  static const _onTertiaryContainer = Color(0xFFF5F5F5);

  static const _error = Color(0xFFC0392B);
  static const _onError = Color(0xFFF5F5F5);
  static const _errorContainer = Color(0xFFE74C3C);
  static const _onErrorContainer = Color(0xFFF5F5F5);

  static const _background = Color(0xFFF5F5F5);
  static const _onBackground = Color(0xFF2C3E50);
  static const _surface = Color(0xFFFFFFFF);
  static const _onSurface = Color(0xFF2C3E50);

  // Shared instances for theme configurations
  static const _corners = Corners(
    zero: 0,
    extraSmall: 3,
    small: 6,
    medium: 12,
    large: 18,
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
    surfaceVariant: _withOpacity(_surface, 0.8),
    onSurfaceVariant: _withOpacity(_onSurface, 0.8),
    outline: _withOpacity(_onSurface, 0.15),
    outlineVariant: _withOpacity(_onSurface, 0.1),
    shadow: _withOpacity(Colors.black, 0.15),
    scrim: _withOpacity(Colors.black, 0.3),
    inverseSurface: _onSurface,
    onInverseSurface: _surface,
    inversePrimary: _onPrimary,
    surfaceTint: _withOpacity(_primary, 0.15),
    surfaceContainerLowest: _withOpacity(_surface, 0.95),
    surfaceContainerLow: _withOpacity(_surface, 0.9),
    surfaceContainer: _withOpacity(_surface, 0.85),
    surfaceContainerHigh: _withOpacity(_surface, 0.8),
    surfaceContainerHighest: _withOpacity(_surface, 0.75),
    surfaceDim: _withOpacity(_surface, 0.6),
    surfaceBright: _withOpacity(_surface, 1),
    hoverColor: _withOpacity(_primary, 0.06),
    focusColor: _withOpacity(_primary, 0.1),
    highlightColor: _withOpacity(_primary, 0.1),
    splashColor: _withOpacity(_primary, 0.1),
  );

  // Shared typography instance
  static final _typography = ThemeTypography(
    primaryFont: 'Lato',
    displayFont: 'Playfair Display',
    accentFont: 'Cormorant',
    monospaceFont: 'Source Code Pro',
    handwritingFont: 'Great Vibes',
    defaultColor: _onSurface,
    display: GoogleFonts.playfairDisplay(
      fontSize: 48,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      height: 1.2,
      color: _onSurface,
    ),
    headline: GoogleFonts.playfairDisplay(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.3,
      color: _onSurface,
    ),
    title: GoogleFonts.cormorant(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.4,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.cormorant(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.4,
      color: _onSurface,
    ),
    body: GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.5,
      color: _onSurface,
    ),
    label: GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.4,
      color: _onSurface,
    ),
    caption: GoogleFonts.lato(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
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
    quote: GoogleFonts.cormorant(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.6,
      fontStyle: FontStyle.italic,
      color: _onSurface,
    ),
    handwriting: GoogleFonts.greatVibes(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.4,
      color: _onSurface,
    ),
  );

  // Helper methods for text styles with color overrides

  static ThemePalette get theme => ThemePalette(
        id: 'elegant',
        name: 'Elegant',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(shadowColor: Colors.black, opacity: 0.15),
      );
}
