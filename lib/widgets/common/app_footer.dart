import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/theme/app_theme.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      color: Color(0xFF1A1D1F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blogify',
                      style: AppTheme.headingMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Empowering Bloggers, One Story at a Time',
                      style: AppTheme.bodyLarge.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        _buildSocialLink(
                          icon: 'assets/icons/twitter.png',
                          url: 'https://twitter.com/blogify',
                        ),
                        SizedBox(width: 16),
                        _buildSocialLink(
                          icon: 'assets/icons/facebook.png',
                          url: 'https://facebook.com/blogify',
                        ),
                        SizedBox(width: 16),
                        _buildSocialLink(
                          icon: 'assets/icons/instagram.png',
                          url: 'https://instagram.com/blogify',
                        ),
                        SizedBox(width: 16),
                        _buildSocialLink(
                          icon: 'assets/icons/linkedin.png',
                          url: 'https://linkedin.com/company/blogify',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Quick Links Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Links',
                      style: AppTheme.headingSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildFooterLink(context, 'About Us', '/about'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'Contact', '/contact'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'Careers', '/careers'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'Support', '/support'),
                  ],
                ),
              ),
              // Legal Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Legal',
                      style: AppTheme.headingSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildFooterLink(context, 'Privacy Policy', '/privacy'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'Terms of Service', '/terms'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'Cookie Policy', '/cookies'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'GDPR', '/gdpr'),
                  ],
                ),
              ),
              // Resources Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resources',
                      style: AppTheme.headingSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildFooterLink(context, 'Help Center', '/help'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'Blog', '/blog'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'Newsletter', '/newsletter'),
                    SizedBox(height: 16),
                    _buildFooterLink(context, 'Community', '/community'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 64),
          Divider(color: Colors.white.withOpacity(0.1)),
          SizedBox(height: 32),
          Text(
            '© 2025 Blogify. All rights reserved.',
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(BuildContext context, String label, String path) {
    return InkWell(
      onTap: () => context.go(path),
      child: Text(
        label,
        style: AppTheme.bodyMedium.copyWith(
          color: Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildSocialLink({required String icon, required String url}) {
    return InkWell(
      onTap: () {},
      child: Image.asset(
        icon,
        width: 24,
        height: 24,
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }
}
