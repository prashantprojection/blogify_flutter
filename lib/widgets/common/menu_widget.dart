import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/settings_controller.dart';
import 'package:blogify_flutter/widgets/common/neon_border_effect.dart';

class MenuWidget extends ConsumerStatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends ConsumerState<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);

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
                    borderRadius: 24,
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                  ),
                ),
              Container(
                width: 300,
                height: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 100,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey.shade100,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 24, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProfileSection(),
                              SizedBox(height: 24),
                              _buildDivider(),
                              _buildNavigationItems(),
                              _buildDivider(),
                              _buildCreatorSection(),
                              _buildDivider(),
                              _buildSettingsSection(),
                              _buildDivider(),
                              SizedBox(height: 16),
                              _buildLogoutButton(),
                            ],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sarah Johnson',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '@sarahjohnson',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              IconsaxPlusBold.edit,
              size: 18,
              color: Colors.grey.shade700,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItems() {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.home_outlined,
          label: 'My Page',
          onTap: () => context.go('/'),
          iconColor: Colors.blue,
        ),
        _buildMenuItem(
          icon: Icons.explore_outlined,
          label: 'Explore',
          onTap: () => context.go('/explore'),
          iconColor: Colors.blue,
        ),
        _buildMenuItem(
          icon: Icons.play_circle_outline,
          label: 'Stories',
          onTap: () => context.go('/stories'),
          iconColor: Colors.blue,
        ),
        _buildMenuItem(
          icon: Icons.bookmark_border,
          label: 'Saved Posts',
          onTap: () {},
          iconColor: Colors.blue,
        ),
        _buildMenuItem(
          icon: Icons.forum_outlined,
          label: 'Community Forum',
          onTap: () {},
          iconColor: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildCreatorSection() {
    return _buildMenuItem(
      icon: Icons.video_library_outlined,
      label: 'Creator Studio',
      onTap: () {},
      iconColor: Colors.purple,
    );
  }

  Widget _buildSettingsSection() {
    final settings = ref.watch(settingsControllerProvider);

    return Column(
      children: [
        _buildToggleMenuItem(
          icon: Icons.dark_mode_outlined,
          label: 'Dark Mode',
          value: false,
          onChanged: (value) {},
        ),
        _buildToggleMenuItem(
          icon: Icons.notifications_outlined,
          label: 'Notifications',
          value: true,
          onChanged: (value) {},
        ),
        _buildToggleMenuItem(
          icon: Icons.light_mode_outlined,
          label: 'Neon Effect',
          value: settings.neonEffectEnabled,
          onChanged: (value) {
            ref.read(settingsControllerProvider.notifier).toggleNeonEffect();
          },
          submenu: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Speed',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Container(
                      width: 48,
                      child: Text(
                        '${settings.neonEffectSpeed}x',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 2,
                      activeTrackColor: Color(0xFF6366F1),
                      inactiveTrackColor: Colors.grey.shade200,
                      thumbColor: Color(0xFF6366F1),
                      overlayColor: Color(0xFF6366F1).withOpacity(0.12),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                        elevation: 2,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 16,
                      ),
                      tickMarkShape: RoundSliderTickMarkShape(
                        tickMarkRadius: 2,
                      ),
                      activeTickMarkColor: Color(0xFF6366F1),
                      inactiveTickMarkColor: Colors.grey.shade300,
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Color(0xFF6366F1),
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      showValueIndicator: ShowValueIndicator.always,
                    ),
                    child: Slider(
                      value: settings.neonEffectSpeed,
                      min: 0.25,
                      max: 5.0,
                      divisions: SettingsController.speedValues.length - 1,
                      label: '${settings.neonEffectSpeed}x',
                      onChanged: (value) {
                        ref
                            .read(settingsControllerProvider.notifier)
                            .setNeonEffectSpeed(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: SettingsController.speedValues.map((speed) {
                        return Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: speed <= settings.neonEffectSpeed
                                ? Color(0xFF6366F1).withOpacity(0.5)
                                : Colors.grey.shade300.withOpacity(0.5),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
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
        _buildMenuItem(
          icon: Icons.settings_outlined,
          label: 'Settings',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return _buildMenuItem(
      icon: Icons.logout_outlined,
      label: 'Log Out',
      onTap: () {},
      textColor: Colors.red,
      iconColor: Colors.red,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Divider(
        height: 1,
        color: Colors.grey.shade200,
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor ?? Colors.grey.shade700),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: textColor ?? Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleMenuItem({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    Widget? submenu,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 24,
            color: Colors.grey.shade700,
          ),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade800,
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
                activeColor: Color(0xFF6366F1),
              ),
              if (submenu != null) ...[],
            ],
          ),
        ),
        if (submenu != null && value)
          Padding(
            padding: EdgeInsets.only(left: 48, right: 16, bottom: 8),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
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
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            underline: SizedBox(),
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 2,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
              ),
              child: Slider(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
