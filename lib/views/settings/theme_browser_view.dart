import 'package:blogify_flutter/theme/theme_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/theme_controller.dart';
import '../../models/theme_palette.dart';
import '../../controllers/settings_controller.dart';

final themeFilterProvider = StateProvider<String>((ref) => 'all');
final themeSearchProvider = StateProvider<String>((ref) => '');

class ThemeBrowserView extends ConsumerStatefulWidget {
  const ThemeBrowserView({super.key});

  @override
  ConsumerState<ThemeBrowserView> createState() => _ThemeBrowserViewState();
}

class _ThemeBrowserViewState extends ConsumerState<ThemeBrowserView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<ThemePalette> _getFilteredThemes(
      List<ThemeMetadata> themes, String filter, String search) {
    var filteredThemes = themes;

    // Apply theme type filter
    if (filter != 'all') {
      filteredThemes = themes.where((themeMetadata) {
        final theme = ThemeRegistry.getTheme(themeMetadata.id);
        final isDark = _isThemeDark(theme);
        return filter == 'dark' ? isDark : !isDark;
      }).toList();
    }

    // Apply search filter
    if (search.isNotEmpty) {
      filteredThemes = filteredThemes.where((themeMetadata) {
        return themeMetadata.name.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }

    // Convert ThemeMetadata to ThemePalette
    return filteredThemes
        .map((metadata) => ThemeRegistry.getTheme(metadata.id))
        .toList();
  }

  bool _isThemeDark(ThemePalette theme) {
    // Check if background color is darker
    final brightness =
        ThemeData.estimateBrightnessForColor(theme.colors.background);
    return brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final themes = ref.watch(availableThemesProvider);
    final currentThemeId = ref.watch(currentThemeIdProvider);
    final previewThemeId = ref.watch(themePreviewProvider);
    final selectedFilter = ref.watch(themeFilterProvider);
    final searchQuery = ref.watch(themeSearchProvider);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 900;

    final filteredThemes =
        _getFilteredThemes(themes, selectedFilter, searchQuery);

    return Container(
      color: theme.colors.background,
      child: Column(
        children: [
          // Header with Search and Close
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colors.surface,
              border: Border(
                bottom: BorderSide(
                  color: theme.colors.surfaceVariant,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Theme Browser',
                      style: theme.typography.headline.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'Close',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search themes...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: theme.colors.surface,
                  ),
                  onChanged: (value) {
                    ref.read(themeSearchProvider.notifier).state = value;
                  },
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: isSmallScreen
                ? _buildMobileLayout(
                    context,
                    theme,
                    filteredThemes,
                    currentThemeId,
                    previewThemeId,
                    selectedFilter,
                  )
                : _buildDesktopLayout(
                    context,
                    theme,
                    filteredThemes,
                    currentThemeId,
                    previewThemeId,
                    selectedFilter,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    ThemePalette theme,
    List<ThemePalette> filteredThemes,
    String currentThemeId,
    String? previewThemeId,
    String selectedFilter,
  ) {
    return Column(
      children: [
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: selectedFilter == 'all',
                onSelected: (bool selected) {
                  if (selected) {
                    ref.read(themeFilterProvider.notifier).state = 'all';
                  }
                },
                selectedColor: theme.colors.primary.withOpacity(0.2),
                checkmarkColor: theme.colors.primary,
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Light'),
                selected: selectedFilter == 'light',
                onSelected: (bool selected) {
                  if (selected) {
                    ref.read(themeFilterProvider.notifier).state = 'light';
                  }
                },
                selectedColor: theme.colors.primary.withOpacity(0.2),
                checkmarkColor: theme.colors.primary,
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Dark'),
                selected: selectedFilter == 'dark',
                onSelected: (bool selected) {
                  if (selected) {
                    ref.read(themeFilterProvider.notifier).state = 'dark';
                  }
                },
                selectedColor: theme.colors.primary.withOpacity(0.2),
                checkmarkColor: theme.colors.primary,
              ),
            ],
          ),
        ),
        // Theme List
        Expanded(
          child: filteredThemes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_outlined,
                        size: 48,
                        color: theme.colors.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No themes found',
                        style: theme.typography.body.copyWith(
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: filteredThemes.length,
                  itemBuilder: (context, index) {
                    final themeData = filteredThemes[index];
                    final isSelected = themeData.id == currentThemeId;
                    final isPreviewed = themeData.id == previewThemeId;

                    return _buildThemeListTile(
                      context,
                      theme,
                      themeData,
                      isSelected,
                      isPreviewed,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 0.9,
                            maxChildSize: 0.9,
                            minChildSize: 0.5,
                            builder: (context, scrollController) => Container(
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // Preview Header
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: theme.colors.surfaceVariant,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Theme Preview',
                                          style: theme.typography.title,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Preview Content
                                  Expanded(
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: _buildThemePreview(themeData),
                                    ),
                                  ),
                                  // Actions
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: theme.colors.surfaceVariant,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text(
                                            'Cancel',
                                            style: theme.typography.button,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            ref
                                                .read(currentThemeIdProvider
                                                    .notifier)
                                                .state = themeData.id;
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                    'Theme applied successfully'),
                                                backgroundColor:
                                                    theme.colors.primary,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                action: SnackBarAction(
                                                  label: 'OK',
                                                  textColor:
                                                      theme.colors.onPrimary,
                                                  onPressed: () {},
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                theme.colors.primary,
                                            foregroundColor:
                                                theme.colors.onPrimary,
                                          ),
                                          child: const Text('Apply Theme'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ThemePalette theme,
    List<ThemePalette> filteredThemes,
    String currentThemeId,
    String? previewThemeId,
    String selectedFilter,
  ) {
    return Row(
      children: [
        // Theme List with Categories
        Container(
          width: 300,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: theme.colors.surfaceVariant,
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: selectedFilter == 'all',
                      onSelected: (bool selected) {
                        if (selected) {
                          ref.read(themeFilterProvider.notifier).state = 'all';
                        }
                      },
                      selectedColor: theme.colors.primary.withOpacity(0.2),
                      checkmarkColor: theme.colors.primary,
                    ),
                    FilterChip(
                      label: const Text('Light'),
                      selected: selectedFilter == 'light',
                      onSelected: (bool selected) {
                        if (selected) {
                          ref.read(themeFilterProvider.notifier).state =
                              'light';
                        }
                      },
                      selectedColor: theme.colors.primary.withOpacity(0.2),
                      checkmarkColor: theme.colors.primary,
                    ),
                    FilterChip(
                      label: const Text('Dark'),
                      selected: selectedFilter == 'dark',
                      onSelected: (bool selected) {
                        if (selected) {
                          ref.read(themeFilterProvider.notifier).state = 'dark';
                        }
                      },
                      selectedColor: theme.colors.primary.withOpacity(0.2),
                      checkmarkColor: theme.colors.primary,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filteredThemes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_outlined,
                              size: 48,
                              color: theme.colors.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No themes found',
                              style: theme.typography.body.copyWith(
                                color: theme.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredThemes.length,
                        itemBuilder: (context, index) {
                          final themeData = filteredThemes[index];
                          final isSelected = themeData.id == currentThemeId;
                          final isPreviewed = themeData.id == previewThemeId;

                          return _buildThemeListTile(
                            context,
                            theme,
                            themeData,
                            isSelected,
                            isPreviewed,
                            onTap: () {
                              ref.read(themePreviewProvider.notifier).state =
                                  themeData.id;
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        // Preview
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: previewThemeId != null
                      ? _buildThemePreview(
                          ThemeRegistry.getTheme(previewThemeId))
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.palette_outlined,
                                size: 64,
                                color: theme.colors.outline,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Select a theme to preview',
                                style: theme.typography.body.copyWith(
                                  color: theme.colors.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              // Actions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  border: Border(
                    top: BorderSide(
                      color: theme.colors.surfaceVariant,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: theme.typography.button,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: previewThemeId != null
                          ? () {
                              ref.read(currentThemeIdProvider.notifier).state =
                                  previewThemeId;
                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Theme applied successfully'),
                                  backgroundColor: theme.colors.primary,
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: 'OK',
                                    textColor: theme.colors.onPrimary,
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: theme.colors.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Apply Theme'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeListTile(
    BuildContext context,
    ThemePalette theme,
    ThemePalette themeData,
    bool isSelected,
    bool isPreviewed, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: themeData.colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: themeData.colors.surfaceVariant,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: themeData.colors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: themeData.colors.secondary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: themeData.colors.tertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: themeData.colors.surface,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: themeData.colors.outline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      title: Text(
        themeData.name,
        style: theme.typography.body.copyWith(
          fontWeight:
              isSelected || isPreviewed ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            _isThemeDark(themeData) ? Icons.dark_mode : Icons.light_mode,
            size: 14,
            color: theme.colors.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            _isThemeDark(themeData) ? 'Dark' : 'Light',
            style: theme.typography.caption.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: theme.colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Current',
                style: theme.typography.caption.copyWith(
                  color: theme.colors.primary,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ],
      ),
      selected: isSelected || isPreviewed,
      selectedTileColor: theme.colors.primary.withOpacity(0.1),
      onTap: onTap,
    );
  }

  Widget _buildThemePreview(ThemePalette previewTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme Preview',
          style: previewTheme.typography.headline,
        ),
        const SizedBox(height: 24),
        // Blog Preview
        Card(
          color: previewTheme.colors.surface,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blog Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: previewTheme.colors.primary,
                      radius: 24,
                      child: Icon(
                        Icons.person_outline,
                        color: previewTheme.colors.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: previewTheme.typography.title.copyWith(
                              color: previewTheme.colors.onSurface,
                            ),
                          ),
                          Text(
                            '5 mins ago · 3 min read',
                            style: previewTheme.typography.body.copyWith(
                              color: previewTheme.colors.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: previewTheme.colors.onSurfaceVariant,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Blog Image
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: previewTheme.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    size: 48,
                    color: previewTheme.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                // Blog Title
                Text(
                  'Getting Started with Flutter Development',
                  style: previewTheme.typography.headline.copyWith(
                    fontSize: 24,
                    color: previewTheme.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                // Blog Tags
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: Text(
                        'Flutter',
                        style: TextStyle(
                          color: previewTheme.colors.onPrimary,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: previewTheme.colors.primary,
                    ),
                    Chip(
                      label: Text(
                        'Development',
                        style: TextStyle(
                          color: previewTheme.colors.onSecondary,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: previewTheme.colors.secondary,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Blog Content Preview
                Text(
                  "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase...",
                  style: previewTheme.typography.body.copyWith(
                    color: previewTheme.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                // Blog Actions
                Row(
                  children: [
                    _buildActionButton(
                      previewTheme,
                      Icons.favorite_border,
                      '128',
                    ),
                    const SizedBox(width: 16),
                    _buildActionButton(
                      previewTheme,
                      Icons.comment_outlined,
                      '24',
                    ),
                    const SizedBox(width: 16),
                    _buildActionButton(
                      previewTheme,
                      Icons.share_outlined,
                      'Share',
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.bookmark_border,
                        color: previewTheme.colors.onSurfaceVariant,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Color Palette Section
        Card(
          color: previewTheme.colors.surface,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Colors',
                  style: previewTheme.typography.title,
                ),
                const SizedBox(height: 8),
                Text(
                  'Preview how colors will appear in your blog',
                  style: previewTheme.typography.body.copyWith(
                    color: previewTheme.colors.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    _buildColorPreview(
                      'Main Brand Color',
                      previewTheme.colors.primary,
                      'Used for buttons, links, and important actions',
                      previewTheme,
                    ),
                    _buildColorPreview(
                      'Accent Color',
                      previewTheme.colors.secondary,
                      'Used for highlights and secondary elements',
                      previewTheme,
                    ),
                    _buildColorPreview(
                      'Special Elements',
                      previewTheme.colors.tertiary,
                      'Used for badges, tags, and special features',
                      previewTheme,
                    ),
                    _buildColorPreview(
                      'Background',
                      previewTheme.colors.background,
                      'Main background color of your blog',
                      previewTheme,
                    ),
                    _buildColorPreview(
                      'Card Background',
                      previewTheme.colors.surface,
                      'Background for cards and content blocks',
                      previewTheme,
                    ),
                    _buildColorPreview(
                      'Borders & Dividers',
                      previewTheme.colors.surfaceVariant,
                      'Used for separating content and creating borders',
                      previewTheme,
                    ),
                    _buildColorPreview(
                      'Text Color',
                      previewTheme.colors.onSurface,
                      'Main color for text content',
                      previewTheme,
                    ),
                    _buildColorPreview(
                      'Secondary Text',
                      previewTheme.colors.onSurfaceVariant,
                      'Used for subtitles and less important text',
                      previewTheme,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(ThemePalette theme, IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        icon,
        size: 20,
        color: theme.colors.onSurfaceVariant,
      ),
      label: Text(
        label,
        style: theme.typography.body.copyWith(
          color: theme.colors.onSurfaceVariant,
          fontSize: 14,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildColorPreview(
      String label, Color color, String description, ThemePalette theme) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colors.outline.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colors.outline.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.typography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.typography.body.copyWith(
                        fontSize: 12,
                        color: theme.colors.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
