import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/settings_constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../widgets/settings/settings_tile.dart';

class AppSettingsSection extends ConsumerWidget {
  const AppSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final sectionContent =
        SettingsConstants.sectionContent['App Settings'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'App Settings',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.data_saver_off_outlined),
          titleWidget: const Text('Data Saver'),
          subtitleWidget: const Text('Reduce data usage while using the app'),
          value: settings.dataSaverEnabled,
          onChanged: (value) => settingsNotifier.setDataSaver(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.refresh_outlined),
          titleWidget: const Text('Background Refresh'),
          subtitleWidget:
              const Text('Allow app to refresh content in the background'),
          value: settings.backgroundRefresh,
          onChanged: (value) => settingsNotifier.setBackgroundRefresh(value),
        ),
        const Divider(),
        SettingsTile(
          leading: const Icon(Icons.cleaning_services_outlined),
          titleWidget: const Text('Clear Cache'),
          subtitleWidget: const Text('Clear temporary files and cached data'),
          onTap: () async {
            await settingsNotifier.clearCache();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            }
          },
        ),
        SettingsTile(
          leading: const Icon(Icons.developer_mode_outlined),
          titleWidget: const Text('Developer Mode'),
          subtitleWidget: const Text('Enable advanced features for developers'),
          value: settings.developerMode,
          onChanged: (value) => settingsNotifier.setDeveloperMode(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.import_export_outlined),
          titleWidget: const Text('Export Settings'),
          subtitleWidget: const Text('Export your settings to a file'),
          onTap: () async {
            await settingsNotifier.exportSettings();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings exported successfully')),
              );
            }
          },
        ),
      ],
    );
  }
}
