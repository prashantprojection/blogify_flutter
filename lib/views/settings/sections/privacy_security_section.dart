import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/settings_constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../widgets/settings/settings_tile.dart';

class PrivacySecuritySection extends ConsumerWidget {
  const PrivacySecuritySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final sectionContent =
        SettingsConstants.sectionContent['Privacy & Security'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Privacy & Security',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // Account Security
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Account Security',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.security_outlined),
          titleWidget: const Text('Two-Factor Authentication'),
          subtitleWidget: const Text('Add an extra layer of security'),
          value: settings.twoFactorEnabled,
          onChanged: (value) => settingsNotifier.setTwoFactorAuth(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.verified_user_outlined),
          titleWidget: const Text('Security Checkup'),
          subtitleWidget: const Text('Review your account security'),
          onTap: () => settingsNotifier
              .performSecurityAction(SecurityAction.securityCheckup),
        ),
        SettingsTile(
          leading: const Icon(Icons.restore_outlined),
          titleWidget: const Text('Recovery Options'),
          subtitleWidget: const Text('Set up account recovery methods'),
          onTap: () => settingsNotifier
              .performSecurityAction(SecurityAction.recoveryOptions),
        ),
        const Divider(),
        // Privacy Settings
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Privacy Settings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.person_outline),
          titleWidget: const Text('Profile Privacy'),
          subtitleWidget: const Text('Control who can see your profile'),
          value: settings.privateProfile,
          onChanged: (value) => settingsNotifier.setPrivateProfile(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.post_add_outlined),
          titleWidget: const Text('Post Privacy'),
          subtitleWidget: const Text('Set default privacy for new posts'),
          value: settings.privatePostsEnabled,
          onChanged: (value) => settingsNotifier.setPrivatePosts(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.circle_outlined),
          titleWidget: const Text('Activity Status'),
          subtitleWidget: const Text('Show when you\'re active'),
          value: settings.activityStatusEnabled,
          onChanged: (value) => settingsNotifier.setActivityStatus(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.mark_email_read_outlined),
          titleWidget: const Text('Read Receipts'),
          subtitleWidget: const Text('Show when you\'ve read messages'),
          value: settings.readReceiptsEnabled,
          onChanged: (value) => settingsNotifier.setReadReceipts(value),
        ),
        const Divider(),
        // Data & Personalization
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Data & Personalization',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.data_usage_outlined),
          titleWidget: const Text('Data Collection'),
          subtitleWidget: const Text('Manage how we collect and use your data'),
          value: settings.dataCollectionEnabled,
          onChanged: (value) => settingsNotifier.setDataCollection(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.apps_outlined),
          titleWidget: const Text('Third-Party Access'),
          subtitleWidget: const Text('Control app access to your data'),
          value: settings.thirdPartyAccessEnabled,
          onChanged: (value) => settingsNotifier.setThirdPartyAccess(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.ads_click_outlined),
          titleWidget: const Text('Personalized Ads'),
          subtitleWidget: const Text('Allow personalized advertising'),
          value: settings.personalizedAdsEnabled,
          onChanged: (value) => settingsNotifier.setPersonalizedAds(value),
        ),
        const Divider(),
        // Blocking & Filtering
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Blocking & Filtering',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.block_outlined),
          titleWidget: const Text('Blocked Users'),
          subtitleWidget: const Text('Manage your blocked users list'),
          onTap: () => settingsNotifier
              .performSecurityAction(SecurityAction.manageBlockedUsers),
        ),
        SettingsTile(
          leading: const Icon(Icons.filter_alt_outlined),
          titleWidget: const Text('Content Filters'),
          subtitleWidget: const Text('Set filters for sensitive content'),
          onTap: () => settingsNotifier
              .performSecurityAction(SecurityAction.manageContentFilters),
        ),
        const Divider(),
        // Security Alerts
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Security Alerts',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.login_outlined),
          titleWidget: const Text('Login Alerts'),
          subtitleWidget: const Text('Get notified about new sign-ins'),
          value: settings.loginAlertsEnabled,
          onChanged: (value) => settingsNotifier.setLoginAlerts(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.warning_amber_outlined),
          titleWidget: const Text('Suspicious Activity'),
          subtitleWidget:
              const Text('Get alerts about unusual account activity'),
          value: settings.suspiciousActivityAlertsEnabled,
          onChanged: (value) =>
              settingsNotifier.setSuspiciousActivityAlerts(value),
        ),
      ],
    );
  }
}
