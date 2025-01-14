import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class GoldAgeTheme {
  // Color definitions - Royal Color Palette
  static const _primary = Color(0xFFD4AF37); // Royal Gold
  static const _onPrimary = Color(0xFF1A1A1A);
  static const _primaryContainer = Color(0xFFFFD700); // Pure Gold
  static const _onPrimaryContainer = Color(0xFF1A1A1A);

  static const _secondary = Color(0xFF8B0000); // Deep Red
  static const _onSecondary = Color(0xFFFFFAF0);
  static const _secondaryContainer = Color(0xFFA52A2A);
  static const _onSecondaryContainer = Color(0xFFFFFAF0);

  static const _tertiary = Color(0xFF000080); // Royal Blue
  static const _onTertiary = Color(0xFFFFFAF0);
  static const _tertiaryContainer = Color(0xFF000066);
  static const _onTertiaryContainer = Color(0xFFFFFAF0);

  static const _error = Color(0xFF8B0000);
  static const _onError = Color(0xFFFFFAF0);
  static const _errorContainer = Color(0xFFA52A2A);
  static const _onErrorContainer = Color(0xFFFFFAF0);

  static const _background = Color(0xFFFFFAF0); // Ivory
  static const _onBackground = Color(0xFF1A1A1A);
  static const _surface = Color(0xFFFFFAF0);
  static const _onSurface = Color(0xFF1A1A1A);

  // Shared instances for theme configurations
  static const _corners = Corners(
    zero: 0,
    extraSmall: 6,
    small: 12,
    medium: 18,
    large: 24,
    extraLarge: 32,
    maximum: 999,
  );

  // Helper methods
  static Color _withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  // Helper methods for text styles with color overrides

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
    outline: _withOpacity(_primary, 0.2),
    outlineVariant: _withOpacity(_primary, 0.15),
    shadow: _withOpacity(Colors.black, 0.2),
    scrim: _withOpacity(Colors.black, 0.4),
    inverseSurface: _onSurface,
    onInverseSurface: _surface,
    inversePrimary: _onPrimary,
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
    primaryFont: 'Cinzel',
    displayFont: 'Playfair Display',
    accentFont: 'Cormorant Garamond',
    monospaceFont: 'Crimson Text',
    handwritingFont: 'Great Vibes',
    defaultColor: _onSurface,
    display: GoogleFonts.playfairDisplay(
      fontSize: 56,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      height: 1.2,
      color: _onSurface,
    ),
    headline: GoogleFonts.playfairDisplay(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.3,
      color: _onSurface,
    ),
    title: GoogleFonts.cinzel(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.4,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.cormorantGaramond(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.4,
      color: _onSurface,
    ),
    body: GoogleFonts.crimsonText(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.6,
      color: _onSurface,
    ),
    label: GoogleFonts.cinzel(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: 1.4,
      color: _onSurface,
    ),
    caption: GoogleFonts.crimsonText(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.3,
      color: _onSurface,
    ),
    code: GoogleFonts.crimsonText(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.5,
      color: _onSurface,
    ),
    quote: GoogleFonts.cormorantGaramond(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.6,
      fontStyle: FontStyle.italic,
      color: _onSurface,
    ),
    handwriting: GoogleFonts.greatVibes(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.4,
      color: _onSurface,
    ),
  );

  static ThemePalette get theme => ThemePalette(
        id: 'gold_age',
        name: 'Gold Age',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.2,
        ),
      );
}
