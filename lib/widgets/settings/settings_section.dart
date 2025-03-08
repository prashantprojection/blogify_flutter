import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'dart:ui';

class SettingsSection extends ConsumerWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final Widget? badge;
  final GlobalKey? sectionKey;

  const SettingsSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
    this.badge,
    this.sectionKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return SingleChildScrollView(
      child: Container(
        key: sectionKey,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: theme.colors.surface.withOpacity(0.05),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            icon,
                            size: 24,
                            color: theme.colors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          title,
                          style: theme.typography.headline.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (badge != null) ...[
                          const Spacer(),
                          badge!,
                        ],
                      ],
                    ),
                  ),
                  Column(children: children),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
