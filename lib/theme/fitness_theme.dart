import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class FitnessTheme {
  // Color definitions - Modern Fitness Color Palette
  static const _primary = Color(0xFF00FF7F); // Neon Green
  static const _onPrimary = Color(0xFF000000); // Deep Black
  static const _primaryContainer = Color(0xFF1AFF8C);
  static const _onPrimaryContainer = Color(0xFF000000);

  static const _secondary = Color(0xFF121212); // Deep Black
  static const _onSecondary = Color(0xFFFFFFFF);
  static const _secondaryContainer = Color(0xFF2A2A2A);
  static const _onSecondaryContainer = Color(0xFFFFFFFF);

  static const _tertiary = Color(0xFFE0E0E0); // Light Grey
  static const _onTertiary = Color(0xFF000000);
  static const _tertiaryContainer = Color(0xFFF5F5F5);
  static const _onTertiaryContainer = Color(0xFF000000);

  static const _error = Color(0xFFFF3B30);
  static const _onError = Color(0xFFFFFFFF);
  static const _errorContainer = Color(0xFFFFDAD6);
  static const _onErrorContainer = Color(0xFF410002);

  static const _background = Color(0xFFFFFFFF);
  static const _onBackground = Color(0xFF000000);
  static const _surface = Color(0xFFFFFFFF);
  static const _onSurface = Color(0xFF000000);

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
    outline: _withOpacity(_onSurface, 0.12),
    outlineVariant: _withOpacity(_onSurface, 0.08),
    shadow: _withOpacity(Colors.black, 0.15),
    scrim: _withOpacity(Colors.black, 0.3),
    inverseSurface: _onSurface,
    onInverseSurface: _surface,
    inversePrimary: _primaryContainer,
    surfaceTint: _withOpacity(_primary, 0.2),
    surfaceContainerLowest: _withOpacity(_surface, 0.95),
    surfaceContainerLow: _withOpacity(_surface, 0.9),
    surfaceContainer: _withOpacity(_surface, 0.85),
    surfaceContainerHigh: _withOpacity(_surface, 0.8),
    surfaceContainerHighest: _withOpacity(_surface, 0.75),
    surfaceDim: _withOpacity(_surface, 0.7),
    surfaceBright: _withOpacity(_surface, 1),
    hoverColor: _withOpacity(_primary, 0.08),
    focusColor: _withOpacity(_primary, 0.12),
    highlightColor: _withOpacity(_primary, 0.12),
    splashColor: _withOpacity(_primary, 0.12),
  );

  // Shared typography instance
  static final _typography = ThemeTypography(
    primaryFont: 'Inter',
    displayFont: 'Roboto',
    accentFont: 'Roboto',
    monospaceFont: 'JetBrains Mono',
    handwritingFont: 'Nothing You Could Do',
    defaultColor: _onSurface,
    display: GoogleFonts.roboto(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: _onSurface,
    ),
    headline: GoogleFonts.roboto(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      color: _onSurface,
    ),
    title: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: _onSurface,
    ),
    body: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: _onSurface,
    ),
    label: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _onSurface,
    ),
    caption: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: _onSurface,
    ),
    code: GoogleFonts.jetBrainsMono(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: _onSurface,
    ),
    quote: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      fontStyle: FontStyle.italic,
      color: _onSurface,
    ),
    handwriting: GoogleFonts.nothingYouCouldDo(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      color: _onSurface,
    ),
  );

  static ThemePalette get theme => ThemePalette(
        id: 'fitness',
        name: 'Fitness',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.15,
        ),
      );
}
