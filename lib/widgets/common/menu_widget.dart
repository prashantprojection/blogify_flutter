import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:blogify_flutter/controllers/settings_controller.dart';
import 'package:blogify_flutter/widgets/common/neon_border_effect.dart';
import 'package:blogify_flutter/widgets/common/hover_box.dart';

class MenuWidget extends ConsumerStatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends ConsumerState<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final theme = ref.watch(themeProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.85; // 85% of screen height

    return Align(
      alignment: Alignment.centerRight,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeOut,
        )),
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          child: Stack(
            children: [
              if (settings.neonEffectEnabled)
                Positioned.fill(
                  child: NeonBorderEffect(
                    borderRadius: theme.corners.roundedLarge.topLeft.x,
                    margin: EdgeInsets.symmetric(
                      horizontal: theme.spacing.large,
                      vertical: theme.spacing.medium,
                    ),
                  ),
                ),
              Container(
                width: 300,
                constraints: BoxConstraints(
                  maxHeight: maxHeight,
                  minHeight: 200, // Minimum reasonable height
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: theme.spacing.large,
                  vertical: theme.spacing.medium,
                ),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: theme.corners.roundedLarge,
                  border: Border.all(
                    color: theme.colors.outline,
                    width: theme.borders.small,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colors.shadow.withOpacity(0.08),
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                    BoxShadow(
                      color: theme.colors.shadow.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.all(theme.spacing.small),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: theme.corners.roundedMedium,
                    border: Border.all(
                      color: theme.colors.outline,
                      width: theme.borders.small,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: theme.corners.roundedMedium,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colors.surfaceVariant,
                          theme.colors.surface,
                        ],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: theme.corners.roundedMedium,
                      child: SingleChildScrollView(
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: theme.spacing.large,
                              horizontal: theme.spacing.medium,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildProfileSection(),
                                SizedBox(height: theme.spacing.large),
                                _buildDivider(),
                                _buildNavigationItems(),
                                _buildDivider(),
                                _buildCreatorSection(),
                                _buildDivider(),
                                _buildSettingsSection(),
                                _buildDivider(),
                                SizedBox(height: theme.spacing.medium),
                                _buildLogoutButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    final theme = ref.watch(themeProvider);
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(); // Close the menu
        context.go('/profile'); // Navigate to profile
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing.medium),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
              ),
            ),
            SizedBox(width: theme.spacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sarah Johnson',
                    style: theme.typography.title.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '@sarahjohnson',
                    style: theme.typography.body.copyWith(
                      fontSize: 13,
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                IconsaxPlusBold.edit,
                size: 18,
                color: theme.colors.onSurfaceVariant,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the menu
                context.go('/profile'); // Navigate to profile
              },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItems() {
    final theme = ref.watch(themeProvider);
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.home_outlined,
          label: 'My Page',
          onTap: () => context.go('/'),
          iconColor: theme.colors.primary,
        ),
        _buildMenuItem(
          icon: Icons.explore_outlined,
          label: 'Explore',
          onTap: () => context.go('/explore'),
          iconColor: theme.colors.primary,
        ),
        _buildMenuItem(
          icon: Icons.play_circle_outline,
          label: 'Stories',
          onTap: () => context.go('/stories'),
          iconColor: theme.colors.primary,
        ),
        _buildMenuItem(
          icon: Icons.bookmark_border,
          label: 'Saved Posts',
          onTap: () {},
          iconColor: theme.colors.primary,
        ),
        _buildMenuItem(
          icon: Icons.forum_outlined,
          label: 'Community Forum',
          onTap: () => context.go('/community'),
          iconColor: theme.colors.primary,
        ),
      ],
    );
  }

  Widget _buildCreatorSection() {
    return _buildMenuItem(
      icon: Icons.video_library_outlined,
      label: 'Creator Studio',
      onTap: () {},
    );
  }

  Widget _buildSettingsSection() {
    final settings = ref.watch(settingsProvider);
    final theme = ref.watch(themeProvider);

    return Column(
      children: [
        _buildToggleMenuItem(
          icon: Icons.dark_mode_outlined,
          label: 'Dark Mode',
          value: settings.isDarkMode,
          onChanged: (value) {
            ref.read(settingsProvider.notifier).setDarkMode(value);
          },
        ),
        _buildToggleMenuItem(
          icon: Icons.notifications_outlined,
          label: 'Notifications',
          value: settings.notificationsEnabled,
          onChanged: (value) {
            ref.read(settingsProvider.notifier).setNotificationsEnabled(value);
          },
        ),
        _buildToggleMenuItem(
          icon: Icons.light_mode_outlined,
          label: 'Neon Effect',
          value: settings.neonEffectEnabled,
          onChanged: (value) {
            ref.read(settingsProvider.notifier).toggleNeonEffect();
          },
          submenu: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: theme.spacing.extraSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Speed',
                      style: theme.typography.body.copyWith(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '${settings.neonEffectSpeed}x',
                      style: theme.typography.body.copyWith(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: theme.borders.small,
                  activeTrackColor: theme.colors.primary,
                  inactiveTrackColor: theme.colors.outlineVariant,
                  thumbColor: theme.colors.primary,
                  overlayColor: theme.colors.primary.withOpacity(0.12),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: theme.spacing.small,
                    elevation: theme.borders.small,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: theme.spacing.medium,
                  ),
                  tickMarkShape: RoundSliderTickMarkShape(
                    tickMarkRadius: theme.borders.extraSmall,
                  ),
                  activeTickMarkColor: theme.colors.primary,
                  inactiveTickMarkColor: theme.colors.outlineVariant,
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: theme.colors.primary,
                  valueIndicatorTextStyle: theme.typography.label.copyWith(
                    color: theme.colors.onPrimary,
                  ),
                  showValueIndicator: ShowValueIndicator.always,
                ),
                child: Slider(
                  value: settings.neonEffectSpeed,
                  min: SettingsNotifier.speedValues.first,
                  max: SettingsNotifier.speedValues.last,
                  divisions: SettingsNotifier.speedValues.length - 1,
                  label: '${settings.neonEffectSpeed}x',
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setNeonEffectSpeed(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.small),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: SettingsNotifier.speedValues.map((speed) {
                    return Container(
                      width: theme.borders.small,
                      height: theme.borders.small,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: speed <= settings.neonEffectSpeed
                            ? theme.colors.primary.withOpacity(0.5)
                            : theme.colors.outlineVariant.withOpacity(0.5),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        _buildDropdownMenuItem(
          icon: Icons.language_outlined,
          label: 'Language',
          value: 'English',
          items: ['English', 'Spanish', 'French'],
          onChanged: (value) {},
        ),
        _buildSliderMenuItem(
          icon: Icons.text_fields_outlined,
          label: 'Font Size',
          value: 0.5,
          onChanged: (value) {},
        ),
        _buildMenuItem(
          icon: Icons.tune_outlined,
          label: 'Content Preferences',
          onTap: () {},
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.settings_outlined,
          label: 'Settings',
          onTap: () => context.go('/settings'),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    final theme = ref.watch(themeProvider);
    return _buildMenuItem(
      icon: Icons.logout_outlined,
      label: 'Log Out',
      onTap: () {},
      textColor: theme.colors.error,
      iconColor: theme.colors.error,
    );
  }

  Widget _buildDivider() {
    final theme = ref.watch(themeProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.medium,
        vertical: theme.spacing.small,
      ),
      child: Divider(
        height: theme.borders.small,
        color: theme.colors.outlineVariant,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    final theme = ref.watch(themeProvider);
    final isDesktop = UniversalPlatform.isWindows ||
        UniversalPlatform.isLinux ||
        UniversalPlatform.isMacOS ||
        UniversalPlatform.isWeb;

    return HoverBox(
      builder: (context, isHovered) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            hoverColor: isDesktop
                ? theme.colors.primary.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: theme.corners.roundedSmall,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.medium,
                vertical: theme.spacing.medium,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: isHovered && isDesktop
                        ? theme.colors.primary
                        : (iconColor ?? theme.colors.onSurfaceVariant),
                  ),
                  SizedBox(width: theme.spacing.medium),
                  Text(
                    label,
                    style: theme.typography.button.copyWith(
                      color: isHovered && isDesktop
                          ? theme.colors.primary
                          : (textColor ?? theme.colors.onSurface),
                      fontWeight: isHovered && isDesktop
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildToggleMenuItem({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    Widget? submenu,
  }) {
    final theme = ref.watch(themeProvider);
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 20,
            color: theme.colors.onSurfaceVariant,
          ),
          title: Text(
            label,
            style: theme.typography.button.copyWith(
              color: theme.colors.onSurface,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlutterSwitch(
                width: 48,
                height: 24,
                value: value,
                onToggle: onChanged,
                activeColor: theme.colors.primary,
              ),
              if (submenu != null) ...[],
            ],
          ),
        ),
        if (submenu != null && value)
          Padding(
            padding: EdgeInsets.only(
              left: theme.spacing.extraLarge,
              right: theme.spacing.medium,
              bottom: theme.spacing.small,
            ),
            child: submenu,
          ),
      ],
    );
  }

  Widget _buildDropdownMenuItem({
    required IconData icon,
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = ref.watch(themeProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.medium,
        vertical: theme.spacing.medium,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colors.onSurfaceVariant,
          ),
          SizedBox(width: theme.spacing.medium),
          Expanded(
            child: Text(
              label,
              style: theme.typography.button.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
          ),
          DropdownButton<String>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: theme.typography.button.copyWith(
                          color: theme.colors.onSurface,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            underline: const SizedBox(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: theme.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderMenuItem({
    required IconData icon,
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    final theme = ref.watch(themeProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.medium,
        vertical: theme.spacing.medium,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colors.onSurfaceVariant,
          ),
          SizedBox(width: theme.spacing.medium),
          Text(
            label,
            style: theme.typography.button.copyWith(
              color: theme.colors.onSurface,
            ),
          ),
          SizedBox(width: theme.spacing.medium),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: theme.borders.small,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: theme.spacing.small,
                ),
                activeTrackColor: theme.colors.primary,
                inactiveTrackColor: theme.colors.outlineVariant,
                thumbColor: theme.colors.primary,
              ),
              child: Slider(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
