import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/inputs/search_box.dart';
import 'package:blogify_flutter/widgets/common/cards/hoverable_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final hoverStateProvider =
    StateProvider.family<bool, int>((ref, index) => false);

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  bool _isDarkMode = false;
  double _textSize = 1.0;
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _highContrastMode = false;
  bool _twoFactorEnabled = false;
  bool _autoSaveDrafts = true;
  bool _criticalActionsEnabled = false;
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Profile',
      'icon': IconsaxPlusBold.user,
      'isProfile': true,
    },
    {
      'title': 'Account Management',
      'icon': IconsaxPlusBold.user,
    },
    {
      'title': 'Content Preferences',
      'icon': IconsaxPlusBold.document,
    },
    {
      'title': 'Notifications',
      'icon': IconsaxPlusBold.notification,
    },
    {
      'title': 'Privacy & Security',
      'icon': IconsaxPlusBold.security,
    },
    {
      'title': 'App Settings',
      'icon': IconsaxPlusBold.setting,
    },
    {
      'title': 'Help & Support',
      'icon': IconsaxPlusBold.info_circle,
    },
    {
      'title': 'About & Legal',
      'icon': IconsaxPlusBold.information,
    },
    {
      'title': 'Critical Actions',
      'icon': IconsaxPlusBold.danger,
    },
  ];

  Widget _buildTabContent(int index) {
    if (_sections[index]['isProfile'] == true) {
      return Column(
        children: [
          _buildProfileSection(),
          const SizedBox(height: 32),
        ],
      );
    }

    switch (_sections[index]['title']) {
      case 'Account Management':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Security Settings',
              icon: IconsaxPlusBold.security_safe,
              children: [
                _buildSettingTile(
                  title: 'Change Password',
                  subtitle: 'Last changed 3 months ago',
                  icon: Icons.lock_outline,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Login History',
                  subtitle: 'View your recent login activities',
                  icon: Icons.history,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Active Sessions',
                  subtitle: 'Manage devices where you\'re logged in',
                  icon: Icons.devices,
                  onTap: () {},
                ),
                _buildSwitchTile(
                  title: 'Biometric Login',
                  subtitle: 'Use fingerprint or face recognition',
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Connected Accounts',
              icon: IconsaxPlusBold.link,
              children: [
                _buildSettingTile(
                  title: 'Social Accounts',
                  subtitle: 'Manage connected social media accounts',
                  icon: Icons.share,
                  onTap: () {},
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 64, right: 24, bottom: 16),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.google,
                          size: 18, color: Colors.grey.shade700),
                      const SizedBox(width: 16),
                      Icon(FontAwesomeIcons.github,
                          size: 18, color: Colors.grey.shade700),
                      const SizedBox(width: 16),
                      Icon(FontAwesomeIcons.apple,
                          size: 18, color: Colors.grey.shade700),
                    ],
                  ),
                ),
                _buildSettingTile(
                  title: 'Email Addresses',
                  subtitle: 'Add or remove email addresses',
                  icon: Icons.email_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Phone Numbers',
                  subtitle: 'Add or verify phone numbers',
                  icon: Icons.phone_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Account Verification',
              icon: IconsaxPlusBold.verify,
              children: [
                _buildSettingTile(
                  title: 'Verify Account',
                  subtitle: 'Get a verified badge',
                  icon: Icons.verified_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Professional Account',
                  subtitle: 'Switch to a professional account',
                  icon: Icons.work_outline,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Account Status',
                  subtitle: 'View your account standing',
                  icon: Icons.analytics_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Data Management',
              icon: IconsaxPlusBold.document_download,
              children: [
                _buildSettingTile(
                  title: 'Download Your Data',
                  subtitle: 'Get a copy of your data',
                  icon: Icons.download_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Data Usage',
                  subtitle: 'Manage how your data is used',
                  icon: Icons.data_usage,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Account Backup',
                  subtitle: 'Back up your account settings',
                  icon: Icons.backup_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      case 'Content Preferences':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Reading Preferences',
              icon: IconsaxPlusBold.book,
              children: [
                _buildSettingTile(
                  title: 'Reading List',
                  subtitle: 'Manage your saved articles',
                  icon: Icons.bookmark_outline,
                  onTap: () {},
                ),
                _buildSwitchTile(
                  title: 'Offline Reading',
                  subtitle: 'Save articles for offline access',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSettingTile(
                  title: 'Reading History',
                  subtitle: 'View and manage your reading history',
                  icon: Icons.history,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Content Customization',
              icon: IconsaxPlusBold.category,
              children: [
                _buildSettingTile(
                  title: 'Topics of Interest',
                  subtitle: 'Select topics you want to follow',
                  icon: Icons.topic_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Authors',
                  subtitle: 'Manage authors you follow',
                  icon: Icons.person_outline,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Publications',
                  subtitle: 'Manage publications you follow',
                  icon: Icons.newspaper_outlined,
                  onTap: () {},
                ),
                _buildSwitchTile(
                  title: 'Content Discovery',
                  subtitle: 'Get recommendations based on your interests',
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Language & Region',
              icon: IconsaxPlusBold.language_square,
              children: [
                _buildSettingTile(
                  title: 'Content Language',
                  subtitle: 'Choose your preferred content languages',
                  icon: Icons.translate_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Region',
                  subtitle: 'Set your content region',
                  icon: Icons.public_outlined,
                  onTap: () {},
                ),
                _buildSwitchTile(
                  title: 'Auto-Translate',
                  subtitle: 'Automatically translate content',
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Writing & Publishing',
              icon: IconsaxPlusBold.edit,
              children: [
                _buildSwitchTile(
                  title: 'Auto-save Drafts',
                  subtitle: 'Automatically save your drafts',
                  value: _autoSaveDrafts,
                  onChanged: (value) {
                    setState(() => _autoSaveDrafts = value);
                  },
                ),
                _buildSettingTile(
                  title: 'Default Editor Settings',
                  subtitle: 'Configure your writing preferences',
                  icon: Icons.settings_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Publishing Guidelines',
                  subtitle: 'View community guidelines',
                  icon: Icons.gavel_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'SEO Settings',
                  subtitle: 'Manage your content visibility',
                  icon: Icons.trending_up_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      case 'Notifications':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'General Notifications',
              icon: IconsaxPlusBold.notification,
              children: [
                _buildSwitchTile(
                  title: 'Push Notifications',
                  subtitle: 'Receive push notifications',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
                _buildSwitchTile(
                  title: 'Email Notifications',
                  subtitle: 'Receive email updates',
                  value: _emailNotifications,
                  onChanged: (value) {
                    setState(() => _emailNotifications = value);
                  },
                ),
                _buildSwitchTile(
                  title: 'Browser Notifications',
                  subtitle: 'Get notifications in your browser',
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Content Notifications',
              icon: IconsaxPlusBold.document,
              children: [
                _buildSwitchTile(
                  title: 'New Posts from Following',
                  subtitle:
                      'Get notified about new posts from people you follow',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Comments on Your Posts',
                  subtitle: 'Get notified when someone comments on your posts',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Mentions',
                  subtitle: 'Get notified when someone mentions you',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Post Reactions',
                  subtitle: 'Get notified about reactions to your posts',
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Social Notifications',
              icon: IconsaxPlusBold.profile_2user,
              children: [
                _buildSwitchTile(
                  title: 'New Followers',
                  subtitle: 'Get notified when someone follows you',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Direct Messages',
                  subtitle: 'Get notified about new messages',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Community Activity',
                  subtitle: 'Get notified about activity in your communities',
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Updates & Marketing',
              icon: IconsaxPlusBold.chart,
              children: [
                _buildSwitchTile(
                  title: 'Product Updates',
                  subtitle: 'Get notified about new features and improvements',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Newsletter',
                  subtitle: 'Receive our weekly newsletter',
                  value: false,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Special Offers',
                  subtitle: 'Get notified about promotions and special offers',
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Notification Schedule',
              icon: IconsaxPlusBold.timer,
              children: [
                _buildSettingTile(
                  title: 'Quiet Hours',
                  subtitle: 'Set times when notifications are muted',
                  icon: Icons.nights_stay_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Notification Summary',
                  subtitle: 'Get a daily summary of your notifications',
                  icon: Icons.summarize_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Frequency Settings',
                  subtitle: 'Control how often you receive notifications',
                  icon: Icons.tune_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      case 'Privacy & Security':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Account Security',
              icon: IconsaxPlusBold.security,
              badge: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Protected',
                  style: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              children: [
                _buildSwitchTile(
                  title: 'Two-Factor Authentication',
                  subtitle: 'Add an extra layer of security',
                  leadingIcon: Icons.shield_outlined,
                  value: _twoFactorEnabled,
                  onChanged: (value) {
                    setState(() => _twoFactorEnabled = value);
                  },
                ),
                _buildSettingTile(
                  title: 'Security Checkup',
                  subtitle: 'Review your account security',
                  icon: Icons.security_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Recovery Options',
                  subtitle: 'Set up account recovery methods',
                  icon: Icons.restore_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Privacy Controls',
              icon: IconsaxPlusBold.eye,
              children: [
                _buildSettingTile(
                  title: 'Profile Privacy',
                  subtitle: 'Control who can see your profile',
                  icon: Icons.visibility_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Post Privacy',
                  subtitle: 'Manage who can see your posts',
                  icon: Icons.article_outlined,
                  onTap: () {},
                ),
                _buildSwitchTile(
                  title: 'Activity Status',
                  subtitle: 'Show when you\'re active',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Read Receipts',
                  subtitle: 'Show when you\'ve read messages',
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Data Privacy',
              icon: IconsaxPlusBold.lock,
              children: [
                _buildSettingTile(
                  title: 'Data Collection',
                  subtitle: 'Manage how your data is collected',
                  icon: Icons.data_usage_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Third-Party Access',
                  subtitle: 'Control app permissions',
                  icon: Icons.apps_outlined,
                  onTap: () {},
                ),
                _buildSwitchTile(
                  title: 'Personalized Ads',
                  subtitle: 'Control ad personalization',
                  value: false,
                  onChanged: (value) {},
                ),
                _buildSettingTile(
                  title: 'Download Your Data',
                  subtitle: 'Get a copy of your data',
                  icon: Icons.download_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Blocking & Restrictions',
              icon: IconsaxPlusBold.forbidden_2,
              children: [
                _buildSettingTile(
                  title: 'Blocked Users',
                  subtitle: 'Manage blocked accounts',
                  icon: Icons.block_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Muted Users',
                  subtitle: 'Manage muted accounts',
                  icon: Icons.volume_off_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Content Filters',
                  subtitle: 'Control what content you see',
                  icon: Icons.filter_list_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Safety Tools',
              icon: IconsaxPlusBold.shield_tick,
              children: [
                _buildSettingTile(
                  title: 'Login Alerts',
                  subtitle: 'Get notified about new logins',
                  icon: Icons.login_outlined,
                  onTap: () {},
                ),
                _buildSwitchTile(
                  title: 'Suspicious Activity Detection',
                  subtitle: 'Get alerts about unusual activity',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSettingTile(
                  title: 'Safety Center',
                  subtitle: 'Learn about safety features',
                  icon: Icons.health_and_safety_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      case 'App Settings':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Appearance',
              icon: IconsaxPlusBold.brush,
              children: [
                _buildSwitchTile(
                  title: 'Dark Mode',
                  subtitle: 'Enable dark theme',
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() => _isDarkMode = value);
                  },
                ),
                _buildSliderTile(
                  title: 'Text Size',
                  subtitle: 'Adjust the text size',
                  value: _textSize,
                  onChanged: (value) {
                    setState(() => _textSize = value);
                  },
                ),
                _buildSwitchTile(
                  title: 'High Contrast',
                  subtitle: 'Increase visual contrast',
                  value: _highContrastMode,
                  onChanged: (value) {
                    setState(() => _highContrastMode = value);
                  },
                ),
                _buildSettingTile(
                  title: 'Color Theme',
                  subtitle: 'Customize app colors',
                  icon: Icons.palette_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Performance',
              icon: IconsaxPlusBold.cpu,
              children: [
                _buildSwitchTile(
                  title: 'Data Saver',
                  subtitle: 'Reduce data usage',
                  value: false,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Background Refresh',
                  subtitle: 'Keep content up to date',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSettingTile(
                  title: 'Storage',
                  subtitle: 'Manage app storage',
                  icon: Icons.storage_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Clear Cache',
                  subtitle: 'Free up space',
                  icon: Icons.cleaning_services_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Accessibility',
              icon: IconsaxPlusBold.user,
              children: [
                _buildSwitchTile(
                  title: 'Screen Reader',
                  subtitle: 'Enable screen reader support',
                  value: false,
                  onChanged: (value) {},
                ),
                _buildSwitchTile(
                  title: 'Reduce Motion',
                  subtitle: 'Minimize animations',
                  value: false,
                  onChanged: (value) {},
                ),
                _buildSettingTile(
                  title: 'Keyboard Shortcuts',
                  subtitle: 'View and customize shortcuts',
                  icon: Icons.keyboard_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Advanced Settings',
              icon: IconsaxPlusBold.code,
              children: [
                _buildSettingTile(
                  title: 'Developer Options',
                  subtitle: 'Advanced features for developers',
                  icon: Icons.developer_mode_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Export Settings',
                  subtitle: 'Back up your preferences',
                  icon: Icons.upload_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Reset Settings',
                  subtitle: 'Restore default settings',
                  icon: Icons.restore_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      case 'Help & Support':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Help Center',
              icon: IconsaxPlusBold.info_circle,
              children: [
                _buildSettingTile(
                  title: 'Getting Started Guide',
                  subtitle: 'Learn the basics of using Blogify',
                  icon: Icons.school_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'FAQs',
                  subtitle: 'Find answers to common questions',
                  icon: Icons.help_outline_rounded,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Video Tutorials',
                  subtitle: 'Watch helpful tutorials',
                  icon: Icons.play_circle_outline,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Contact Support',
              icon: IconsaxPlusBold.message,
              children: [
                _buildSettingTile(
                  title: 'Chat Support',
                  subtitle: 'Chat with our support team',
                  icon: Icons.chat_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Email Support',
                  subtitle: 'Send us an email',
                  icon: Icons.email_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Support Tickets',
                  subtitle: 'View your support requests',
                  icon: Icons.confirmation_number_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Feedback',
              icon: IconsaxPlusBold.like,
              children: [
                _buildSettingTile(
                  title: 'Report a Bug',
                  subtitle: 'Help us improve by reporting issues',
                  icon: Icons.bug_report_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Feature Request',
                  subtitle: 'Suggest new features',
                  icon: Icons.lightbulb_outline,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Rate the App',
                  subtitle: 'Share your experience',
                  icon: Icons.star_outline,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Community',
              icon: IconsaxPlusBold.people,
              children: [
                _buildSettingTile(
                  title: 'Community Forum',
                  subtitle: 'Connect with other users',
                  icon: Icons.forum_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Knowledge Base',
                  subtitle: 'Browse community articles',
                  icon: Icons.library_books_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Discord Community',
                  subtitle: 'Join our Discord server',
                  icon: FontAwesomeIcons.discord,
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      case 'About & Legal':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'App Information',
              icon: IconsaxPlusBold.information,
              children: [
                _buildSettingTile(
                  title: 'Version',
                  subtitle: 'Version 2.1.0 (Up to date)',
                  icon: Icons.info_outline,
                  onTap: () {},
                  subtitleColor: Colors.green.shade600,
                ),
                _buildSettingTile(
                  title: 'What\'s New',
                  subtitle: 'See latest features and updates',
                  icon: Icons.new_releases_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'About Blogify',
                  subtitle: 'Learn more about us',
                  icon: Icons.business_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Legal Documents',
              icon: IconsaxPlusBold.document,
              children: [
                _buildSettingTile(
                  title: 'Terms of Service',
                  subtitle: 'Read our terms of service',
                  icon: Icons.description_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Privacy Policy',
                  subtitle: 'View our privacy policy',
                  icon: Icons.shield_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Cookie Policy',
                  subtitle: 'Learn about our cookie usage',
                  icon: Icons.cookie_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Content Guidelines',
                  subtitle: 'View content rules and policies',
                  icon: Icons.rule_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Licenses',
              icon: IconsaxPlusBold.verify,
              children: [
                _buildSettingTile(
                  title: 'Open Source Licenses',
                  subtitle: 'View third-party licenses',
                  icon: Icons.source_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Software Licenses',
                  subtitle: 'View software licenses',
                  icon: Icons.file_copy_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Content Licenses',
                  subtitle: 'View content licensing terms',
                  icon: Icons.copyright_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Acknowledgments',
              icon: IconsaxPlusBold.like,
              children: [
                _buildSettingTile(
                  title: 'Contributors',
                  subtitle: 'View project contributors',
                  icon: Icons.people_outline,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Third-Party Services',
                  subtitle: 'View service providers',
                  icon: Icons.integration_instructions_outlined,
                  onTap: () {},
                ),
                _buildSettingTile(
                  title: 'Special Thanks',
                  subtitle: 'View acknowledgments',
                  icon: Icons.favorite_outline,
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      case 'Critical Actions':
        return _buildSection(
          title: 'Critical Actions',
          icon: IconsaxPlusBold.danger,
          badge: Switch(
            value: _criticalActionsEnabled,
            onChanged: (value) {
              setState(() => _criticalActionsEnabled = value);
            },
            activeColor: Colors.red.shade700,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Text(
                'Warning: The following actions are permanent and cannot be undone.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton.icon(
                onPressed: _criticalActionsEnabled ? () {} : null,
                icon: const Icon(Icons.delete_outline, size: 24),
                label: Text(
                  'Delete Account',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade200,
                  disabledForegroundColor: Colors.grey.shade500,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildWebLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left panel - Navigation tabs (30% width)
        Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.24,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: _sections.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 3,
                    thickness: 3,
                    color: Colors.grey.shade100,
                  ),
                  itemBuilder: (context, index) {
                    final section = _sections[index];
                    final isSelected = _selectedTabIndex == index;
                    final isHovered = ref.watch(hoverStateProvider(index));

                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => ref
                          .read(hoverStateProvider(index).notifier)
                          .state = true,
                      onExit: (_) => ref
                          .read(hoverStateProvider(index).notifier)
                          .state = false,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: isHovered
                            ? (Matrix4.identity()
                              ..translate(0, -4)
                              ..scale(1.02))
                            : Matrix4.identity(),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.blue.shade50 : Colors.white,
                          boxShadow: isHovered
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: InkWell(
                          onTap: () =>
                              setState(() => _selectedTabIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: isSelected
                                      ? Colors.blue.shade700
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  section['icon'],
                                  size: 20,
                                  color: isSelected
                                      ? Colors.blue.shade700
                                      : Colors.grey.shade700,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  section['title'],
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.blue.shade700
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // Vertical Divider
        Container(
          width: 1,
          margin: const EdgeInsets.symmetric(vertical: 24),
          color: Colors.grey.shade200,
        ),
        // Right panel - Content (70% width)
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _sections[_selectedTabIndex]['title'],
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getTabDescription(_selectedTabIndex),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 32),
                _buildDetailedTabContent(_selectedTabIndex),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getTabDescription(int index) {
    switch (_sections[index]['title']) {
      case 'Profile':
        return 'Manage your personal information and profile settings';
      case 'Account Management':
        return 'Control your account security and connected services';
      case 'Content Preferences':
        return 'Customize your content experience and preferences';
      case 'Notifications':
        return 'Configure how you want to be notified';
      case 'Privacy & Security':
        return 'Manage your privacy settings and security options';
      case 'App Settings':
        return 'Customize the app appearance and behavior';
      case 'Help & Support':
        return 'Get help and support for using the app';
      case 'About & Legal':
        return 'View app information and legal documents';
      case 'Critical Actions':
        return 'Manage critical account actions';
      default:
        return '';
    }
  }

  Widget _buildDetailedTabContent(int index) {
    if (_sections[index]['title'] == 'Profile') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileSection(),
          const SizedBox(height: 32),
          Text(
            'Personal Information',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 24),
          HoverableCard(
            elevation: 1,
            hoverElevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSettingTile(
                    title: 'Full Name',
                    subtitle: 'John Smith',
                    icon: Icons.person_outline,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Username',
                    subtitle: '@johnsmith',
                    icon: Icons.alternate_email,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Email',
                    subtitle: 'john.smith@example.com',
                    icon: Icons.email_outlined,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Phone Number',
                    subtitle: '+1 (555) 123-4567',
                    icon: Icons.phone_outlined,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Location',
                    subtitle: 'San Francisco, CA',
                    icon: Icons.location_on_outlined,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Bio',
                    subtitle: 'Tell others about yourself',
                    icon: Icons.description_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Reading Preferences',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 24),
          HoverableCard(
            elevation: 1,
            hoverElevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSettingTile(
                    title: 'Favorite Categories',
                    subtitle: 'Technology, Travel, Lifestyle',
                    icon: Icons.category_outlined,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Reading History',
                    subtitle: 'View your reading history',
                    icon: Icons.history_outlined,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Saved Articles',
                    subtitle: 'View your bookmarked articles',
                    icon: Icons.bookmark_outline,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Reading List',
                    subtitle: 'Manage your reading list',
                    icon: Icons.list_alt_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Social Media Links',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 24),
          HoverableCard(
            elevation: 1,
            hoverElevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSettingTile(
                    title: 'Twitter',
                    subtitle: '@johnsmith',
                    icon: FontAwesomeIcons.twitter,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'LinkedIn',
                    subtitle: 'linkedin.com/in/johnsmith',
                    icon: FontAwesomeIcons.linkedin,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'Instagram',
                    subtitle: '@johnsmith.photos',
                    icon: FontAwesomeIcons.instagram,
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    title: 'GitHub',
                    subtitle: 'github.com/johnsmith',
                    icon: FontAwesomeIcons.github,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Profile Preferences',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 24),
          HoverableCard(
            elevation: 1,
            hoverElevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSwitchTile(
                    title: 'Profile Visibility',
                    subtitle: 'Make your profile visible to others',
                    value: true,
                    onChanged: (value) {},
                  ),
                  _buildSwitchTile(
                    title: 'Show Email',
                    subtitle: 'Display your email on your profile',
                    value: false,
                    onChanged: (value) {},
                  ),
                  _buildSwitchTile(
                    title: 'Show Location',
                    subtitle: 'Display your location on your profile',
                    value: true,
                    onChanged: (value) {},
                  ),
                  _buildSwitchTile(
                    title: 'Show Social Links',
                    subtitle: 'Display your social media links',
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // For other sections, show the regular content with title outside
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabContent(index),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.95,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(),
                const SizedBox(height: 24),
                _buildLogoutButton(),
                const SizedBox(height: 32),
                ..._sections
                    .skip(1)
                    .map((section) => Column(
                          children: [
                            _buildTabContent(_sections.indexOf(section)),
                            const SizedBox(height: 32),
                          ],
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.center,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF1F2937),
                ),
                onPressed: () {
                  final router = GoRouter.of(context);
                  if (router.canPop()) {
                    router.pop();
                  } else {
                    router.go('/');
                  }
                },
              ),
              const SizedBox(width: 8),
              Text(
                'Settings',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const Spacer(),
              SearchBox(
                hintText: 'Search settings...',
                width: 280,
                height: 40,
                backgroundColor: Colors.grey.shade50,
                onChanged: (value) {
                  // Implement settings search
                },
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1024) {
            return _buildWebLayout();
          }
          return _buildMobileLayout();
        },
      ),
    );
  }

  Widget _buildProfileSection() {
    return HoverableCard(
      elevation: 1,
      hoverElevation: 4,
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Smith',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '@johnsmith',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
    Widget? badge,
  }) {
    return HoverableCard(
      elevation: 1,
      hoverElevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                if (badge != null) ...[
                  const Spacer(),
                  badge,
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
          ),
          Column(
            children: children,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Widget? trailing,
    Color? subtitleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.grey.shade700,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: subtitleColor ?? Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 16),
              trailing,
            ] else ...[
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    IconData? leadingIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              size: 24,
              color: Colors.grey.shade700,
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required String subtitle,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Slider(
            value: value,
            min: 0.5,
            max: 2.0,
            divisions: 3,
            label: '${(value * 100).round()}%',
            onChanged: onChanged,
            activeColor: Colors.blue.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.logout,
          size: 24,
        ),
        label: Text(
          'Logout',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDC2626),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 20,
          ),
          minimumSize: const Size(0, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
