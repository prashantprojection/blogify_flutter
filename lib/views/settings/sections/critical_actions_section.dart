import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/settings_constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../widgets/settings/settings_tile.dart';

class CriticalActionsSection extends ConsumerWidget {
  const CriticalActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final sectionContent =
        SettingsConstants.sectionContent['Critical Actions'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Critical Actions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
        // Warning
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Warning',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
        SettingsTile(
          leading: Icon(Icons.warning_amber_outlined,
              color: Theme.of(context).colorScheme.error),
          titleWidget: Text('Enable Critical Actions',
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
          subtitleWidget: const Text('Allow potentially dangerous actions'),
          value: settings.criticalActionsEnabled,
          onChanged: (value) =>
              settingsNotifier.setCriticalActionsEnabled(value),
        ),
        const Divider(),
        // Danger Zone
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Danger Zone',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
        SettingsTile(
          leading: Icon(Icons.delete_forever_outlined,
              color: Theme.of(context).colorScheme.error),
          titleWidget: Text('Delete Account',
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
          subtitleWidget:
              const Text('Permanently delete your account and all data'),
          onTap: settings.criticalActionsEnabled
              ? () => settingsNotifier
                  .performCriticalAction(CriticalAction.deleteAccount)
              : null,
        ),
      ],
    );
  }
}
