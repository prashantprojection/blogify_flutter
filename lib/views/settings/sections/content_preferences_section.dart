import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/settings_constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../widgets/settings/settings_tile.dart';

class ContentPreferencesSection extends ConsumerWidget {
  const ContentPreferencesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final sectionContent =
        SettingsConstants.sectionContent['Content Preferences'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Content Preferences',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // Media Settings
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Media Settings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.play_circle_outline),
          titleWidget: const Text('Auto-play Videos'),
          subtitleWidget:
              const Text('Play videos automatically while scrolling'),
          value: settings.getValue(ContentType.autoPlayVideos.key, true),
          onChanged: (value) => settingsNotifier.setContentPreference(
              ContentType.autoPlayVideos, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.warning_amber_outlined),
          titleWidget: const Text('Show NSFW Content'),
          subtitleWidget: const Text('Display sensitive or adult content'),
          value: settings.getValue(ContentType.showNSFWContent.key, false),
          onChanged: (value) => settingsNotifier.setContentPreference(
              ContentType.showNSFWContent, value),
        ),
        const Divider(),
        // Reading Experience
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Reading Experience',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.timer_outlined),
          titleWidget: const Text('Show Reading Time'),
          subtitleWidget:
              const Text('Display estimated reading time for posts'),
          value: settings.getValue(ContentType.showReadingTime.key, true),
          onChanged: (value) => settingsNotifier.setContentPreference(
              ContentType.showReadingTime, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.menu_book_outlined),
          titleWidget: const Text('Reader Mode'),
          subtitleWidget: const Text('Enable distraction-free reading'),
          value: settings.getValue(ContentType.readerMode.key, false),
          onChanged: (value) => settingsNotifier.setContentPreference(
              ContentType.readerMode, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.bookmark_outline),
          titleWidget: const Text('Save Reading Progress'),
          subtitleWidget: const Text('Remember where you left off in posts'),
          value: settings.getValue(ContentType.saveReadingProgress.key, true),
          onChanged: (value) => settingsNotifier.setContentPreference(
              ContentType.saveReadingProgress, value),
        ),
        SettingsTile.expandable(
          leading: const Icon(Icons.text_fields_outlined),
          titleWidget: const Text('Text Size'),
          subtitleWidget: const Text('Adjust the size of text in posts'),
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
      ],
    );
  }
}
