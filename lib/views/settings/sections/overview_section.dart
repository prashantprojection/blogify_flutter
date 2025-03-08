import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/theme_palette.dart';
import '../../../controllers/settings_controller.dart';
import '../../../constants/settings_constants.dart';
import '../../../widgets/settings/settings_tile.dart';

class OverviewSection extends ConsumerWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final settings = ref.watch(settingsProvider);
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width <= 768;
    final crossAxisCount = width > 1200 ? 3 : (width > 800 ? 2 : 1);
    final sections = SettingsConstants.sections
        .where((section) => section['title'] != 'Overview')
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 24,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeader(theme, isSmallScreen),
          const SizedBox(height: 32),

          // Quick Actions
          _buildQuickActions(theme, ref, isSmallScreen),
          const SizedBox(height: 40),

          // All Settings Grid
          _buildAllSettings(
              theme, settings, sections, crossAxisCount, isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemePalette theme, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings Overview',
          style: theme.typography.headline.copyWith(
            color: theme.colors.onSurface,
            fontSize: isSmallScreen ? 24 : 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage your account, preferences, and blog settings',
          style: theme.typography.body.copyWith(
            color: theme.colors.onSurfaceVariant,
            fontSize: isSmallScreen ? 14 : 16,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(
      ThemePalette theme, WidgetRef ref, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: theme.typography.title.copyWith(
            color: theme.colors.onSurface,
            fontSize: isSmallScreen ? 20 : 24,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildQuickActionCard(
              theme,
              'Personalization',
              Icons.palette_outlined,
              'Customize the look and feel',
              () => ref.read(settingsProvider.notifier).setSelectedTabIndex(3),
              isSmallScreen,
            ),
            _buildQuickActionCard(
              theme,
              'Notifications',
              Icons.notifications_outlined,
              'Manage your notifications',
              () => ref.read(settingsProvider.notifier).setSelectedTabIndex(5),
              isSmallScreen,
            ),
            _buildQuickActionCard(
              theme,
              'Privacy',
              Icons.security_outlined,
              'Control your privacy settings',
              () => ref.read(settingsProvider.notifier).setSelectedTabIndex(6),
              isSmallScreen,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    ThemePalette theme,
    String title,
    IconData icon,
    String description,
    VoidCallback onTap,
    bool isSmallScreen,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: isSmallScreen ? double.infinity : 280,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colors.primary.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: theme.colors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.typography.body.copyWith(
                        color: theme.colors.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.typography.body.copyWith(
                        color: theme.colors.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colors.primary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllSettings(
    ThemePalette theme,
    SettingsState settings,
    List<Map<String, dynamic>> sections,
    int crossAxisCount,
    bool isSmallScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Settings',
          style: theme.typography.title.copyWith(
            color: theme.colors.onSurface,
            fontSize: isSmallScreen ? 20 : 24,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isSmallScreen ? 2.5 : 3,
          ),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final section = sections[index];
            final bool isSelected = settings.selectedTabIndex == index + 1;

            return _buildSettingCard(theme, section, isSelected);
          },
        ),
      ],
    );
  }

  Widget _buildSettingCard(
    ThemePalette theme,
    Map<String, dynamic> section,
    bool isSelected,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colors.primary.withOpacity(0.1)
                : theme.colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? theme.colors.primary
                  : theme.colors.outline.withOpacity(0.1),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colors.shadow.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  section['icon'] as IconData,
                  color: theme.colors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                section['title'] as String,
                style: theme.typography.body.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                section['description'] as String,
                style: theme.typography.body.copyWith(
                  color: theme.colors.onSurfaceVariant,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
