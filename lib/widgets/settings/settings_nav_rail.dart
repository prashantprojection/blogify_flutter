import 'package:blogify_flutter/models/theme_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:blogify_flutter/controllers/settings_controller.dart';
import 'package:blogify_flutter/constants/settings_constants.dart';
import 'package:blogify_flutter/widgets/painters/tile_reveal_painter.dart';

class SettingsNavRail extends ConsumerStatefulWidget {
  const SettingsNavRail({super.key});

  @override
  ConsumerState<SettingsNavRail> createState() => _SettingsNavRailState();
}

class _SettingsNavRailState extends ConsumerState<SettingsNavRail> {
  final Map<String, bool> _hoveredStates = {};
  final Map<String, Offset> _mousePositions = {};

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final settings = ref.watch(settingsProvider);

    return Container(
        width: 300,
        decoration: BoxDecoration(
          color: theme.colors.surface,
          border: Border(
            right: BorderSide(
              color: theme.colors.surfaceVariant,
              width: 1,
            ),
          ),
        ),
        child: Column(children: [
          // Profile Header
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colors.primary.withOpacity(0.1),
                    theme.colors.surfaceVariant.withOpacity(0.3),
                  ],
                ),
                border: Border(
                  bottom: BorderSide(
                    color: theme.colors.surfaceVariant,
                    width: 1,
                  ),
                ),
              ),
              child: Column(children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colors.primary.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: theme.colors.surfaceVariant,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 32,
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.edit_rounded,
                        size: 16,
                        color: theme.colors.onPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'User Name',
                  style: theme.typography.title.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text('@username',
                    style: theme.typography.body
                        .copyWith(color: theme.colors.onSurfaceVariant))
              ])),
          // Navigation Items
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: SettingsConstants.sections.length,
                  itemBuilder: (context, index) {
                    final section = SettingsConstants.sections[index];
                    if (section['title'] == 'Profile' ||
                        section['parent'] != null) {
                      return const SizedBox.shrink();
                    }

                    final isSelected = settings.selectedTabIndex == index;
                    final tileKey = 'nav_${section['title']}';

                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: MouseRegion(
                            key: ValueKey(tileKey),
                            onEnter: (event) {
                              setState(() {
                                _hoveredStates[tileKey] = true;
                                _mousePositions[tileKey] = event.localPosition;
                              });
                            },
                            onHover: (event) {
                              setState(() {
                                _mousePositions[tileKey] = event.localPosition;
                              });
                            },
                            onExit: (event) {
                              setState(() {
                                _hoveredStates[tileKey] = false;
                              });
                            },
                            child: GestureDetector(
                                onTap: () {
                                  ref
                                      .read(settingsProvider.notifier)
                                      .setSelectedTabIndex(index);
                                },
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? theme.colors.primary
                                              .withOpacity(0.1)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected
                                            ? theme.colors.primary
                                                .withOpacity(0.5)
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child: Stack(children: [
                                      if (_hoveredStates[tileKey] == true &&
                                          !isSelected)
                                        Positioned.fill(
                                          child: CustomPaint(
                                            painter: TileRevealPainter(
                                              mouseX: _mousePositions[tileKey]
                                                      ?.dx ??
                                                  0,
                                              mouseY: _mousePositions[tileKey]
                                                      ?.dy ??
                                                  0,
                                              color: theme.colors.primary,
                                            ),
                                          ),
                                        ),
                                      Row(children: [
                                        Icon(
                                          section['icon'] as IconData,
                                          size: 20,
                                          color: isSelected ||
                                                  _hoveredStates[tileKey] ==
                                                      true
                                              ? theme.colors.primary
                                              : theme.colors.onSurfaceVariant,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            section['title'] as String,
                                            style:
                                                theme.typography.body.copyWith(
                                              color: isSelected ||
                                                      _hoveredStates[tileKey] ==
                                                          true
                                                  ? theme.colors.primary
                                                  : theme.colors.onSurface,
                                              fontWeight: isSelected ||
                                                      _hoveredStates[tileKey] ==
                                                          true
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        if (isSelected)
                                          Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: theme.colors.primary,
                                                  shape: BoxShape.circle))
                                      ])
                                    ])))));
                  }))
        ]));
  }
}
