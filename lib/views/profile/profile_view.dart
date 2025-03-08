import 'package:blogify_flutter/models/theme_palette.dart';
import 'package:blogify_flutter/views/profile/profile_temp_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final TextEditingController _searchPostsController = TextEditingController();
  final TextEditingController _searchConnectionsController =
      TextEditingController();
  final TextEditingController _quickReplyController = TextEditingController();
  bool _isFollowersTab = true;
  final Map<int, bool> _expandedReplies =
      {}; // Track expanded state for each comment
  final Map<int, TextEditingController> _replyControllers =
      {}; // Controllers for each comment's reply

  @override
  void initState() {
    super.initState();
    // Initialize controllers for the sample comments
    for (int i = 0; i < 2; i++) {
      _replyControllers[i] = TextEditingController();
      _expandedReplies[i] = false;
    }
  }

  @override
  void dispose() {
    _searchPostsController.dispose();
    _searchConnectionsController.dispose();
    _quickReplyController.dispose();
    // Dispose all reply controllers
    _replyControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Widget _buildProfileHeader() {
    final theme = ref.watch(themeProvider);
    return Container(
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
      margin: EdgeInsets.symmetric(horizontal: theme.spacing.large),
      padding: EdgeInsets.all(theme.spacing.large),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colors.outlineVariant.withOpacity(0.2),
                    width: theme.borders.small,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(theme.spacing.small),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colors.outlineVariant.withOpacity(0.2),
                      width: theme.borders.small,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colors.shadow.withOpacity(0.05),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: theme.spacing.large),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Sarah Anderson',
                              style: theme.typography.title.copyWith(
                                color: theme.colors.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: theme.spacing.small),
                            Icon(
                              Icons.verified,
                              color: theme.colors.primary,
                              size: 20,
                            ),
                          ],
                        ),
                        Text(
                          '@sarahanderson',
                          style: theme.typography.body.copyWith(
                            color: theme.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.large,
                              vertical: theme.spacing.medium,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: theme.corners.roundedMedium,
                            ),
                            side: BorderSide(
                              color:
                                  theme.colors.outlineVariant.withOpacity(0.2),
                              width: theme.borders.small,
                            ),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: theme.typography.button.copyWith(
                              color: theme.colors.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: theme.spacing.medium),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.public,
                            size: 20,
                            color: theme.colors.onSurface,
                          ),
                          label: Text(
                            'Public View',
                            style: theme.typography.button.copyWith(
                              color: theme.colors.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.large,
                              vertical: theme.spacing.medium,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: theme.corners.roundedMedium,
                            ),
                            side: BorderSide(
                              color:
                                  theme.colors.outlineVariant.withOpacity(0.2),
                              width: theme.borders.small,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.medium),
                Text(
                  'Digital content creator | Tech enthusiast | Coffee lover ☕ | Sharing insights about web development and design | 5 years of experience in frontend development',
                  style: theme.typography.body.copyWith(
                    color: theme.colors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                Text(
                  '160/160',
                  style: theme.typography.caption.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: theme.spacing.medium),
                Row(
                  children: [
                    _buildStatItem('245', 'Posts', theme),
                    SizedBox(width: theme.spacing.large),
                    _buildStatItem('15.3K', 'Followers', theme),
                    SizedBox(width: theme.spacing.large),
                    _buildStatItem('892', 'Following', theme),
                    SizedBox(width: theme.spacing.large),
                    _buildStatItem('1.2K', 'Comments', theme),
                    SizedBox(width: theme.spacing.large),
                    _buildStatItem('48', 'Forums', theme),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, ThemePalette theme) {
    return Column(
      children: [
        Text(
          value,
          style: theme.typography.title.copyWith(
            color: theme.colors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: theme.typography.body.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSavedPosts() {
    final theme = ref.watch(themeProvider);
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.large),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saved Posts',
                  style: theme.typography.title.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchPostsController,
                          decoration: InputDecoration(
                            hintText: 'Search posts...',
                            hintStyle: theme.typography.body.copyWith(
                              color: theme.colors.onSurfaceVariant
                                  .withOpacity(0.7),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: theme.corners.roundedMedium,
                              borderSide: BorderSide(
                                color: theme.colors.outlineVariant
                                    .withOpacity(0.2),
                                width: theme.borders.small,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: theme.corners.roundedMedium,
                              borderSide: BorderSide(
                                color: theme.colors.outlineVariant
                                    .withOpacity(0.2),
                                width: theme.borders.small,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.medium,
                            ),
                            suffixIcon: Icon(
                              Icons.search,
                              color: theme.colors.onSurfaceVariant
                                  .withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: theme.spacing.medium),
                      Container(
                        padding: EdgeInsets.all(theme.spacing.small),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colors.outlineVariant.withOpacity(0.2),
                            width: theme.borders.small,
                          ),
                          borderRadius: theme.corners.roundedMedium,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.large),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: theme.spacing.large,
                mainAxisSpacing: theme.spacing.large,
                childAspectRatio: 1.5,
              ),
              itemCount: 2,
              itemBuilder: (context, index) => _buildSavedPostCard(index),
            ),
          ),
          SizedBox(height: theme.spacing.large),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Load More',
                style: theme.typography.button.copyWith(
                  color: theme.colors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: theme.spacing.large),
        ],
      ),
    );
  }

  Widget _buildSavedPostCard(int index) {
    final theme = ref.watch(themeProvider);
    final post = posts[index];

    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colors.surfaceVariant,
                image: DecorationImage(
                  image: AssetImage(post['image'] as String),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(theme.spacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'] as String,
                  style: theme.typography.title.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: theme.spacing.medium),
                Wrap(
                  spacing: theme.spacing.small,
                  runSpacing: theme.spacing.small,
                  children: (post['tags'] as List<String>).map((tag) {
                    Color tagColor;
                    Color bgColor;
                    switch (tag) {
                      case 'React':
                        tagColor = theme.colors.primary;
                        bgColor = theme.colors.primary.withOpacity(0.1);
                        break;
                      case 'Tutorial':
                        tagColor = theme.colors.secondary;
                        bgColor = theme.colors.secondary.withOpacity(0.1);
                        break;
                      case 'Frontend':
                        tagColor = Color(0xFF16A34A);
                        bgColor = Color(0xFFDCFCE7);
                        break;
                      case 'TypeScript':
                        tagColor = theme.colors.primary;
                        bgColor = theme.colors.primary.withOpacity(0.1);
                        break;
                      case 'Development':
                        tagColor = Color(0xFFEA580C);
                        bgColor = Color(0xFFFFEDD5);
                        break;
                      default:
                        tagColor = theme.colors.primary;
                        bgColor = theme.colors.primary.withOpacity(0.1);
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.medium,
                        vertical: theme.spacing.small,
                      ),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: theme.corners.roundedSmall,
                      ),
                      child: Text(
                        tag,
                        style: theme.typography.label.copyWith(
                          color: tagColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowersSection() {
    final theme = ref.watch(themeProvider);
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.large),
            child: Text(
              'Connections',
              style: theme.typography.title.copyWith(
                color: theme.colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.medium,
              vertical: theme.spacing.small,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isFollowersTab
                          ? theme.colors.primary
                          : Colors.transparent,
                      borderRadius: theme.corners.roundedMedium,
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isFollowersTab = true;
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: theme.spacing.medium,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: theme.corners.roundedMedium,
                        ),
                      ),
                      child: Text(
                        'Followers',
                        style: theme.typography.button.copyWith(
                          color: _isFollowersTab
                              ? theme.colors.onPrimary
                              : theme.colors.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: theme.spacing.small),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: !_isFollowersTab
                          ? theme.colors.primary
                          : Colors.transparent,
                      borderRadius: theme.corners.roundedMedium,
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isFollowersTab = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: theme.spacing.medium,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: theme.corners.roundedMedium,
                        ),
                      ),
                      child: Text(
                        'Following',
                        style: theme.typography.button.copyWith(
                          color: !_isFollowersTab
                              ? theme.colors.onPrimary
                              : theme.colors.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(theme.spacing.medium),
            child: TextField(
              controller: _searchConnectionsController,
              decoration: InputDecoration(
                hintText: 'Search connections...',
                hintStyle: theme.typography.body.copyWith(
                  color: theme.colors.onSurfaceVariant.withOpacity(0.7),
                ),
                border: OutlineInputBorder(
                  borderRadius: theme.corners.roundedMedium,
                  borderSide: BorderSide(
                    color: theme.colors.outlineVariant.withOpacity(0.2),
                    width: theme.borders.small,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: theme.corners.roundedMedium,
                  borderSide: BorderSide(
                    color: theme.colors.outlineVariant.withOpacity(0.2),
                    width: theme.borders.small,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.medium,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: theme.colors.onSurfaceVariant.withOpacity(0.7),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => _buildFollowerItem(index),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowerItem(int index) {
    final theme = ref.watch(themeProvider);
    final items = _isFollowersTab ? followers : following;
    final item = items[index];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.medium,
        vertical: theme.spacing.medium,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colors.primary.withOpacity(0.2),
                width: theme.borders.small,
              ),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(item['image'] as String),
            ),
          ),
          SizedBox(width: theme.spacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: theme.typography.title.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item['username'] as String,
                  style: theme.typography.body.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.medium,
                vertical: theme.spacing.small,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: theme.corners.roundedMedium,
              ),
              side: BorderSide(
                color: theme.colors.outlineVariant.withOpacity(0.2),
                width: theme.borders.small,
              ),
              backgroundColor: item['isFollowing'] as bool
                  ? theme.colors.surfaceVariant.withOpacity(0.5)
                  : theme.colors.surface,
            ),
            child: Text(
              _isFollowersTab
                  ? (item['isFollowing'] as bool ? 'Following' : 'Follow Back')
                  : 'Following',
              style: theme.typography.button.copyWith(
                color: item['isFollowing'] as bool
                    ? theme.colors.onSurfaceVariant
                    : theme.colors.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    final theme = ref.watch(themeProvider);
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.large),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Social Media',
                  style: theme.typography.title.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Add New',
                    style: theme.typography.button.copyWith(
                      color: theme.colors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => _buildSocialMediaItem(index),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaItem(int index) {
    final theme = ref.watch(themeProvider);
    final account = socialMedia[index];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: theme.spacing.large,
        vertical: theme.spacing.small,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.medium,
        vertical: theme.spacing.medium,
      ),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: theme.corners.roundedLarge,
        border: Border.all(
          color: theme.colors.outlineVariant.withOpacity(0.1),
          width: theme.borders.small,
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            account['icon'] as IconData,
            size: 24,
            color: theme.colors.onSurfaceVariant,
          ),
          SizedBox(width: theme.spacing.medium),
          Text(
            account['handle'] as String,
            style: theme.typography.body.copyWith(
              color: theme.colors.onSurface,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.medium,
              vertical: theme.spacing.small,
            ),
            decoration: BoxDecoration(
              color: account['isActive'] as bool
                  ? theme.colors.primary.withOpacity(0.1)
                  : theme.colors.surfaceVariant.withOpacity(0.5),
              borderRadius: theme.corners.roundedSmall,
            ),
            child: Text(
              account['isActive'] as bool ? 'Active' : 'Inactive',
              style: theme.typography.label.copyWith(
                color: account['isActive'] as bool
                    ? theme.colors.primary
                    : theme.colors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: theme.spacing.medium),
          Icon(
            Icons.edit,
            size: 20,
            color: theme.colors.onSurfaceVariant.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReply() {
    final theme = ref.watch(themeProvider);
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.large),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest Comments',
                  style: theme.typography.title.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: latestComments.length,
            itemBuilder: (context, index) =>
                _buildCommentItem(latestComments[index], index),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment, int index) {
    final theme = ref.watch(themeProvider);
    return Container(
      padding: EdgeInsets.all(theme.spacing.medium),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colors.outlineVariant.withOpacity(0.1),
            width: theme.borders.small,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                comment['author'] as String,
                style: theme.typography.title.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: theme.spacing.small),
              Text(
                comment['timeAgo'] as String,
                style: theme.typography.caption.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.visibility_outlined,
                  size: 20,
                  color: theme.colors.onSurfaceVariant,
                ),
                onPressed: () {
                  print(
                      'Navigate to post ${comment['postId']} at comment position');
                },
                tooltip: 'View in post: ${comment['postTitle']}',
              ),
            ],
          ),
          SizedBox(height: theme.spacing.small),
          Text(
            comment['content'] as String,
            style: theme.typography.body.copyWith(
              color: theme.colors.onSurface,
              height: 1.5,
            ),
          ),
          SizedBox(height: theme.spacing.medium),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.medium,
              vertical: theme.spacing.small,
            ),
            decoration: BoxDecoration(
              color: theme.colors.surfaceVariant.withOpacity(0.5),
              borderRadius: theme.corners.roundedMedium,
              border: Border.all(
                color: theme.colors.outlineVariant.withOpacity(0.1),
                width: theme.borders.small,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'On: ',
                  style: theme.typography.caption.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
                Text(
                  comment['postTitle'] as String,
                  style: theme.typography.caption.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _expandedReplies[index] = !(_expandedReplies[index] ?? false);
              });
            },
            borderRadius: theme.corners.roundedMedium,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: theme.spacing.medium,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _expandedReplies[index] == true
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                    color: theme.colors.onSurfaceVariant,
                  ),
                  SizedBox(width: theme.spacing.small),
                  Text(
                    'Quick Reply',
                    style: theme.typography.button.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_expandedReplies[index] == true) ...[
            Container(
              padding: EdgeInsets.all(theme.spacing.medium),
              decoration: BoxDecoration(
                color: theme.colors.surfaceVariant.withOpacity(0.5),
                borderRadius: theme.corners.roundedMedium,
                border: Border.all(
                  color: theme.colors.outlineVariant.withOpacity(0.1),
                  width: theme.borders.small,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _replyControllers[index],
                    decoration: InputDecoration(
                      hintText: 'Write a reply...',
                      hintStyle: theme.typography.body.copyWith(
                        color: theme.colors.onSurfaceVariant.withOpacity(0.7),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: theme.corners.roundedMedium,
                        borderSide: BorderSide(
                          color: theme.colors.outlineVariant.withOpacity(0.2),
                          width: theme.borders.small,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: theme.corners.roundedMedium,
                        borderSide: BorderSide(
                          color: theme.colors.outlineVariant.withOpacity(0.2),
                          width: theme.borders.small,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.medium,
                        vertical: theme.spacing.medium,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: theme.colors.onSurfaceVariant
                                  .withOpacity(0.7),
                            ),
                            onPressed: () {},
                            tooltip: 'Add emoji',
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.send,
                              color: theme.colors.primary,
                            ),
                            onPressed: () {
                              if (_replyControllers[index]!.text.isNotEmpty) {
                                print(
                                    'Sending reply to comment ${comment['postId']}: ${_replyControllers[index]!.text}');
                                _replyControllers[index]!.clear();
                                setState(() {
                                  _expandedReplies[index] = false;
                                });
                              }
                            },
                            tooltip: 'Send reply',
                          ),
                        ],
                      ),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: theme.spacing.small),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.format_bold,
                          color: theme.colors.onSurfaceVariant,
                        ),
                        onPressed: () {},
                        tooltip: 'Bold',
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.format_italic,
                          color: theme.colors.onSurfaceVariant,
                        ),
                        onPressed: () {},
                        tooltip: 'Italic',
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.link,
                          color: theme.colors.onSurfaceVariant,
                        ),
                        onPressed: () {},
                        tooltip: 'Insert link',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildForumsParticipated() {
    final theme = ref.watch(themeProvider);
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.large),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Forums Participated',
                  style: theme.typography.title.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.colors.onSurfaceVariant,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => _buildForumItem(index),
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Load More',
                style: theme.typography.button.copyWith(
                  color: theme.colors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: theme.spacing.large),
        ],
      ),
    );
  }

  Widget _buildForumItem(int index) {
    final theme = ref.watch(themeProvider);
    final forum = forums[index];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: theme.spacing.large,
        vertical: theme.spacing.small,
      ),
      padding: EdgeInsets.all(theme.spacing.medium),
      decoration: BoxDecoration(
        color: theme.colors.surface,
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
                    color: theme.colors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: theme.spacing.medium),
              Text(
                forum['timeAgo'] as String,
                style: theme.typography.body.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.medium),
          Text(
            forum['title'] as String,
            style: theme.typography.title.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: theme.spacing.small),
          Text(
            forum['description'] as String,
            style: theme.typography.body.copyWith(
              color: theme.colors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          SizedBox(height: theme.spacing.medium),
          Row(
            children: [
              _buildForumStat(
                  Icons.chat_bubble_outline, forum['replies'] as String),
              SizedBox(width: theme.spacing.large),
              _buildForumStat(
                  Icons.visibility_outlined, forum['views'] as String),
              SizedBox(width: theme.spacing.large),
              _buildForumStat(Icons.favorite_border, forum['likes'] as String),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForumStat(IconData icon, String value) {
    final theme = ref.watch(themeProvider);
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colors.onSurfaceVariant,
        ),
        SizedBox(width: theme.spacing.small),
        Text(
          value,
          style: theme.typography.body.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: theme.spacing.large),
                      _buildProfileHeader(),
                      SizedBox(height: theme.spacing.large),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.large),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _buildSavedPosts(),
                                  SizedBox(height: theme.spacing.large),
                                  _buildForumsParticipated(),
                                ],
                              ),
                            ),
                            SizedBox(width: theme.spacing.large),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  _buildQuickReply(),
                                  SizedBox(height: theme.spacing.large),
                                  _buildSocialMediaSection(),
                                  SizedBox(height: theme.spacing.large),
                                  _buildFollowersSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: theme.spacing.large),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
