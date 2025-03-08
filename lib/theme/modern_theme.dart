import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class ModernTheme {
  // Color definitions - Modern Color Palette
  static const _primary = Color(0xFF6750A4);
  static const _onPrimary = Color(0xFFFFFFFF);
  static const _primaryContainer = Color(0xFFEADDFF);
  static const _onPrimaryContainer = Color(0xFF21005E);

  static const _secondary = Color(0xFF625B71);
  static const _onSecondary = Color(0xFFFFFFFF);
  static const _secondaryContainer = Color(0xFFE8DEF8);
  static const _onSecondaryContainer = Color(0xFF1E192B);

  static const _tertiary = Color(0xFF7D5260);
  static const _onTertiary = Color(0xFFFFFFFF);
  static const _tertiaryContainer = Color(0xFFFFD8E4);
  static const _onTertiaryContainer = Color(0xFF31111D);

  static const _error = Color(0xFFB00020);
  static const _onError = Color(0xFFFFFFFF);
  static const _errorContainer = Color(0xFFFDE0E0);
  static const _onErrorContainer = Color(0xFF5F1412);

  static const _background = Color(0xFFFFFBFE);
  static const _onBackground = Color(0xFF1C1B1F);
  static const _surface = Color(0xFFFFFBFE);
  static const _onSurface = Color(0xFF1C1B1F);

  // Additional color definitions for UI elements
  static const _accent = Color(0xFF03DAC6); // Teal accent
  static const _accentLight = Color(0xFF4DB6AC);
  static const _accentDark = Color(0xFF018786);
  static const _divider = Color(0xFFE0E0E0);
  static const _cardColor = Color(0xFFFAFAFA);
  static const _dialogBackgroundColor = Color(0xFFFFFFFF);
  static const _disabledColor = Color(0xFFBDBDBD);
  static const _hintColor = Color(0xFF9E9E9E);
  static const _indicatorColor = Color(0xFF6750A4);
  static const _scaffoldBackgroundColor = Color(0xFFFFFBFE);
  static const _secondaryHeaderColor = Color(0xFFF3E5F5);
  static const _selectedRowColor = Color(0xFFF5F5F5);
  static const _unselectedWidgetColor = Color(0xFF757575);

  // Text-specific colors
  static const _textPrimary = Color(0xFF1C1B1F);
  static const _textSecondary = Color(0xFF49454F);
  static const _textHint = Color(0xFF79747E);
  static const _textDisabled = Color(0xFFBDBDBD);
  static const _textSelectionColor = Color(0xFFE8DEF8);
  static const _textSelectionHandleColor = Color(0xFF6750A4);

  // State colors
  static const _hoverStateColor = Color(0x0A000000);
  static const _focusStateColor = Color(0x1F6750A4);
  static const _splashStateColor = Color(0x1A6750A4);

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
    background: Colors.white,
    onBackground: _textPrimary,
    surface: Colors.white,
    onSurface: _textPrimary,
    surfaceVariant: _withOpacity(_surface, 0.7),
    onSurfaceVariant: _withOpacity(_onSurface, 0.7),
    outline: _withOpacity(_onSurface, 0.12),
    outlineVariant: _withOpacity(_onSurface, 0.08),
    shadow: _withOpacity(Colors.black, 0.2),
    scrim: _withOpacity(Colors.black, 0.4),
    inverseSurface: _onSurface,
    onInverseSurface: _surface,
    inversePrimary: _primaryContainer,
    surfaceTint: _withOpacity(_primary, 0.2),
    surfaceContainerLowest: _withOpacity(_surface, 0.9),
    surfaceContainerLow: _withOpacity(_surface, 0.8),
    surfaceContainer: _withOpacity(_surface, 0.7),
    surfaceContainerHigh: _withOpacity(_surface, 0.6),
    surfaceContainerHighest: _withOpacity(_surface, 0.5),
    surfaceDim: _withOpacity(_surface, 0.4),
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
    hoverColor: _withOpacity(_primary, 0.08),
    focusColor: _withOpacity(_primary, 0.12),
    highlightColor: _withOpacity(_primary, 0.12),
    splashColor: _withOpacity(_primary, 0.12),
    pressedOpacity: 0.12,
    draggedOpacity: 0.16,
    disabledOpacity: 0.38,
  );

  // Shared typography instance
  static final _typography = ThemeTypography(
    primaryFont: 'Inter',
    displayFont: 'Poppins',
    accentFont: 'Poppins',
    monospaceFont: 'JetBrains Mono',
    handwritingFont: 'Nothing You Could Do',
    defaultColor: _onSurface,
    display: GoogleFonts.poppins(
      fontSize: 48,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
      color: _onSurface,
    ),
    headline: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.25,
      color: _onSurface,
    ),
    title: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      color: _onSurface,
    ),
    subtitle: GoogleFonts.poppins(
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
    button: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.4,
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
    quote: GoogleFonts.poppins(
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
        id: 'modern',
        name: 'Modern',
        colors: _themeColors,
        typography: _typography,
        corners: _corners,
        shadows: Shadows.standard(
          shadowColor: Colors.black,
          opacity: 0.2,
        ),
      );
}
