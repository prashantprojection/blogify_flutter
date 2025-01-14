import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class NewsTheme {
  // Color definitions - Modern News Color Palette
  static const _primary = Color(0xFF000000); // Black
  static const _onPrimary = Color(0xFFFFFFFF); // White
  static const _primaryContainer = Color(0xFF1A1A1A); // Soft Black
  static const _onPrimaryContainer = Color(0xFFFFFFFF);

  static const _secondary = Color(0xFFE60000); // Red
  static const _onSecondary = Color(0xFFFFFFFF);
  static const _secondaryContainer = Color(0xFFCC0000);
  static const _onSecondaryContainer = Color(0xFFFFFFFF);

  static const _tertiary = Color(0xFF757575); // Grey
  static const _onTertiary = Color(0xFFFFFFFF);
  static const _tertiaryContainer = Color(0xFF616161);
  static const _onTertiaryContainer = Color(0xFFFFFFFF);

  static const _error = Color(0xFFD32F2F);
  static const _onError = Color(0xFFFFFFFF);
  static const _errorContainer = Color(0xFFB71C1C);
  static const _onErrorContainer = Color(0xFFFFFFFF);

  static const _background = Color(0xFFFFFFFF);
  static const _onBackground = Color(0xFF000000);
  static const _surface = Color(0xFFFFFFFF);
  static const _onSurface = Color(0xFF000000);

  // Shared instances for theme configurations
  static const _corners = Corners(
    zero: 0,
    extraSmall: 2,
    small: 4,
    medium: 8,
    large: 12,
    extraLarge: 16,
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
    onSurfaceVariant: _withOpacity(_onSurface, 0.95),
    outline: _withOpacity(_tertiary, 0.2),
    outlineVariant: _withOpacity(_tertiary, 0.15),
    shadow: _withOpacity(Colors.black, 0.1),
    scrim: _withOpacity(Colors.black, 0.3),
    inverseSurface: _onSurface,
    onInverseSurface: _surface,
    inversePrimary: _onPrimary,
    surfaceTint: _withOpacity(_tertiary, 0.1),
    surfaceContainerLowest: _withOpacity(_surface, 1),
    surfaceContainerLow: _withOpacity(_surface, 0.98),
    surfaceContainer: _withOpacity(_surface, 0.96),
    surfaceContainerHigh: _withOpacity(_surface, 0.94),
    surfaceContainerHighest: _withOpacity(_surface, 0.92),
    surfaceDim: _withOpacity(_surface, 0.9),
    surfaceBright: _withOpacity(_surface, 1),
    hoverColor: _withOpacity(_tertiary, 0.05),
    focusColor: _withOpacity(_tertiary, 0.08),
    highlightColor: _withOpacity(_tertiary, 0.08),
    splashColor: _withOpacity(_tertiary, 0.08),
  );

  // Shared typography instance
  static final _typography = ThemeTypography(
    primaryFont: 'Inter',
    displayFont: 'Playfair Display',
    accentFont: 'Montserrat',
    monospaceFont: 'Roboto Mono',
    handwritingFont: 'Lora',
    defaultColor: _onSurface,
    display: GoogleFonts.playfairDisplay(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.2,
      color: _onSurface,
    ),
    headline: GoogleFonts.playfairDisplay(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      height: 1.3,
      color: _onSurface,
    ),
    title: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.4,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.4,
      color: _onSurface,
    ),
    body: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.5,
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
      letterSpacing: 0.4,
      height: 1.3,
      color: _onSurface,
    ),
    code: GoogleFonts.robotoMono(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.5,
      color: _onSurface,
    ),
    quote: GoogleFonts.lora(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      height: 1.6,
      fontStyle: FontStyle.italic,
      color: _onSurface,
    ),
    handwriting: GoogleFonts.lora(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.4,
      color: _onSurface,
    ),
  );

  static ThemePalette get theme => ThemePalette(
        id: 'news',
        name: 'News',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.1,
        ),
      );
}
