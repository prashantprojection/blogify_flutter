import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class EyeComfortTheme {
  // Color definitions - Research-backed colors for eye comfort
  // Using sepia-tinted background and dark gray text for optimal contrast
  static const _primary = Color(0xFF1B5E20); // Soft forest green
  static const _onPrimary = Color(0xFFF5F5F5); // Off-white
  static const _primaryContainer = Color(0xFF2E7D32);
  static const _onPrimaryContainer = Color(0xFFF5F5F5);

  static const _secondary = Color(0xFF455A64); // Blue-gray
  static const _onSecondary = Color(0xFFF5F5F5);
  static const _secondaryContainer = Color(0xFF607D8B);
  static const _onSecondaryContainer = Color(0xFFF5F5F5);

  static const _tertiary = Color(0xFF795548); // Warm brown
  static const _onTertiary = Color(0xFFF5F5F5);
  static const _tertiaryContainer = Color(0xFF8D6E63);
  static const _onTertiaryContainer = Color(0xFFF5F5F5);

  static const _error = Color(0xFFB71C1C); // Muted red
  static const _onError = Color(0xFFF5F5F5);
  static const _errorContainer = Color(0xFFD32F2F);
  static const _onErrorContainer = Color(0xFFF5F5F5);

  // Sepia-tinted background for reduced blue light
  static const _background = Color(0xFFF8F1E3);
  static const _onBackground = Color(0xFF2C3E50);
  // Slightly darker sepia for surface elements
  static const _surface = Color(0xFFF5ECD9);
  static const _onSurface = Color(0xFF2C3E50);

  // Additional color definitions for UI elements
  static const _accent = Color(0xFF00796B); // Teal
  static const _accentLight = Color(0xFF26A69A);
  static const _accentDark = Color(0xFF004D40);
  static const _divider = Color(0xFFBDBDBD);
  static const _cardColor = Color(0xFFFAF6E9);
  static const _dialogBackgroundColor = Color(0xFFFDF9EC);
  static const _disabledColor = Color(0xFF9E9E9E);
  static const _hintColor = Color(0xFF757575);
  static const _indicatorColor = Color(0xFF1B5E20);
  static const _scaffoldBackgroundColor = Color(0xFFF8F1E3);
  static const _secondaryHeaderColor = Color(0xFFF0E6D6);
  static const _selectedRowColor = Color(0xFFE8F5E9);
  static const _unselectedWidgetColor = Color(0xFF757575);

  // Text-specific colors
  static const _textPrimary = Color(0xFF2C3E50);
  static const _textSecondary = Color(0xFF455A64);
  static const _textHint = Color(0xFF757575);
  static const _textDisabled = Color(0xFF9E9E9E);
  static const _textSelectionColor = Color(0xFFB2DFDB);
  static const _textSelectionHandleColor = Color(0xFF00796B);

  // State colors
  static const _hoverStateColor = Color(0x0A000000);
  static const _focusStateColor = Color(0x1F000000);
  static const _splashStateColor = Color(0x1A000000);

  // Shared instances for theme configurations
  static const _corners = Corners(
    zero: 0,
    extraSmall: 4,
    small: 8,
    medium: 12,
    large: 16,
    extraLarge: 20,
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
    background: Colors.white,
    accent: _accent,
    onBackground: _textPrimary,
    surface: Colors.white,
    onSurface: _textPrimary,
    surfaceVariant: _withOpacity(_surface, 0.9),
    onSurfaceVariant: _withOpacity(_onSurface, 0.9),
    outline: _withOpacity(_onSurface, 0.12),
    outlineVariant: _withOpacity(_onSurface, 0.08),
    shadow: _withOpacity(Colors.black, 0.1),
    scrim: _withOpacity(Colors.black, 0.2),
    inverseSurface: _onSurface,
    onInverseSurface: _surface,
    inversePrimary: _onPrimary,
    surfaceTint: _withOpacity(_primary, 0.1),
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
    focusColor: _withOpacity(_primary, 0.08),
    hintColor: _hintColor,
    hoverColor: _withOpacity(_primary, 0.05),
    indicatorColor: _indicatorColor,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    secondaryHeaderColor: _secondaryHeaderColor,
    selectedRowColor: _selectedRowColor,
    splashColor: _withOpacity(_primary, 0.08),
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
    highlightColor: _withOpacity(_primary, 0.08),
  );

  // Shared typography instance - Optimized for readability
  static final _typography = ThemeTypography(
    primaryFont: 'Source Serif Pro', // Highly readable serif
    displayFont: 'Merriweather', // Serif for headlines
    accentFont: 'Merriweather',
    monospaceFont: 'Source Code Pro',
    handwritingFont: 'Kalam',
    defaultColor: _onSurface,
    // Larger font sizes and increased line height for better readability
    display: GoogleFonts.merriweather(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.4,
      color: _onSurface,
    ),
    headline: GoogleFonts.merriweather(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      height: 1.4,
      color: _onSurface,
    ),
    title: GoogleFonts.merriweather(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.4,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.sourceSerif4(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.5,
      color: _onSurface,
    ),
    body: GoogleFonts.sourceSerif4(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.6,
      color: _onSurface,
    ),
    button: GoogleFonts.sourceSerif4(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.4,
      color: _onSurface,
    ),
    label: GoogleFonts.sourceSerif4(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.5,
      color: _onSurface,
    ),
    caption: GoogleFonts.sourceSerif4(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      height: 1.4,
      color: _onSurface,
    ),
    code: GoogleFonts.sourceCodePro(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.5,
      color: _onSurface,
    ),
    quote: GoogleFonts.merriweather(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.6,
      fontStyle: FontStyle.italic,
      color: _onSurface,
    ),
    handwriting: GoogleFonts.kalam(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.4,
      color: _onSurface,
    ),
  );

  static ThemePalette get theme => ThemePalette(
        id: 'eye_comfort',
        name: 'Eye Comfort',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.08,
        ),
      );
}
