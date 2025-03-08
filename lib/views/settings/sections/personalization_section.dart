import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/settings_constants.dart';
import '../../../controllers/settings_controller.dart';
import '../theme_browser_view.dart';
import '../../../widgets/settings/settings_tile.dart';

class PersonalizationSection extends ConsumerWidget {
  const PersonalizationSection({super.key});

  void _showThemeBrowser(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: ThemeBrowserView(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final currentTheme = ref.watch(themeProvider);
    final currentThemeId = ref.watch(currentThemeIdProvider);
    final themes = ref.watch(availableThemesProvider);
    final currentThemeData = themes.firstWhere((t) => t.id == currentThemeId);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Personalization',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          // Theme Settings
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Theme Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SettingsTile(
            leading: const Icon(Icons.style_outlined),
            titleWidget: const Text('Theme Browser'),
            subtitleWidget: const Text('Browse and customize themes'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: currentTheme.colors.onSurfaceVariant,
            ),
            onTap: () => _showThemeBrowser(context),
          ),
          SettingsTile(
            leading: const Icon(Icons.dark_mode_outlined),
            titleWidget: const Text('Dark Mode'),
            subtitleWidget: const Text('Enable dark theme for the app'),
            value: settings.isDarkMode,
            onChanged: (value) => settingsNotifier.setDarkMode(value),
          ),
          SettingsTile(
            leading: const Icon(Icons.auto_awesome_outlined),
            titleWidget: const Text('Background Effects'),
            subtitleWidget:
                const Text('Enable visual effects in the background'),
            value: settings.backgroundEffects,
            onChanged: (value) => settingsNotifier.setBackgroundEffects(value),
          ),
          const Divider(),
          // Text Settings
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Text Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SettingsTile.expandable(
            leading: const Icon(Icons.text_fields_outlined),
            titleWidget: const Text('Text Size'),
            subtitleWidget:
                const Text('Adjust the size of text throughout the app'),
            expandedContent: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => settingsNotifier.decreaseTextSize(),
                  ),
                  Text('${settings.textSize.toStringAsFixed(1)}x'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => settingsNotifier.increaseTextSize(),
                  ),
                ],
              ),
            ),
          ),
          SettingsTile(
            leading: const Icon(Icons.contrast_outlined),
            titleWidget: const Text('High Contrast'),
            subtitleWidget:
                const Text('Increase contrast for better readability'),
            value: settings.highContrast,
            onChanged: (value) => settingsNotifier.setHighContrast(value),
          ),
        ],
      ),
    );
  }
}
