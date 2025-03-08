import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:blogify_flutter/controllers/settings_controller.dart';
import 'package:blogify_flutter/constants/settings_constants.dart';

class SettingsDrawer extends ConsumerWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final settings = ref.watch(settingsProvider);

    return Drawer(
      backgroundColor: theme.colors.surface,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            decoration: BoxDecoration(
              color: theme.colors.primary.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: theme.colors.surfaceVariant,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colors.primary.withOpacity(0.2),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: theme.typography.body.copyWith(
                              color: theme.colors.onSurface,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'john.doe@example.com',
                            style: theme.typography.body.copyWith(
                              color: theme.colors.onSurfaceVariant,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: SettingsConstants.sections.length,
              itemBuilder: (context, index) {
                final section = SettingsConstants.sections[index];
                final isSelected = settings.selectedTabIndex == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colors.primary.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(
                      section['icon'] as IconData,
                      color: isSelected
                          ? theme.colors.primary
                          : theme.colors.onSurfaceVariant,
                      size: 20,
                    ),
                    title: Text(
                      section['title'] as String,
                      style: theme.typography.body.copyWith(
                        color: isSelected
                            ? theme.colors.primary
                            : theme.colors.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () {
                      ref
                          .read(settingsProvider.notifier)
                          .setSelectedTabIndex(index);
                      if (MediaQuery.of(context).size.width <= 768) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Version 1.0.0',
                  style: theme.typography.body.copyWith(
                    color: theme.colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle logout
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colors.error,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        size: 16,
                        color: theme.colors.error,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: theme.typography.body.copyWith(
                          color: theme.colors.error,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
