import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class DefaultTheme {
  // Color definitions - Default theme colors
  static const _primary = Color(0xFF2196F3); // Material Blue
  static const _onPrimary = Color(0xFFFFFFFF);
  static const _primaryContainer = Color(0xFF1976D2);
  static const _onPrimaryContainer = Color(0xFFFFFFFF);

  static const _secondary = Color(0xFF9C27B0); // Material Purple
  static const _onSecondary = Color(0xFFFFFFFF);
  static const _secondaryContainer = Color(0xFF7B1FA2);
  static const _onSecondaryContainer = Color(0xFFFFFFFF);

  static const _tertiary = Color(0xFF4CAF50); // Material Green
  static const _onTertiary = Color(0xFFFFFFFF);
  static const _tertiaryContainer = Color(0xFF388E3C);
  static const _onTertiaryContainer = Color(0xFFFFFFFF);

  static const _error = Color(0xFFF44336); // Material Red
  static const _onError = Color(0xFFFFFFFF);
  static const _errorContainer = Color(0xFFD32F2F);
  static const _onErrorContainer = Color(0xFFFFFFFF);

  static const _background = Color(0xFFFAFAFA);
  static const _onBackground = Color(0xFF212121);
  static const _surface = Color(0xFFFFFFFF);
  static const _onSurface = Color(0xFF212121);

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
    surfaceVariant: _withOpacity(_surface, 0.95),
    onSurfaceVariant: _onSurface,
    outline: _withOpacity(_onSurface, 0.12),
    outlineVariant: _withOpacity(_onSurface, 0.08),
    shadow: _withOpacity(Colors.black, 0.1),
    scrim: _withOpacity(Colors.black, 0.3),
    inverseSurface: _onSurface,
    onInverseSurface: _surface,
    inversePrimary: _onPrimary,
    surfaceTint: _withOpacity(_primary, 0.06),
    surfaceContainerLowest: _withOpacity(_surface, 1),
    surfaceContainerLow: _withOpacity(_surface, 0.98),
    surfaceContainer: _withOpacity(_surface, 0.95),
    surfaceContainerHigh: _withOpacity(_surface, 0.92),
    surfaceContainerHighest: _withOpacity(_surface, 0.90),
    surfaceDim: _withOpacity(_surface, 0.85),
    surfaceBright: _withOpacity(_surface, 1),
    hoverColor: _withOpacity(_primary, 0.04),
    focusColor: _withOpacity(_primary, 0.12),
    highlightColor: _withOpacity(_primary, 0.08),
    splashColor: _withOpacity(_primary, 0.08),
  );

  // Shared typography instance
  static final _typography = ThemeTypography(
    primaryFont: 'Inter',
    displayFont: 'Poppins',
    accentFont: 'Poppins',
    monospaceFont: 'JetBrains Mono',
    handwritingFont: 'Dancing Script',
    defaultColor: _onSurface,
    display: GoogleFonts.poppins(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
      height: 1.2,
      color: _onSurface,
    ),
    headline: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      height: 1.2,
      color: _onSurface,
    ),
    title: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.2,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.4,
      color: _onSurface,
    ),
    body: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.4,
      color: _onSurface,
    ),
    label: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.4,
      color: _onSurface,
    ),
    caption: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.4,
      color: _onSurface,
    ),
    code: GoogleFonts.jetBrainsMono(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.5,
      color: _onSurface,
    ),
    quote: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.4,
      fontStyle: FontStyle.italic,
      color: _onSurface,
    ),
    handwriting: GoogleFonts.dancingScript(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.4,
      color: _onSurface,
    ),
  );

  static final _borders = Borders(
    none: 0,
    extraSmall: 1,
    small: 2,
    medium: 3,
    large: 4,
    extraLarge: 6,
  );

  static ThemePalette get theme => ThemePalette(
        id: 'default',
        name: 'Default',
        colors: _themeColors,
        typography: _typography,
        borders: _borders,
        corners: _corners,
        shadows: Shadows.standard(shadowColor: Colors.black, opacity: 0.1),
      );
}
