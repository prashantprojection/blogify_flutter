import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/settings_constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../widgets/settings/settings_tile.dart';

class HelpSupportSection extends ConsumerWidget {
  const HelpSupportSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final sectionContent =
        SettingsConstants.sectionContent['Help & Support'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Help & Support',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // Help Resources
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Help Resources',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.help_outline),
          titleWidget: const Text('FAQ'),
          subtitleWidget: const Text('Find answers to common questions'),
          onTap: () => settingsNotifier.performHelpAction(HelpAction.openFAQ),
        ),
        SettingsTile(
          leading: const Icon(Icons.menu_book_outlined),
          titleWidget: const Text('User Guide'),
          subtitleWidget: const Text('Learn how to use the app'),
          onTap: () =>
              settingsNotifier.performHelpAction(HelpAction.openUserGuide),
        ),
        SettingsTile(
          leading: const Icon(Icons.play_circle_outline),
          titleWidget: const Text('Video Tutorials'),
          subtitleWidget: const Text('Watch helpful tutorials'),
          onTap: () =>
              settingsNotifier.performHelpAction(HelpAction.openTutorials),
        ),
        const Divider(),
        // Contact Us
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Contact Us',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.support_agent_outlined),
          titleWidget: const Text('Contact Support'),
          subtitleWidget: const Text('Get help from our support team'),
          onTap: () =>
              settingsNotifier.performHelpAction(HelpAction.contactSupport),
        ),
        SettingsTile(
          leading: const Icon(Icons.chat_outlined),
          titleWidget: const Text('Live Chat'),
          subtitleWidget: const Text('Chat with our support team'),
          onTap: () =>
              settingsNotifier.performHelpAction(HelpAction.openLiveChat),
        ),
        SettingsTile(
          leading: const Icon(Icons.confirmation_number_outlined),
          titleWidget: const Text('Support Tickets'),
          subtitleWidget: const Text('View your support tickets'),
          onTap: () =>
              settingsNotifier.performHelpAction(HelpAction.viewTickets),
        ),
        const Divider(),
        // Feedback
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Feedback',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.bug_report_outlined),
          titleWidget: const Text('Report a Bug'),
          subtitleWidget: const Text('Help us improve the app'),
          onTap: () => settingsNotifier.performHelpAction(HelpAction.reportBug),
        ),
        SettingsTile(
          leading: const Icon(Icons.lightbulb_outline),
          titleWidget: const Text('Feature Request'),
          subtitleWidget: const Text('Suggest new features'),
          onTap: () =>
              settingsNotifier.performHelpAction(HelpAction.requestFeature),
        ),
        SettingsTile(
          leading: const Icon(Icons.star_outline),
          titleWidget: const Text('Rate the App'),
          subtitleWidget: const Text('Share your experience'),
          onTap: () => settingsNotifier.performHelpAction(HelpAction.rateApp),
        ),
      ],
    );
  }
}
