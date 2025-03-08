import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/settings_constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../widgets/settings/settings_tile.dart';

class NotificationsSection extends ConsumerWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final sectionContent =
        SettingsConstants.sectionContent['Notifications'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Notifications',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // Notification Channels
        SettingsTile(
          leading: const Icon(Icons.notifications_outlined),
          titleWidget: const Text('Enable Notifications'),
          subtitleWidget: const Text('Allow app to send notifications'),
          value: settings.notificationsEnabled,
          onChanged: (value) => settingsNotifier.setNotificationsEnabled(value),
        ),
        SettingsTile(
          leading: const Icon(Icons.notifications_active_outlined),
          titleWidget: const Text('Push Notifications'),
          subtitleWidget: const Text('Receive instant push notifications'),
          value: settings.getValue(NotificationType.push.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.push, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.email_outlined),
          titleWidget: const Text('Email Notifications'),
          subtitleWidget: const Text('Receive notifications via email'),
          value: settings.getValue(NotificationType.email.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.email, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.web_outlined),
          titleWidget: const Text('Browser Notifications'),
          subtitleWidget: const Text('Receive notifications in your browser'),
          value: settings.getValue(NotificationType.browser.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.browser, value),
        ),
        const Divider(),
        // Content Notifications
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Content Notifications',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.article_outlined),
          titleWidget: const Text('New Posts'),
          subtitleWidget: const Text('Get notified about new posts'),
          value: settings.getValue(NotificationType.newPost.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.newPost, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.comment_outlined),
          titleWidget: const Text('Comments'),
          subtitleWidget:
              const Text('Get notified about comments on your posts'),
          value: settings.getValue(NotificationType.comment.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.comment, value),
        ),
        const Divider(),
        // Social Notifications
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Social Notifications',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.alternate_email_outlined),
          titleWidget: const Text('Mentions'),
          subtitleWidget: const Text('Get notified when someone mentions you'),
          value: settings.getValue(NotificationType.mention.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.mention, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.thumb_up_outlined),
          titleWidget: const Text('Reactions'),
          subtitleWidget:
              const Text('Get notified about reactions to your posts'),
          value: settings.getValue(NotificationType.reaction.key, true),
          onChanged: (value) => settingsNotifier.setNotification(
              NotificationType.reaction, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.person_add_outlined),
          titleWidget: const Text('Followers'),
          subtitleWidget: const Text('Get notified about new followers'),
          value: settings.getValue(NotificationType.follower.key, true),
          onChanged: (value) => settingsNotifier.setNotification(
              NotificationType.follower, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.message_outlined),
          titleWidget: const Text('Messages'),
          subtitleWidget: const Text('Get notified about new messages'),
          value: settings.getValue(NotificationType.message.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.message, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.group_outlined),
          titleWidget: const Text('Community'),
          subtitleWidget: const Text('Get notified about community activity'),
          value: settings.getValue(NotificationType.community.key, true),
          onChanged: (value) => settingsNotifier.setNotification(
              NotificationType.community, value),
        ),
        const Divider(),
        // Marketing Notifications
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Marketing Notifications',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SettingsTile(
          leading: const Icon(Icons.update_outlined),
          titleWidget: const Text('Updates'),
          subtitleWidget: const Text('Get notified about app updates'),
          value: settings.getValue(NotificationType.update.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.update, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.mail_outline),
          titleWidget: const Text('Newsletter'),
          subtitleWidget: const Text('Receive our newsletter'),
          value: settings.getValue(NotificationType.newsletter.key, true),
          onChanged: (value) => settingsNotifier.setNotification(
              NotificationType.newsletter, value),
        ),
        SettingsTile(
          leading: const Icon(Icons.local_offer_outlined),
          titleWidget: const Text('Offers'),
          subtitleWidget: const Text('Get notified about special offers'),
          value: settings.getValue(NotificationType.offer.key, true),
          onChanged: (value) =>
              settingsNotifier.setNotification(NotificationType.offer, value),
        ),
      ],
    );
  }
}
