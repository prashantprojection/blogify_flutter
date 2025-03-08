import 'package:blogify_flutter/widgets/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/constants/settings_constants.dart';
import 'package:blogify_flutter/controllers/settings_controller.dart';

class AboutLegalSection extends ConsumerWidget {
  const AboutLegalSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final sectionContent =
        SettingsConstants.sectionContent['About & Legal'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'About & Legal',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // About
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'About',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.info_outline),
          titleWidget: const Text('About Blogify'),
          subtitleWidget: const Text('Learn more about our platform'),
          onTap: () =>
              settingsNotifier.performLegalAction(LegalAction.aboutBlogify),
        ),
        SettingsTile(
          leading: const Icon(Icons.new_releases_outlined),
          titleWidget: const Text('What\'s New'),
          subtitleWidget: const Text('See recent updates and changes'),
          onTap: () =>
              settingsNotifier.performLegalAction(LegalAction.whatsNew),
        ),
        SettingsTile(
          leading: const Icon(Icons.people_outline),
          titleWidget: const Text('Credits'),
          subtitleWidget: const Text('View contributors and acknowledgments'),
          onTap: () => settingsNotifier.performLegalAction(LegalAction.credits),
        ),
        const Divider(),
        // Legal Documents
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Legal Documents',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.description_outlined),
          titleWidget: const Text('Terms of Service'),
          subtitleWidget: const Text('Read our terms and conditions'),
          onTap: () =>
              settingsNotifier.performLegalAction(LegalAction.termsOfService),
        ),
        SettingsTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          titleWidget: const Text('Privacy Policy'),
          subtitleWidget: const Text('Learn how we handle your data'),
          onTap: () =>
              settingsNotifier.performLegalAction(LegalAction.privacyPolicy),
        ),
        SettingsTile(
          leading: const Icon(Icons.cookie_outlined),
          titleWidget: const Text('Cookie Policy'),
          subtitleWidget: const Text('Understand our use of cookies'),
          onTap: () =>
              settingsNotifier.performLegalAction(LegalAction.cookiePolicy),
        ),
        const Divider(),
        // Licenses
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Licenses',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.source_outlined),
          titleWidget: const Text('Open Source Licenses'),
          subtitleWidget: const Text('View third-party licenses'),
          onTap: () => settingsNotifier
              .performLegalAction(LegalAction.openSourceLicenses),
        ),
        SettingsTile(
          leading: const Icon(Icons.verified_outlined),
          titleWidget: const Text('Software Licenses'),
          subtitleWidget: const Text('View software licensing information'),
          onTap: () =>
              settingsNotifier.performLegalAction(LegalAction.softwareLicenses),
        ),
        SettingsTile(
          leading: const Icon(Icons.copyright_outlined),
          titleWidget: const Text('Content Licenses'),
          subtitleWidget: const Text('View content licensing information'),
          onTap: () =>
              settingsNotifier.performLegalAction(LegalAction.contentLicenses),
        ),
      ],
    );
  }
}
