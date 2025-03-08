import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class FitnessProTheme {
  // Color definitions - Professional Fitness Color Palette
  static const _primary = Color(0xFFFF5722); // Neon Orange
  static const _onPrimary = Color(0xFFFFFFFF); // White for better contrast
  static const _primaryContainer = Color(0xFFFF7043);
  static const _onPrimaryContainer = Color(0xFFFFFFFF);

  static const _secondary = Color(0xFF000000); // Black
  static const _onSecondary = Color(0xFFFFFFFF);
  static const _secondaryContainer = Color(0xFF1A1A1A);
  static const _onSecondaryContainer = Color(0xFFFFFFFF);

  static const _tertiary = Color(0xFF424242); // Grey
  static const _onTertiary = Color(0xFFFFFFFF);
  static const _tertiaryContainer = Color(0xFF616161);
  static const _onTertiaryContainer = Color(0xFFFFFFFF);

  static const _error = Color(0xFFFF3D00);
  static const _onError = Color(0xFFFFFFFF);
  static const _errorContainer = Color(0xFFFF6E40);
  static const _onErrorContainer = Color(0xFFFFFFFF);

  static const _background = Color(0xFF121212); // Dark background
  static const _onBackground = Color(0xFFFFFFFF);
  static const _surface = Color(0xFF1D1D1D); // Slightly lighter than background
  static const _onSurface = Color(0xFFFFFFFF);

  // Additional color definitions for UI elements
  static const _accent = Color(0xFF64DD17); // Bright lime
  static const _accentLight = Color(0xFF76FF03);
  static const _accentDark = Color(0xFF33691E);
  static const _divider = Color(0xFF424242);
  static const _cardColor = Color(0xFF1D1D1D);
  static const _dialogBackgroundColor = Color(0xFF212121);
  static const _disabledColor = Color(0xFF757575);
  static const _hintColor = Color(0xFFBDBDBD);
  static const _indicatorColor = Color(0xFFFF5722);
  static const _scaffoldBackgroundColor = Color(0xFF121212);
  static const _secondaryHeaderColor = Color(0xFF1A1A1A);
  static const _selectedRowColor = Color(0xFF3D3D3D);
  static const _unselectedWidgetColor = Color(0xFF757575);

  // Text-specific colors
  static const _textPrimary = Color(0xFFFFFFFF);
  static const _textSecondary = Color(0xFFE0E0E0);
  static const _textHint = Color(0xFF9E9E9E);
  static const _textDisabled = Color(0xFF757575);
  static const _textSelectionColor = Color(0xFFFF5722);
  static const _textSelectionHandleColor = Color(0xFFFF7043);

  // State colors
  static const _hoverStateColor = Color(0x1AFFFFFF);
  static const _focusStateColor = Color(0x1FFF5722);
  static const _splashStateColor = Color(0x1AFF5722);

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
    accent: _accent,
    background: _background,
    onBackground: _onBackground,
    surface: _surface,
    onSurface: _onSurface,
    surfaceVariant: _withOpacity(_surface, 0.9),
    onSurfaceVariant: _withOpacity(_onSurface, 0.7),
    outline: _withOpacity(_onSurface, 0.2),
    outlineVariant: _withOpacity(_onSurface, 0.12),
    shadow: _withOpacity(Colors.black, 0.3),
    scrim: _withOpacity(Colors.black, 0.5),
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
    pressedOpacity: 0.12,
    draggedOpacity: 0.16,
    disabledOpacity: 0.38,
    accentLight: _accentLight,
    accentDark: _accentDark,
    divider: _divider,
    cardColor: _cardColor,
    dialogBackgroundColor: _dialogBackgroundColor,
    disabledColor: _disabledColor,
    focusColor: _focusStateColor,
    hintColor: _hintColor,
    hoverColor: _hoverStateColor,
    indicatorColor: _indicatorColor,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    secondaryHeaderColor: _secondaryHeaderColor,
    selectedRowColor: _selectedRowColor,
    splashColor: _splashStateColor,
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
    highlightColor: _withOpacity(_primary, 0.12),
  );

  // Shared typography instance
  static final _typography = ThemeTypography(
    primaryFont: 'Roboto Condensed',
    displayFont: 'Oswald',
    accentFont: 'Oswald',
    monospaceFont: 'Fira Code',
    handwritingFont: 'Nothing You Could Do',
    defaultColor: _onSurface,
    display: GoogleFonts.oswald(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: _onSurface,
    ),
    headline: GoogleFonts.oswald(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      color: _onSurface,
    ),
    title: GoogleFonts.oswald(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.robotoCondensed(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: _onSurface,
    ),
    body: GoogleFonts.robotoCondensed(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: _onSurface,
    ),
    button: GoogleFonts.robotoCondensed(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.4,
      color: _onSurface,
    ),
    label: GoogleFonts.robotoCondensed(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: _onSurface,
    ),
    caption: GoogleFonts.robotoCondensed(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: _onSurface,
    ),
    code: GoogleFonts.firaCode(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: _onSurface,
    ),
    quote: GoogleFonts.oswald(
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

  // Helper methods for text styles with color overrides
  static ThemePalette get theme => ThemePalette(
        id: 'fitness_pro',
        name: 'Fitness Pro',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.3,
        ),
      );
}
