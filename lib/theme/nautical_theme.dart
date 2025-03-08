import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class NauticalTheme {
  // Color definitions - Extended Nautical Color Palette
  static const _primary = Color(0xFF1E88E5); // Ocean Blue
  static const _onPrimary = Color(0xFFFFFFFF); // Pure White
  static const _primaryContainer = Color(0xFF1565C0); // Deep Ocean Blue
  static const _onPrimaryContainer = Color(0xFFFFFFFF);

  static const _secondary = Color(0xFF26A69A); // Sea Green
  static const _onSecondary = Color(0xFFFFFFFF);
  static const _secondaryContainer = Color(0xFF00897B); // Deep Sea Green
  static const _onSecondaryContainer = Color(0xFFFFFFFF);

  static const _tertiary = Color(0xFFFF8F00); // Sunset Orange
  static const _onTertiary = Color(0xFF000000); // Black for contrast
  static const _tertiaryContainer = Color(0xFFF57C00); // Deep Sunset
  static const _onTertiaryContainer = Color(0xFF000000);

  static const _error = Color(0xFFD32F2F); // Alert Red
  static const _onError = Color(0xFFFFFFFF);
  static const _errorContainer = Color(0xFFC62828);
  static const _onErrorContainer = Color(0xFFFFFFFF);

  static const _background = Color(0xFF102027); // Dark Ocean
  static const _onBackground = Color(0xFFECEFF1); // Sea Foam White
  static const _surface = Color(0xFF162B32); // Deep Water
  static const _onSurface = Color(0xFFECEFF1);

  // Additional theme colors
  static const _accent = Color(0xFFFFD700); // Gold
  static const _accentLight = Color(0xFFFFE57F); // Light Gold
  static const _accentDark = Color(0xFFFFC400); // Dark Gold
  static const _divider = Color(0xFF37474F); // Slate Gray
  static const _cardColor = Color(0xFF1C353F); // Deep Blue Gray
  static const _dialogBackgroundColor = Color(0xFF15272E); // Darker Ocean
  static const _disabledColor = Color(0xFF546E7A); // Muted Blue Gray
  static const _hintColor = Color(0xFF78909C); // Light Blue Gray
  static const _indicatorColor = Color(0xFF29B6F6); // Light Blue
  static const _scaffoldBackgroundColor = Color(0xFF0B171C); // Darkest Ocean
  static const _secondaryHeaderColor = Color(0xFF26A69A); // Teal
  static const _selectedRowColor = Color(0xFF1C353F); // Selected Blue
  static const _unselectedWidgetColor = Color(0xFF78909C); // Unselected Gray

  // Text Colors
  static const _textPrimary = Color(0xFFECEFF1); // Primary Text
  static const _textSecondary = Color(0xFFB0BEC5); // Secondary Text
  static const _textHint = Color(0xFF78909C); // Hint Text
  static const _textDisabled = Color(0xFF607D8B); // Disabled Text
  static const _textSelectionColor = Color(0xFF29B6F6); // Selection Blue
  static const _textSelectionHandleColor = Color(0xFF039BE5); // Handle Blue

  // State Colors
  static const _hoverStateColor = Color(0x1426A69A); // Teal with 8% opacity
  static const _focusStateColor = Color(0x1F26A69A); // Teal with 12% opacity
  static const _splashStateColor = Color(0x1F26A69A); // Teal with 12% opacity

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
    accent: _accent,
    accentLight: _accentLight,
    accentDark: _accentDark,
    divider: _divider,
    cardColor: _cardColor,
    dialogBackgroundColor: _dialogBackgroundColor,
    disabledColor: _disabledColor,
    hintColor: _hintColor,
    indicatorColor: _indicatorColor,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    secondaryHeaderColor: _secondaryHeaderColor,
    selectedRowColor: _selectedRowColor,
    unselectedWidgetColor: _unselectedWidgetColor,
    textPrimary: _textPrimary,
    textSecondary: _textSecondary,
    textHint: _textHint,
    textDisabled: _textDisabled,
    textSelectionColor: _textSelectionColor,
    textSelectionHandleColor: _textSelectionHandleColor,
    hoverStateColor: _hoverStateColor,
    focusStateColor: _focusStateColor,
    splashStateColor: _splashStateColor,
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
    button: GoogleFonts.pirataOne(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
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
        id: 'nautical',
        name: 'Nautical',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.3,
        ),
      );
}
