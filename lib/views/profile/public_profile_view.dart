import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';

class PublicProfileView extends ConsumerWidget {
  final String username;

  const PublicProfileView({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _PublicProfileViewContent(username: username);
  }
}

class _PublicProfileViewContent extends ConsumerStatefulWidget {
  final String username;

  const _PublicProfileViewContent({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  _PublicProfileViewContentState createState() =>
      _PublicProfileViewContentState();
}

class _PublicProfileViewContentState
    extends ConsumerState<_PublicProfileViewContent> {
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth * 0.9;

    return Scaffold(
      backgroundColor: theme.colors.surface,
      appBar: AppHeader(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: contentWidth,
            padding: EdgeInsets.symmetric(vertical: theme.spacing.extraLarge),
            child: Column(
              children: [
                // Profile Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(theme.spacing.large),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: theme.corners.roundedLarge,
                    border: Border.all(
                      color: theme.colors.outlineVariant.withOpacity(0.1),
                      width: theme.borders.small,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colors.shadow.withOpacity(0.05),
                        offset: Offset(0, 4),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Profile Image with Verified Badge
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(theme.spacing.extraSmall),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                padding:
                                    EdgeInsets.all(theme.spacing.extraSmall),
                                decoration: BoxDecoration(
                                  color: theme.colors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: theme.colors.onPrimary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing.large),
                      Text(
                        'Sarah Anderson',
                        style: theme.typography.title.copyWith(
                          color: theme.colors.onSurface,
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: theme.spacing.small),
                      Text(
                        '@sarahanderson',
                        style: theme.typography.body.copyWith(
                          color: theme.colors.onSurfaceVariant,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: theme.spacing.medium),
                      Container(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Text(
                          'Digital creator passionate about storytelling through words and visuals.\nSharing insights on tech, lifestyle, and creative writing.',
                          textAlign: TextAlign.center,
                          style: theme.typography.body.copyWith(
                            color: theme.colors.onSurface,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStat('1.2K', 'Posts'),
                          SizedBox(width: theme.spacing.extraLarge),
                          _buildStat('45.3K', 'Followers'),
                          SizedBox(width: theme.spacing.extraLarge),
                          _buildStat('892', 'Following'),
                        ],
                      ),
                      SizedBox(height: theme.spacing.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colors.primary,
                              foregroundColor: theme.colors.onPrimary,
                              padding: EdgeInsets.symmetric(
                                horizontal: theme.spacing.large,
                                vertical: theme.spacing.medium,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: theme.corners.roundedSmall,
                              ),
                            ),
                            child: Text(
                              'Follow',
                              style: theme.typography.button.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: theme.spacing.medium),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colors.secondary,
                              foregroundColor: theme.colors.onSecondary,
                              padding: EdgeInsets.symmetric(
                                horizontal: theme.spacing.large,
                                vertical: theme.spacing.medium,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: theme.corners.roundedSmall,
                              ),
                            ),
                            child: Text(
                              'Join Membership',
                              style: theme.typography.button.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: theme.spacing.medium),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colors.tertiary,
                              foregroundColor: theme.colors.onTertiary,
                              padding: EdgeInsets.symmetric(
                                horizontal: theme.spacing.large,
                                vertical: theme.spacing.medium,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: theme.corners.roundedSmall,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.card_giftcard, size: 20),
                                SizedBox(width: theme.spacing.small),
                                Text(
                                  'Tip',
                                  style: theme.typography.button.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: theme.spacing.medium),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share),
                            style: IconButton.styleFrom(
                              backgroundColor: theme.colors.surfaceVariant,
                              padding: EdgeInsets.all(theme.spacing.medium),
                              shape: RoundedRectangleBorder(
                                borderRadius: theme.corners.roundedSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialLink(Icons.link, 'Website'),
                          SizedBox(width: theme.spacing.large),
                          _buildSocialLink(Icons.facebook, 'Facebook'),
                          SizedBox(width: theme.spacing.large),
                          _buildSocialLink(
                              Icons.camera_alt_outlined, 'Instagram'),
                          SizedBox(width: theme.spacing.large),
                          _buildSocialLink(Icons.messenger_outline, 'Twitter'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // Content Section with two columns
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column - About Section
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          // About Section
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(theme.spacing.large),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: theme.corners.roundedLarge,
                              border: Border.all(
                                color: theme.colors.outlineVariant
                                    .withOpacity(0.1),
                                width: theme.borders.small,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colors.shadow.withOpacity(0.05),
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About',
                                  style: theme.typography.title.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: theme.colors.onSurface,
                                  ),
                                ),
                                SizedBox(height: theme.spacing.medium),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: theme.colors.onSurfaceVariant,
                                      size: 20,
                                    ),
                                    SizedBox(width: theme.spacing.small),
                                    Text(
                                      'San Francisco, CA',
                                      style: theme.typography.body.copyWith(
                                        fontSize: 16,
                                        color: theme.colors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: theme.spacing.medium),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: theme.colors.onSurfaceVariant,
                                      size: 20,
                                    ),
                                    SizedBox(width: theme.spacing.small),
                                    Text(
                                      'Member since March 2025',
                                      style: theme.typography.body.copyWith(
                                        fontSize: 16,
                                        color: theme.colors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: theme.spacing.medium),
                                Wrap(
                                  spacing: theme.spacing.small,
                                  runSpacing: theme.spacing.small,
                                  children: [
                                    _buildInterestTag('Tech'),
                                    _buildInterestTag('Writing'),
                                    _buildInterestTag('Photography'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: theme.spacing.large),
                          // Achievements Section
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(theme.spacing.large),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: theme.corners.roundedLarge,
                              border: Border.all(
                                color: theme.colors.outlineVariant
                                    .withOpacity(0.1),
                                width: theme.borders.small,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colors.shadow.withOpacity(0.05),
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Achievements',
                                  style: theme.typography.title.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: theme.colors.onSurface,
                                  ),
                                ),
                                SizedBox(height: theme.spacing.large),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildAchievement(
                                      Icons.star,
                                      'Top Creator',
                                      theme.colors.primary,
                                      theme.colors.primary.withOpacity(0.1),
                                    ),
                                    _buildAchievement(
                                      Icons.emoji_events,
                                      '1K Posts',
                                      theme.colors.secondary,
                                      theme.colors.secondary.withOpacity(0.1),
                                    ),
                                    _buildAchievement(
                                      Icons.favorite,
                                      '10K Likes',
                                      theme.colors.tertiary,
                                      theme.colors.tertiary.withOpacity(0.1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
                    // Right Column - Posts and Forum Activity
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Posts Section
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(theme.spacing.large),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: theme.corners.roundedLarge,
                              border: Border.all(
                                color: theme.colors.outlineVariant
                                    .withOpacity(0.1),
                                width: theme.borders.small,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colors.shadow.withOpacity(0.05),
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: theme.colors.outlineVariant
                                            .withOpacity(0.1),
                                        width: theme.borders.small,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildTab('Posts', true),
                                      SizedBox(width: theme.spacing.large),
                                      _buildTab('Followers', false),
                                      SizedBox(width: theme.spacing.large),
                                      _buildTab('Following', false),
                                    ],
                                  ),
                                ),
                                SizedBox(height: theme.spacing.large),
                                // Search and Filter Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 44,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: theme.spacing.medium),
                                      decoration: BoxDecoration(
                                        color: theme.colors.surface,
                                        borderRadius:
                                            theme.corners.roundedSmall,
                                        border: Border.all(
                                          color: theme.colors.outlineVariant
                                              .withOpacity(0.1),
                                          width: theme.borders.small,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color:
                                                theme.colors.onSurfaceVariant,
                                            size: 20,
                                          ),
                                          SizedBox(width: theme.spacing.small),
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Search posts...',
                                                hintStyle: theme.typography.body
                                                    .copyWith(
                                                  color: theme
                                                      .colors.onSurfaceVariant,
                                                  fontSize: 16,
                                                ),
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Right side controls
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: theme.spacing.medium,
                                            vertical: theme.spacing.small,
                                          ),
                                          decoration: BoxDecoration(
                                            color: theme.colors.surface,
                                            borderRadius:
                                                theme.corners.roundedMedium,
                                            border: Border.all(
                                              color: theme.colors.outlineVariant
                                                  .withOpacity(0.1),
                                              width: theme.borders.small,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Latest',
                                                style: theme.typography.button
                                                    .copyWith(
                                                  color: theme.colors.onSurface,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      theme.spacing.extraSmall),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                color: theme.colors.onSurface,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: theme.spacing.small),
                                        Container(
                                          padding: EdgeInsets.all(
                                              theme.spacing.small),
                                          decoration: BoxDecoration(
                                            color: theme.colors.primary,
                                            borderRadius:
                                                theme.corners.roundedMedium,
                                          ),
                                          child: Icon(
                                            Icons.access_time_filled,
                                            color: theme.colors.onPrimary,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: theme.spacing.small),
                                        Container(
                                          padding: EdgeInsets.all(
                                              theme.spacing.small),
                                          decoration: BoxDecoration(
                                            color: theme.colors.surface,
                                            borderRadius:
                                                theme.corners.roundedMedium,
                                            border: Border.all(
                                              color: theme.colors.outlineVariant
                                                  .withOpacity(0.1),
                                              width: theme.borders.small,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _isGridView = !_isGridView;
                                              });
                                            },
                                            child: Icon(
                                              _isGridView
                                                  ? Icons.view_list
                                                  : Icons.grid_view,
                                              color: theme.colors.onSurface,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: theme.spacing.large),
                                // Posts Grid/List
                                _isGridView
                                    ? GridView.count(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 24,
                                        crossAxisSpacing: 24,
                                        childAspectRatio: 1.6,
                                        children: [
                                          _buildGridPostCard(
                                            'Digital Art Exploration',
                                            '2 hours ago',
                                            'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
                                            1200,
                                            88,
                                            24,
                                          ),
                                          _buildGridPostCard(
                                            'Abstract Compositions',
                                            '5 hours ago',
                                            'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09',
                                            956,
                                            67,
                                            18,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          _buildPostCard(
                                            'Digital Art Exploration',
                                            '2 hours ago',
                                            'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
                                            1200,
                                            88,
                                            24,
                                          ),
                                          SizedBox(height: 32),
                                          _buildPostCard(
                                            'Abstract Compositions',
                                            '5 hours ago',
                                            'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09',
                                            956,
                                            67,
                                            18,
                                          ),
                                        ],
                                      ),
                                SizedBox(height: theme.spacing.large),
                                // Load More Button
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: theme.spacing.large,
                                      vertical: theme.spacing.medium,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.colors.surface,
                                      borderRadius: theme.corners.roundedMedium,
                                      border: Border.all(
                                        color: theme.colors.outlineVariant
                                            .withOpacity(0.1),
                                        width: theme.borders.small,
                                      ),
                                    ),
                                    child: Text(
                                      'Load More',
                                      style: theme.typography.button.copyWith(
                                        color: theme.colors.onSurface,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: theme.spacing.large),
                          // Forum Activity Section
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(theme.spacing.large),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: theme.corners.roundedLarge,
                              border: Border.all(
                                color: theme.colors.outlineVariant
                                    .withOpacity(0.1),
                                width: theme.borders.small,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colors.shadow.withOpacity(0.05),
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Forum Activity',
                                  style: theme.typography.title.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: theme.colors.onSurface,
                                  ),
                                ),
                                SizedBox(height: theme.spacing.large),
                                _buildForumPost(
                                  'Best practices for blog SEO in 2025',
                                  'Shared insights on latest SEO strategies',
                                  '2 days ago',
                                ),
                                SizedBox(height: theme.spacing.medium),
                                _buildForumPost(
                                  'Content creation tools discussion',
                                  'Recommended top tools for content creators',
                                  '5 days ago',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    final theme = ref.watch(themeProvider);
    return Column(
      children: [
        Text(
          value,
          style: theme.typography.title.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: theme.colors.onSurface,
          ),
        ),
        SizedBox(height: theme.spacing.extraSmall),
        Text(
          label,
          style: theme.typography.body.copyWith(
            fontSize: 14,
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLink(IconData icon, String platform) {
    final theme = ref.watch(themeProvider);
    return Container(
      padding: EdgeInsets.all(theme.spacing.medium),
      decoration: BoxDecoration(
        color: theme.colors.surfaceVariant,
        borderRadius: theme.corners.roundedMedium,
      ),
      child: Icon(
        icon,
        size: 20,
        color: theme.colors.onSurfaceVariant,
      ),
    );
  }

  Widget _buildInterestTag(String label) {
    final theme = ref.watch(themeProvider);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.medium,
        vertical: theme.spacing.small,
      ),
      decoration: BoxDecoration(
        color: theme.colors.primary.withOpacity(0.1),
        borderRadius: theme.corners.roundedSmall,
      ),
      child: Text(
        label,
        style: theme.typography.label.copyWith(
          fontSize: 14,
          color: theme.colors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    final theme = ref.watch(themeProvider);
    return Container(
      padding: EdgeInsets.only(bottom: theme.spacing.medium),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? theme.colors.primary : Colors.transparent,
            width: theme.borders.small,
          ),
        ),
      ),
      child: Text(
        label,
        style: theme.typography.button.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color:
              isActive ? theme.colors.primary : theme.colors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildPostCard(
    String title,
    String timeAgo,
    String imageUrl,
    int likes,
    int comments,
    int shares,
  ) {
    final theme = ref.watch(themeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: theme.corners.roundedLarge,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: theme.spacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.typography.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: theme.colors.onSurface,
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: theme.typography.body.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.medium),
              Row(
                children: [
                  _buildEngagementMetric(
                      Icons.favorite_border, likes.toString()),
                  SizedBox(width: theme.spacing.large),
                  _buildEngagementMetric(
                      Icons.chat_bubble_outline, comments.toString()),
                  SizedBox(width: theme.spacing.large),
                  _buildEngagementMetric(Icons.share, shares.toString()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEngagementMetric(IconData icon, String count) {
    final theme = ref.watch(themeProvider);
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colors.onSurfaceVariant,
        ),
        SizedBox(width: theme.spacing.small),
        Text(
          count,
          style: theme.typography.body.copyWith(
            color: theme.colors.onSurfaceVariant,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildForumPost(String title, String description, String timeAgo) {
    final theme = ref.watch(themeProvider);
    return Container(
      padding: EdgeInsets.all(theme.spacing.medium),
      decoration: BoxDecoration(
        borderRadius: theme.corners.roundedLarge,
        border: Border.all(
          color: theme.colors.outlineVariant.withOpacity(0.1),
          width: theme.borders.small,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.medium,
                  vertical: theme.spacing.small,
                ),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withOpacity(0.1),
                  borderRadius: theme.corners.roundedSmall,
                ),
                child: Text(
                  'Discussion',
                  style: theme.typography.label.copyWith(
                    fontSize: 12,
                    color: theme.colors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: theme.spacing.medium),
              Text(
                timeAgo,
                style: theme.typography.body.copyWith(
                  color: theme.colors.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.medium),
          Text(
            title,
            style: theme.typography.title.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colors.onSurface,
            ),
          ),
          SizedBox(height: theme.spacing.small),
          Text(
            description,
            style: theme.typography.body.copyWith(
              color: theme.colors.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridPostCard(
    String title,
    String timeAgo,
    String imageUrl,
    int likes,
    int comments,
    int shares,
  ) {
    final theme = ref.watch(themeProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.corners.roundedLarge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: theme.corners.roundedLarge,
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: theme.spacing.medium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.typography.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colors.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: theme.typography.body.copyWith(
                        color: theme.colors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.medium),
                Row(
                  children: [
                    _buildEngagementMetric(
                        Icons.favorite_border, likes.toString()),
                    SizedBox(width: theme.spacing.medium),
                    _buildEngagementMetric(
                        Icons.chat_bubble_outline, comments.toString()),
                    SizedBox(width: theme.spacing.medium),
                    _buildEngagementMetric(Icons.share, shares.toString()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievement(
    IconData icon,
    String label,
    Color iconColor,
    Color bgColor,
  ) {
    final theme = ref.watch(themeProvider);
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 32,
            ),
          ),
        ),
        SizedBox(height: theme.spacing.medium),
        Text(
          label,
          style: theme.typography.title.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.colors.onSurface,
          ),
        ),
      ],
    );
  }
}
