import 'package:blogify_flutter/models/theme_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../widgets/settings/settings_nav_rail.dart';
import '../../widgets/settings/settings_drawer.dart';
import '../../constants/settings_constants.dart';
import '../../widgets/settings/settings_tile.dart';
import 'sections/about_legal_section.dart';
import 'sections/account_management_section.dart';
import 'sections/app_settings_section.dart';
import 'sections/content_preferences_section.dart';
import 'sections/critical_actions_section.dart';
import 'sections/help_support_section.dart';
import 'sections/notifications_section.dart';
import 'sections/overview_section.dart';
import 'sections/personalization_section.dart';
import 'sections/privacy_security_section.dart';
import 'theme_browser_view.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;
  List<SearchResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _searchResults = _getSearchResults();
    });
  }

  List<SearchResult> _getSearchResults() {
    if (_searchQuery.isEmpty) return [];

    final settings = ref.read(settingsProvider);
    final List<SearchResult> results = [];

    // Helper function to check if text matches search query
    bool matches(String text) => text.toLowerCase().contains(_searchQuery);

    // Search through all sections
    for (final section in SettingsConstants.sections) {
      final sectionTitle = section['title'] as String;
      final sectionIndex = SettingsConstants.sections.indexOf(section);

      if (matches(sectionTitle) || matches(section['description'] as String)) {
        results.add(SearchResult(
          sectionTitle: sectionTitle,
          title: sectionTitle,
          subtitle: section['description'] as String,
          icon: section['icon'] as IconData,
          onTap: () {
            ref
                .read(settingsProvider.notifier)
                .setSelectedTabIndex(sectionIndex);
            setState(() {
              _isSearching = false;
              _searchController.clear();
              _searchQuery = '';
            });
          },
        ));
      }

      final sectionContent = SettingsConstants.sectionContent[sectionTitle];
      if (sectionContent != null) {
        for (final item in sectionContent) {
          if (matches(item['title'] as String) ||
              matches(item['subtitle'] as String)) {
            results.add(_createSearchResult(
                item, sectionTitle, sectionIndex, settings));
          }
        }
      }
    }

    return results;
  }

  SearchResult _createSearchResult(Map<String, dynamic> item,
      String sectionTitle, int sectionIndex, SettingsState settings) {
    final isToggle = item['type'] == 'switch';
    final key = item['key'] as String?;

    return SearchResult(
      sectionTitle: sectionTitle,
      title: item['title'] as String,
      subtitle: item['subtitle'] as String,
      icon: item['icon'] as IconData,
      isToggle: isToggle,
      toggleValue:
          isToggle && key != null ? settings.getValue(key, false) : null,
      onChanged: isToggle && key != null
          ? (value) => ref.read(settingsProvider.notifier).setNotification(
              NotificationType.values.firstWhere((type) => type.key == key),
              value)
          : null,
      key: key,
      onTap: !isToggle
          ? () {
              ref
                  .read(settingsProvider.notifier)
                  .setSelectedTabIndex(sectionIndex);
              setState(() {
                _isSearching = false;
                _searchController.clear();
                _searchQuery = '';
              });
            }
          : null,
    );
  }

  Widget _buildSearchResults() {
    final theme = ref.watch(themeProvider);

    if (_searchQuery.isEmpty) {
      return const SizedBox.shrink();
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 48,
              color: theme.colors.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No settings found',
              style: theme.typography.body.copyWith(
                color: theme.colors.onSurfaceVariant.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0 ||
                result.sectionTitle != _searchResults[index - 1].sectionTitle)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  result.sectionTitle,
                  style: theme.typography.body.copyWith(
                    color: theme.colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: result.isToggle
                  ? SettingsTile.toggle(
                      title: result.title,
                      subtitle: result.subtitle,
                      leading: Icon(
                        result.icon,
                        color: theme.colors.primary,
                      ),
                      value: result.toggleValue!,
                      onChanged: result.onChanged!,
                    )
                  : SettingsTile(
                      title: result.title,
                      subtitle: result.subtitle,
                      leading: Icon(
                        result.icon,
                        color: theme.colors.primary,
                      ),
                      onTap: result.onTap,
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final settings = ref.watch(settingsProvider);
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width <= 768;

    return Scaffold(
      backgroundColor: theme.colors.background,
      drawer: isSmallScreen ? const SettingsDrawer() : null,
      body: Row(
        children: [
          if (!isSmallScreen) const SettingsNavRail(),
          Expanded(
            child: Column(
              children: [
                // App Bar
                _buildAppBar(theme, isSmallScreen),
                // Main Content
                Expanded(
                  child: _buildMainContent(theme, settings, isSmallScreen),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(ThemePalette theme, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colors.outline.withOpacity(0.1),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colors.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (isSmallScreen)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search settings...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded, size: 20),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                            _isSearching = false;
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _isSearching = value.isNotEmpty;
                  if (_isSearching) {
                    _searchResults = _getSearchResults();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(
      ThemePalette theme, SettingsState settings, bool isSmallScreen) {
    return Container(
      color: theme.colors.background,
      child: _isSearching
          ? _buildSearchResults()
          : _buildSectionContent(SettingsConstants
              .sections[settings.selectedTabIndex]['title'] as String),
    );
  }

  Widget _buildSectionContent(String title) {
    switch (title) {
      case 'Overview':
        return const OverviewSection();
      case 'Account Management':
        return const AccountManagementSection();
      case 'Content Preferences':
        return const ContentPreferencesSection();
      case 'Personalization':
        return const PersonalizationSection();
      case 'App Settings':
        return const AppSettingsSection();
      case 'Notifications':
        return const NotificationsSection();
      case 'Privacy & Security':
        return const PrivacySecuritySection();
      case 'Help & Support':
        return const HelpSupportSection();
      case 'About & Legal':
        return const AboutLegalSection();
      case 'Critical Actions':
        return const CriticalActionsSection();
      default:
        return const Center(child: Text('Section not implemented'));
    }
  }
}

class SearchResult {
  final String sectionTitle;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isToggle;
  final bool? toggleValue;
  final Function(bool)? onChanged;
  final VoidCallback? onTap;
  final String? key;

  SearchResult({
    required this.sectionTitle,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isToggle = false,
    this.toggleValue,
    this.onChanged,
    this.onTap,
    this.key,
  });
}
