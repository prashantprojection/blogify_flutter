import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/models/theme_palette.dart';
import 'package:blogify_flutter/theme/theme_registry.dart';

// Simple provider for current theme ID
final currentThemeIdProvider = StateProvider<String>((ref) => 'fitness_pro');

// Provider for theme data
final themeProvider = Provider<ThemePalette>((ref) {
  final String themeId = ref.watch(currentThemeIdProvider);
  final ThemePalette theme = ThemeRegistry.getTheme(themeId);
  return theme;
});

// Provider for theme preview
final themePreviewProvider = StateProvider<String?>((ref) => null);

// Provider for available themes with metadata
final availableThemesProvider = Provider<List<ThemeMetadata>>((ref) {
  return ThemeRegistry.availableThemes.map((themeId) {
    final theme = ThemeRegistry.getTheme(themeId);
    return ThemeMetadata(
      id: themeId,
      name: theme.name,
    );
  }).toList();
});

class ThemeMetadata {
  final String id;
  final String name;

  const ThemeMetadata({
    required this.id,
    required this.name,
  });
}

// Controller for managing the application theme
class ThemeController {
  final StateController<String> _currentThemeId;
  final StateController<String?> _previewThemeId;

  ThemeController(this._currentThemeId, this._previewThemeId);

  void setTheme(String themeId) {
    if (ThemeRegistry.hasTheme(themeId)) {
      _currentThemeId.state = themeId;
      _previewThemeId.state = null; // Clear preview when theme is set
    }
  }

  void previewTheme(String? themeId) {
    _previewThemeId.state = themeId;
  }

  void applyPreviewTheme() {
    if (_previewThemeId.state != null) {
      setTheme(_previewThemeId.state!);
    }
  }

  String get currentThemeId => _currentThemeId.state;
  String? get previewThemeId => _previewThemeId.state;
  List<String> get availableThemes => ThemeRegistry.availableThemes;
  ThemePalette getTheme(String themeId) => ThemeRegistry.getTheme(themeId);
  bool hasTheme(String themeId) => ThemeRegistry.hasTheme(themeId);
}
