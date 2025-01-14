import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/models/theme_palette.dart';
import 'package:blogify_flutter/theme/theme_registry.dart';

// Simple provider for current theme ID
final currentThemeIdProvider = StateProvider<String>((ref) => 'default');

// Provider for theme data
final themeProvider = Provider<ThemePalette>((ref) {
  final String themeId = ref.watch(currentThemeIdProvider);
  final ThemePalette theme = ThemeRegistry.getTheme(themeId);
  return theme;
});

// Controller for managing the application theme
class ThemeController {
  final StateController<String> _currentThemeId;

  ThemeController(this._currentThemeId);

  void setTheme(String themeId) {
    if (ThemeRegistry.hasTheme(themeId)) {
      _currentThemeId.state = themeId;
    }
  }

  String get currentThemeId => _currentThemeId.state;

  List<String> get availableThemes => ThemeRegistry.availableThemes;

  ThemePalette getTheme(String themeId) => ThemeRegistry.getTheme(themeId);

  bool hasTheme(String themeId) => ThemeRegistry.hasTheme(themeId);
}
