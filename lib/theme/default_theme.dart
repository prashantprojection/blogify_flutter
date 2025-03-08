import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/theme_palette.dart';

class DefaultTheme {
  // Primary colors
  static const _primary = Color(0xFF2196F3); // Material Blue
  static const _onPrimary = Color(0xFFFFFFFF);
  static const _primaryContainer = Color(0xFF1976D2);
  static const _onPrimaryContainer = Color(0xFFFFFFFF);
  static const _primaryLight = Color(0xFF64B5F6);
  static const _primaryDark = Color(0xFF1565C0);
  static const _primaryVariant = Color(0xFF0D47A1);

  // Secondary colors
  static const _secondary = Color(0xFF9C27B0); // Material Purple
  static const _onSecondary = Color(0xFFFFFFFF);
  static const _secondaryContainer = Color(0xFF7B1FA2);
  static const _onSecondaryContainer = Color(0xFFFFFFFF);
  static const _secondaryLight = Color(0xFFBA68C8);
  static const _secondaryDark = Color(0xFF6A1B9A);
  static const _secondaryVariant = Color(0xFF4A148C);

  // Tertiary colors
  static const _tertiary = Color(0xFF4CAF50); // Material Green
  static const _onTertiary = Color(0xFFFFFFFF);
  static const _tertiaryContainer = Color(0xFF388E3C);
  static const _onTertiaryContainer = Color(0xFFFFFFFF);
  static const _tertiaryLight = Color(0xFF81C784);
  static const _tertiaryDark = Color(0xFF2E7D32);
  static const _tertiaryVariant = Color(0xFF1B5E20);

  // Error colors
  static const _error = Color(0xFFF44336); // Material Red
  static const _onError = Color(0xFFFFFFFF);
  static const _errorContainer = Color(0xFFD32F2F);
  static const _onErrorContainer = Color(0xFFFFFFFF);
  static const _errorLight = Color(0xFFE57373);
  static const _errorDark = Color(0xFFC62828);

  // Warning colors
  static const _warning = Color(0xFFFF9800);
  static const _onWarning = Color(0xFF000000);
  static const _warningContainer = Color(0xFFF57C00);
  static const _onWarningContainer = Color(0xFFFFFFFF);

  // Success colors
  static const _success = Color(0xFF00C853);
  static const _onSuccess = Color(0xFFFFFFFF);
  static const _successContainer = Color(0xFF00B248);
  static const _onSuccessContainer = Color(0xFFFFFFFF);

  // Info colors
  static const _info = Color(0xFF00B8D4);
  static const _onInfo = Color(0xFFFFFFFF);
  static const _infoContainer = Color(0xFF0091A8);
  static const _onInfoContainer = Color(0xFFFFFFFF);

  // Neutral colors
  static const _background = Color(0xFFFAFAFA);
  static const _onBackground = Color(0xFF212121);
  static const _surface = Color(0xFFFFFFFF);
  static const _onSurface = Color(0xFF212121);
  static const _surfaceLight = Color(0xFFFEFEFE);
  static const _surfaceDark = Color(0xFFF5F5F5);

  // Additional colors
  static const _neutral50 = Color(0xFFFAFAFA);
  static const _neutral100 = Color(0xFFF5F5F5);
  static const _neutral200 = Color(0xFFEEEEEE);
  static const _neutral300 = Color(0xFFE0E0E0);
  static const _neutral400 = Color(0xFFBDBDBD);
  static const _neutral500 = Color(0xFF9E9E9E);
  static const _neutral600 = Color(0xFF757575);
  static const _neutral700 = Color(0xFF616161);
  static const _neutral800 = Color(0xFF424242);
  static const _neutral900 = Color(0xFF212121);

  // Accent colors
  static const _accent1 = Color(0xFFFF4081); // Pink
  static const _accent2 = Color(0xFF7C4DFF); // Deep Purple
  static const _accent3 = Color(0xFF00BFA5); // Teal
  static const _accent4 = Color(0xFFFFAB00); // Amber

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
    accent: _accent1,
    accentLight: _withOpacity(_accent1, 0.8),
    accentDark: _accent1.withBlue(180),
    divider: _withOpacity(_onSurface, 0.12),
    cardColor: _surface,
    dialogBackgroundColor: _surface,
    disabledColor: _withOpacity(_onSurface, 0.38),
    focusColor: _withOpacity(_primary, 0.12),
    hintColor: _withOpacity(_onSurface, 0.6),
    hoverColor: _withOpacity(_primary, 0.04),
    indicatorColor: _primary,
    scaffoldBackgroundColor: _background,
    secondaryHeaderColor: _withOpacity(_secondary, 0.1),
    selectedRowColor: _withOpacity(_primary, 0.08),
    splashColor: _withOpacity(_primary, 0.08),
    unselectedWidgetColor: _withOpacity(_onSurface, 0.54),
    textPrimary: _onSurface,
    textSecondary: _withOpacity(_onSurface, 0.7),
    textHint: _withOpacity(_onSurface, 0.5),
    textDisabled: _withOpacity(_onSurface, 0.38),
    textSelectionColor: _withOpacity(_primary, 0.3),
    textSelectionHandleColor: _primary,
    hoverStateColor: _withOpacity(_primary, 0.08),
    focusStateColor: _withOpacity(_primary, 0.12),
    highlightColor: _withOpacity(_primary, 0.08),
    splashStateColor: _withOpacity(_primary, 0.08),
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
    button: GoogleFonts.inter(
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
