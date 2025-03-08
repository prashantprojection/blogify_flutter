import '../models/theme_palette.dart';
import 'modern_theme.dart';
import 'vintage_jewelry_theme.dart';
import 'elegant_theme.dart';
import 'fitness_theme.dart';
import 'fitness_pro_theme.dart';
import 'gold_age_theme.dart';
import 'nautical_theme.dart';
import 'news_theme.dart';
import 'eye_comfort_theme.dart';
import 'windows_theme.dart';
import 'default_theme.dart';

/// A registry of all available themes in the application
class ThemeRegistry {
  static final List<String> _themeIds = [
    'default',
    'modern',
    'vintage_jewelry',
    'elegant',
    'fitness',
    'fitness_pro',
    'gold_age',
    'nautical',
    'news',
    'eye_comfort',
    'windows',
  ];

  /// Get a theme by its ID
  static ThemePalette getTheme(String themeId) {
    switch (themeId) {
      case 'default':
        return DefaultTheme.theme;
      case 'modern':
        return ModernTheme.theme;
      case 'vintage_jewelry':
        return VintageJewelryTheme.theme;
      case 'elegant':
        return ElegantTheme.theme;
      case 'fitness':
        return FitnessTheme.theme;
      case 'fitness_pro':
        return FitnessProTheme.theme;
      case 'gold_age':
        return GoldAgeTheme.theme;
      case 'nautical':
        return NauticalTheme.theme;
      case 'news':
        return NewsTheme.theme;
      case 'eye_comfort':
        return EyeComfortTheme.theme;
      case 'windows':
        return WindowsTheme.theme;
      default:
        return DefaultTheme.theme;
    }
  }

  /// Get all available themes
  static List<String> get availableThemes => List.unmodifiable(_themeIds);

  /// Get the default theme
  static ThemePalette get defaultTheme => DefaultTheme.theme;

  /// Check if a theme exists
  static bool hasTheme(String themeId) => _themeIds.contains(themeId);
}
