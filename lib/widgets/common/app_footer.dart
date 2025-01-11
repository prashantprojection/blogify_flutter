import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFooter extends StatelessWidget {
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

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String url,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (textColor ?? Colors.white).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: FaIcon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildFooterLink(BuildContext context, String title, String route) {
    return InkWell(
      onTap: () => context.go(route),
      child: Text(
        title,
        style: AppTheme.bodyMedium.copyWith(
          color: (textColor ?? Colors.white).withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildBrandSection(BuildContext context, bool isMobile) {
    if (customBrandSection != null) return customBrandSection!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          brandName ?? 'Blogify',
          style: AppTheme.headingMedium.copyWith(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          tagline ?? 'Empowering Bloggers, One Story at a Time',
          style: AppTheme.bodyLarge.copyWith(
            color: (textColor ?? Colors.white).withOpacity(0.7),
          ),
        ),
        if (showSocialIcons) ...[
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildSocialIcon(
                icon: FontAwesomeIcons.twitter,
                url: socialLinks?['twitter'] ?? 'https://twitter.com/blogify',
                color: const Color(0xFF1DA1F2),
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.facebook,
                url: socialLinks?['facebook'] ?? 'https://facebook.com/blogify',
                color: const Color(0xFF4267B2),
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.instagram,
                url: socialLinks?['instagram'] ??
                    'https://instagram.com/blogify',
                color: const Color(0xFFE1306C),
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.linkedin,
                url: socialLinks?['linkedin'] ??
                    'https://linkedin.com/company/blogify',
                color: const Color(0xFF0077B5),
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.github,
                url: socialLinks?['github'] ?? 'https://github.com/blogify',
                color: textColor ?? Colors.white,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildQuickLinksSection(BuildContext context) {
    if (customQuickLinks != null) return customQuickLinks!;
    if (!showQuickLinks) return const SizedBox.shrink();

    final links = quickLinks ??
        {
          'About Us': '/about',
          'Contact': '/contact',
          'Careers': '/careers',
          'Support': '/support',
        };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: AppTheme.headingSmall.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        ...links.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildFooterLink(context, entry.key, entry.value),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildLegalSection(BuildContext context) {
    if (customLegalSection != null) return customLegalSection!;
    if (!showLegalLinks) return const SizedBox.shrink();

    final links = legalLinks ??
        {
          'Terms of Service': '/terms',
          'Privacy Policy': '/privacy',
          'Cookie Policy': '/cookies',
          'Blog Guidelines': '/guidelines',
        };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Legal',
          style: AppTheme.headingSmall.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        ...links.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildFooterLink(context, entry.key, entry.value),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCopyrightSection(BuildContext context) {
    if (customCopyrightSection != null) return customCopyrightSection!;
    if (!showCopyright) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: (dividerColor ?? Colors.white).withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 16,
        runSpacing: 16,
        children: [
          Text(
            copyrightText ??
                '© ${DateTime.now().year} Blogify. All rights reserved.',
            style: AppTheme.bodySmall.copyWith(
              color: (textColor ?? Colors.white).withOpacity(0.5),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Made with',
                style: AppTheme.bodySmall.copyWith(
                  color: (textColor ?? Colors.white).withOpacity(0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red[400],
                  size: 16,
                ),
              ),
              Text(
                'by Blogify Team',
                style: AppTheme.bodySmall.copyWith(
                  color: (textColor ?? Colors.white).withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < breakpoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? (isMobile ? 24 : 32),
        vertical: verticalPadding ?? (isMobile ? 48 : 64),
      ),
      color: backgroundColor ?? const Color(0xFF1A1D1F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrandSection(context, isMobile),
                if (showQuickLinks) ...[
                  const SizedBox(height: 48),
                  _buildQuickLinksSection(context),
                ],
                if (showLegalLinks) ...[
                  const SizedBox(height: 48),
                  _buildLegalSection(context),
                ],
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildBrandSection(context, isMobile)),
                if (showQuickLinks) ...[
                  const SizedBox(width: 64),
                  Expanded(child: _buildQuickLinksSection(context)),
                ],
                if (showLegalLinks) ...[
                  const SizedBox(width: 64),
                  Expanded(child: _buildLegalSection(context)),
                ],
              ],
            ),
          if (showCopyright) ...[
            const SizedBox(height: 48),
            _buildCopyrightSection(context),
          ],
        ],
      ),
    );
  }
}
