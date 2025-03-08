import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';

class CategoryCard extends ConsumerWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.large, vertical: theme.spacing.medium),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colors.primaryContainer
                : theme.colors.surface,
            borderRadius: theme.corners.roundedMedium,
            border: Border.all(
              color: isSelected
                  ? theme.colors.primary
                  : theme.colors.outlineVariant,
              width: theme.borders.small,
            ),
            boxShadow: isSelected ? theme.shadows.small : theme.shadows.none,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? theme.colors.primary
                    : theme.colors.onSurfaceVariant,
                size: 20,
              ),
              SizedBox(width: theme.spacing.medium),
              Text(
                title,
                style: theme.typography.body.copyWith(
                  color: isSelected
                      ? theme.colors.primary
                      : theme.colors.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
