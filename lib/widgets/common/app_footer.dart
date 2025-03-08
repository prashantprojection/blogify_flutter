import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:blogify_flutter/models/theme_palette.dart';

class AppFooter extends ConsumerWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? dividerColor;
  final bool showSocialIcons;
  final bool showQuickLinks;
  final bool showLegalLinks;
  final bool showCopyright;
  final String? brandName;
  final String? tagline;
  final Map<String, String>? socialLinks;
  final Map<String, String>? quickLinks;
  final Map<String, String>? legalLinks;
  final String? copyrightText;
  final Widget? customBrandSection;
  final Widget? customQuickLinks;
  final Widget? customLegalSection;
  final Widget? customCopyrightSection;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double breakpoint;

  const AppFooter({
    Key? key,
    this.backgroundColor,
    this.textColor,
    this.dividerColor,
    this.showSocialIcons = true,
    this.showQuickLinks = true,
    this.showLegalLinks = true,
    this.showCopyright = true,
    this.brandName,
    this.tagline,
    this.socialLinks,
    this.quickLinks,
    this.legalLinks,
    this.copyrightText,
    this.customBrandSection,
    this.customQuickLinks,
    this.customLegalSection,
    this.customCopyrightSection,
    this.horizontalPadding,
    this.verticalPadding,
    this.breakpoint = 768,
  }) : super(key: key);

  // Factory constructor for custom footer
  factory AppFooter.custom({
    Color? backgroundColor,
    Color? textColor,
    Color? dividerColor,
    bool showSocialIcons = true,
    bool showQuickLinks = true,
    bool showLegalLinks = true,
    bool showCopyright = true,
    String? brandName,
    String? tagline,
    Map<String, String>? socialLinks,
    Map<String, String>? quickLinks,
    Map<String, String>? legalLinks,
    String? copyrightText,
    Widget? customBrandSection,
    Widget? customQuickLinks,
    Widget? customLegalSection,
    Widget? customCopyrightSection,
    double? horizontalPadding,
    double? verticalPadding,
    double breakpoint = 768,
  }) {
    return AppFooter(
      backgroundColor: backgroundColor,
      textColor: textColor,
      dividerColor: dividerColor,
      showSocialIcons: showSocialIcons,
      showQuickLinks: showQuickLinks,
      showLegalLinks: showLegalLinks,
      showCopyright: showCopyright,
      brandName: brandName,
      tagline: tagline,
      socialLinks: socialLinks,
      quickLinks: quickLinks,
      legalLinks: legalLinks,
      copyrightText: copyrightText,
      customBrandSection: customBrandSection,
      customQuickLinks: customQuickLinks,
      customLegalSection: customLegalSection,
      customCopyrightSection: customCopyrightSection,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      breakpoint: breakpoint,
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  double _getResponsiveSpacing(double baseSpacing, bool isMobile) {
    return isMobile ? baseSpacing * 0.75 : baseSpacing;
  }

  double _getResponsiveFontSize(double baseFontSize, bool isMobile) {
    return isMobile ? baseFontSize * 0.875 : baseFontSize;
  }

  double _getResponsiveIconSize(double baseSize, bool isMobile) {
    return isMobile ? baseSize * 0.875 : baseSize;
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String url,
    required Color color,
    required ThemePalette theme,
    required bool isMobile,
  }) {
    final double iconSize = _getResponsiveIconSize(20, isMobile);
    final double containerPadding =
        _getResponsiveSpacing(theme.spacing.medium, isMobile);

    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: theme.corners.roundedSmall,
      child: Container(
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          color: theme.colors.surfaceVariant,
          borderRadius: theme.corners.roundedSmall,
        ),
        child: FaIcon(
          icon,
          color: color,
          size: iconSize,
        ),
      ),
    );
  }

  Widget _buildFooterLink(
    BuildContext context, {
    required String title,
    required String route,
    required ThemePalette theme,
    required bool isMobile,
  }) {
    return InkWell(
      onTap: () => context.go(route),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _getResponsiveSpacing(theme.spacing.extraSmall, isMobile),
        ),
        child: Text(
          title,
          style: theme.typography.body.copyWith(
            color: theme.colors.onSurface.withOpacity(0.7),
            fontSize: _getResponsiveFontSize(
                theme.typography.body.fontSize!, isMobile),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandSection(
    BuildContext context, {
    required bool isMobile,
    required ThemePalette theme,
  }) {
    if (customBrandSection != null) return customBrandSection!;

    final double titleFontSize = _getResponsiveFontSize(
      isMobile ? 24 : 32,
      isMobile,
    );
    final double taglineFontSize = _getResponsiveFontSize(
      isMobile ? 14 : 16,
      isMobile,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          brandName ?? 'Blogify',
          style: theme.typography.display.copyWith(
            fontWeight: FontWeight.w900,
            color: theme.colors.onSurface,
            fontSize: titleFontSize,
          ),
        ),
        SizedBox(height: _getResponsiveSpacing(theme.spacing.medium, isMobile)),
        Text(
          tagline ?? 'Empowering Bloggers, One Story at a Time',
          style: theme.typography.body.copyWith(
            color: theme.colors.onSurface.withOpacity(0.7),
            fontSize: taglineFontSize,
          ),
        ),
        if (showSocialIcons) ...[
          SizedBox(
              height: _getResponsiveSpacing(theme.spacing.large, isMobile)),
          Wrap(
            spacing: _getResponsiveSpacing(theme.spacing.medium, isMobile),
            runSpacing: _getResponsiveSpacing(theme.spacing.medium, isMobile),
            children: [
              _buildSocialIcon(
                icon: FontAwesomeIcons.twitter,
                url: socialLinks?['twitter'] ?? 'https://twitter.com/blogify',
                color: const Color(0xFF1DA1F2),
                theme: theme,
                isMobile: isMobile,
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.facebook,
                url: socialLinks?['facebook'] ?? 'https://facebook.com/blogify',
                color: const Color(0xFF4267B2),
                theme: theme,
                isMobile: isMobile,
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.instagram,
                url: socialLinks?['instagram'] ??
                    'https://instagram.com/blogify',
                color: const Color(0xFFE1306C),
                theme: theme,
                isMobile: isMobile,
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.linkedin,
                url: socialLinks?['linkedin'] ??
                    'https://linkedin.com/company/blogify',
                color: const Color(0xFF0077B5),
                theme: theme,
                isMobile: isMobile,
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.github,
                url: socialLinks?['github'] ?? 'https://github.com/blogify',
                color: theme.colors.onSurface,
                theme: theme,
                isMobile: isMobile,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildQuickLinksSection(
    BuildContext context, {
    required ThemePalette theme,
    required bool isMobile,
  }) {
    if (customQuickLinks != null) return customQuickLinks!;
    if (!showQuickLinks) return const SizedBox.shrink();

    final Map<String, String> links = quickLinks ??
        {
          'About Us': '/about',
          'Contact': '/contact',
          'Careers': '/careers',
          'Support': '/support',
        };

    final double titleFontSize = _getResponsiveFontSize(
      isMobile ? 18 : 20,
      isMobile,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: theme.typography.title.copyWith(
            fontWeight: FontWeight.w900,
            color: theme.colors.onSurface,
            fontSize: titleFontSize,
          ),
        ),
        SizedBox(height: _getResponsiveSpacing(theme.spacing.large, isMobile)),
        ...links.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: _getResponsiveSpacing(theme.spacing.medium, isMobile),
            ),
            child: _buildFooterLink(
              context,
              title: entry.key,
              route: entry.value,
              theme: theme,
              isMobile: isMobile,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLegalSection(
    BuildContext context, {
    required ThemePalette theme,
    required bool isMobile,
  }) {
    if (customLegalSection != null) return customLegalSection!;
    if (!showLegalLinks) return const SizedBox.shrink();

    final Map<String, String> links = legalLinks ??
        {
          'Terms of Service': '/terms',
          'Privacy Policy': '/privacy',
          'Cookie Policy': '/cookies',
          'Blog Guidelines': '/guidelines',
        };

    final double titleFontSize = _getResponsiveFontSize(
      isMobile ? 18 : 20,
      isMobile,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Legal',
          style: theme.typography.title.copyWith(
            fontWeight: FontWeight.w900,
            color: theme.colors.onSurface,
            fontSize: titleFontSize,
          ),
        ),
        SizedBox(height: _getResponsiveSpacing(theme.spacing.large, isMobile)),
        ...links.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: _getResponsiveSpacing(theme.spacing.medium, isMobile),
            ),
            child: _buildFooterLink(
              context,
              title: entry.key,
              route: entry.value,
              theme: theme,
              isMobile: isMobile,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCopyrightSection(
    BuildContext context, {
    required ThemePalette theme,
    required bool isMobile,
  }) {
    if (customCopyrightSection != null) return customCopyrightSection!;
    if (!showCopyright) return const SizedBox.shrink();

    final double fontSize = _getResponsiveFontSize(14, isMobile);

    return Container(
      padding: EdgeInsets.only(
        top: _getResponsiveSpacing(theme.spacing.extraLarge, isMobile),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colors.outlineVariant,
            width: theme.borders.extraSmall,
          ),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: _getResponsiveSpacing(theme.spacing.medium, isMobile),
        runSpacing: _getResponsiveSpacing(theme.spacing.medium, isMobile),
        children: [
          Text(
            copyrightText ??
                '© ${DateTime.now().year} Blogify. All rights reserved.',
            style: theme.typography.caption.copyWith(
              color: theme.colors.onSurface.withOpacity(0.5),
              fontSize: fontSize,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Made with',
                style: theme.typography.caption.copyWith(
                  color: theme.colors.onSurface.withOpacity(0.5),
                  fontSize: fontSize,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      _getResponsiveSpacing(theme.spacing.extraSmall, isMobile),
                ),
                child: Icon(
                  Icons.favorite,
                  color: theme.colors.error,
                  size: _getResponsiveIconSize(16, isMobile),
                ),
              ),
              Text(
                'by Blogify Team',
                style: theme.typography.caption.copyWith(
                  color: theme.colors.onSurface.withOpacity(0.5),
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < breakpoint;
    final ThemePalette theme = ref.watch(themeProvider);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ??
            _getResponsiveSpacing(
              isMobile ? theme.spacing.medium : theme.spacing.large,
              isMobile,
            ),
        vertical: verticalPadding ??
            _getResponsiveSpacing(
              isMobile ? theme.spacing.large : theme.spacing.extraLarge,
              isMobile,
            ),
      ),
      color: backgroundColor ?? theme.colors.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrandSection(
                  context,
                  isMobile: isMobile,
                  theme: theme,
                ),
                if (showQuickLinks) ...[
                  SizedBox(
                      height:
                          _getResponsiveSpacing(theme.spacing.large, isMobile)),
                  _buildQuickLinksSection(
                    context,
                    theme: theme,
                    isMobile: isMobile,
                  ),
                ],
                if (showLegalLinks) ...[
                  SizedBox(
                      height:
                          _getResponsiveSpacing(theme.spacing.large, isMobile)),
                  _buildLegalSection(
                    context,
                    theme: theme,
                    isMobile: isMobile,
                  ),
                ],
              ],
            )
          else
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildBrandSection(
                      context,
                      isMobile: isMobile,
                      theme: theme,
                    ),
                  ),
                  if (showQuickLinks) ...[
                    SizedBox(
                        width: _getResponsiveSpacing(
                            theme.spacing.large, isMobile)),
                    Expanded(
                      child: _buildQuickLinksSection(
                        context,
                        theme: theme,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                  if (showLegalLinks) ...[
                    SizedBox(
                        width: _getResponsiveSpacing(
                            theme.spacing.large, isMobile)),
                    Expanded(
                      child: _buildLegalSection(
                        context,
                        theme: theme,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          if (showCopyright) ...[
            SizedBox(
                height: _getResponsiveSpacing(theme.spacing.large, isMobile)),
            _buildCopyrightSection(
              context,
              theme: theme,
              isMobile: isMobile,
            ),
          ],
        ],
      ),
    );
  }
}
