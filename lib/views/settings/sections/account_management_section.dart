import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/settings_constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../widgets/settings/settings_tile.dart';

class AccountManagementSection extends ConsumerWidget {
  const AccountManagementSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final sectionContent =
        SettingsConstants.sectionContent['Account Management'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Account Management',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // Connected Accounts
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Connected Accounts',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.account_circle_outlined),
          titleWidget: const Text('Connect Google'),
          subtitleWidget: const Text('Link your Google account'),
          onTap: () => settingsNotifier
              .performAccountAction(AccountAction.connectGoogle),
        ),
        SettingsTile(
          leading: const Icon(Icons.facebook_outlined),
          titleWidget: const Text('Connect Facebook'),
          subtitleWidget: const Text('Link your Facebook account'),
          onTap: () => settingsNotifier
              .performAccountAction(AccountAction.connectFacebook),
        ),
        SettingsTile(
          leading: const Icon(Icons.alternate_email_outlined),
          titleWidget: const Text('Connect Twitter'),
          subtitleWidget: const Text('Link your Twitter account'),
          onTap: () => settingsNotifier
              .performAccountAction(AccountAction.connectTwitter),
        ),
        const Divider(),
        // Account Status
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Account Status',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.verified_outlined),
          titleWidget: const Text('Account Verification'),
          subtitleWidget: const Text('Verify your account'),
          onTap: () => settingsNotifier
              .performAccountAction(AccountAction.verifyAccount),
        ),
        SettingsTile(
          leading: const Icon(Icons.analytics_outlined),
          titleWidget: const Text('Account Analytics'),
          subtitleWidget: const Text('View your account statistics'),
          onTap: () => settingsNotifier
              .performAccountAction(AccountAction.viewAnalytics),
        ),
        SettingsTile(
          leading: const Icon(Icons.history_outlined),
          titleWidget: const Text('Account History'),
          subtitleWidget: const Text('View your account activity'),
          onTap: () =>
              settingsNotifier.performAccountAction(AccountAction.viewHistory),
        ),
        const Divider(),
        // Premium Features
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Premium Features',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.workspace_premium_outlined),
          titleWidget: const Text('Upgrade to Premium'),
          subtitleWidget: const Text('Get access to premium features'),
          onTap: () => settingsNotifier
              .performAccountAction(AccountAction.upgradePremium),
        ),
        SettingsTile(
          leading: const Icon(Icons.payment_outlined),
          titleWidget: const Text('Manage Billing'),
          subtitleWidget: const Text('View and update billing information'),
          onTap: () => settingsNotifier
              .performAccountAction(AccountAction.manageBilling),
        ),
        SettingsTile(
          leading: const Icon(Icons.subscriptions_outlined),
          titleWidget: const Text('Subscription History'),
          subtitleWidget: const Text('View your subscription details'),
          onTap: () => settingsNotifier
              .performAccountAction(AccountAction.viewSubscription),
        ),
      ],
    );
  }
}
