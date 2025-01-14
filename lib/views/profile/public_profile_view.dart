import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth * 0.9;

    return Scaffold(
      appBar: AppHeader(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: contentWidth,
            padding: EdgeInsets.symmetric(vertical: 48),
            child: Column(
              children: [
                // Profile Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFE5E7EB)),
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
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Color(0xFF3B82F6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Sarah Anderson',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '@sarahanderson',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Text(
                          'Digital creator passionate about storytelling through words and visuals.\nSharing insights on tech, lifestyle, and creative writing.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF374151),
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStat('1.2K', 'Posts'),
                          SizedBox(width: 48),
                          _buildStat('45.3K', 'Followers'),
                          SizedBox(width: 48),
                          _buildStat('892', 'Following'),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3B82F6),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF9333EA),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'Join Membership',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF10B981),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.card_giftcard, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Tip',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share),
                            style: IconButton.styleFrom(
                              backgroundColor: Color(0xFFF3F4F6),
                              padding: EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialLink(Icons.link, 'Website'),
                          SizedBox(width: 24),
                          _buildSocialLink(Icons.facebook, 'Facebook'),
                          SizedBox(width: 24),
                          _buildSocialLink(
                              Icons.camera_alt_outlined, 'Instagram'),
                          SizedBox(width: 24),
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
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Color(0xFFE5E7EB)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        color: Color(0xFF6B7280), size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'San Francisco, CA',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF374151),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today_outlined,
                                        color: Color(0xFF6B7280), size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Member since March 2025',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF374151),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _buildInterestTag('Tech'),
                                    _buildInterestTag('Writing'),
                                    _buildInterestTag('Photography'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          // Achievements Section
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Color(0xFFE5E7EB)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Achievements',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildAchievement(
                                      Icons.star,
                                      'Top Creator',
                                      Color(0xFF3B82F6),
                                      Color(0xFFDBEAFE),
                                    ),
                                    _buildAchievement(
                                      Icons.emoji_events,
                                      '1K Posts',
                                      Color(0xFF8B5CF6),
                                      Color(0xFFEDE9FE),
                                    ),
                                    _buildAchievement(
                                      Icons.favorite,
                                      '10K Likes',
                                      Color(0xFFEC4899),
                                      Color(0xFFFCE7F3),
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
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Color(0xFFE5E7EB)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Tabs
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildTab('Posts', true),
                                      SizedBox(width: 32),
                                      _buildTab('Followers', false),
                                      SizedBox(width: 32),
                                      _buildTab('Following', false),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24),
                                // Search and Filter Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Search Box
                                    Container(
                                      width: 300,
                                      height: 44,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: Color(0xFFE5E7EB)),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Color(0xFF9CA3AF),
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Search posts...',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFF9CA3AF),
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
                                        // Latest Dropdown
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Color(0xFFE5E7EB)),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Latest',
                                                style: TextStyle(
                                                  color: Color(0xFF111827),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Color(0xFF111827),
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        // Time Icon Button
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF3B82F6),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            Icons.access_time_filled,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        // Menu Icon Button
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Color(0xFFE5E7EB)),
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
                                              color: Color(0xFF374151),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 32),
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
                                SizedBox(height: 24),
                                // Load More Button
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Color(0xFFE5E7EB)),
                                    ),
                                    child: Text(
                                      'Load More',
                                      style: TextStyle(
                                        color: Color(0xFF111827),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          // Forum Activity Section
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Color(0xFFE5E7EB)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Forum Activity',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                SizedBox(height: 24),
                                _buildForumPost(
                                  'Best practices for blog SEO in 2025',
                                  'Shared insights on latest SEO strategies',
                                  '2 days ago',
                                ),
                                SizedBox(height: 16),
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
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLink(IconData icon, String platform) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 20,
        color: Color(0xFF374151),
      ),
    );
  }

  Widget _buildInterestTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF3B82F6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF3B82F6),
          fontWeight: FontWeight.w500,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Content
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Engagement Metrics
              Row(
                children: [
                  _buildEngagementMetric(
                      Icons.favorite_border, likes.toString()),
                  SizedBox(width: 24),
                  _buildEngagementMetric(
                      Icons.chat_bubble_outline, comments.toString()),
                  SizedBox(width: 24),
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
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Color(0xFF6B7280),
        ),
        SizedBox(width: 8),
        Text(
          count,
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildForumPost(String title, String description, String timeAgo) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Discussion',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF3B82F6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                timeAgo,
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? Color(0xFF3B82F6) : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isActive ? Color(0xFF3B82F6) : Color(0xFF6B7280),
        ),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with 16:9 aspect ratio
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(top: 12),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Engagement Metrics
                Row(
                  children: [
                    _buildEngagementMetric(
                        Icons.favorite_border, likes.toString()),
                    SizedBox(width: 16),
                    _buildEngagementMetric(
                        Icons.chat_bubble_outline, comments.toString()),
                    SizedBox(width: 16),
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
        SizedBox(height: 16),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}
