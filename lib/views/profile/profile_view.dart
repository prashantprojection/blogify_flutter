import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'dart:math';

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
  Map<int, bool> _expandedReplies = {}; // Track expanded state for each comment
  Map<int, TextEditingController> _replyControllers =
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
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
                  border: Border.all(color: Colors.grey[200]!, width: 2),
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
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child:
                      Icon(Icons.camera_alt, size: 16, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
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
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.verified, color: Colors.blue, size: 20),
                          ],
                        ),
                        Text(
                          '@sarahanderson',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
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
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                          child: Text('Edit Profile'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.public, size: 20),
                          label: Text('Public View'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Digital content creator | Tech enthusiast | Coffee lover ☕ | Sharing insights about web development and design | 5 years of experience in frontend development',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
                Text(
                  '160/160',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildStatItem('245', 'Posts'),
                    const SizedBox(width: 24),
                    _buildStatItem('15.3K', 'Followers'),
                    const SizedBox(width: 24),
                    _buildStatItem('892', 'Following'),
                    const SizedBox(width: 24),
                    _buildStatItem('1.2K', 'Comments'),
                    const SizedBox(width: 24),
                    _buildStatItem('48', 'Forums'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSavedPosts() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saved Posts',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 300,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchPostsController,
                          decoration: InputDecoration(
                            hintText: 'Search posts...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            suffixIcon:
                                Icon(Icons.search, color: Colors.grey[400]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.5,
              ),
              itemCount: 2,
              itemBuilder: (context, index) => _buildSavedPostCard(index),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Load More',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSavedPostCard(int index) {
    final posts = [
      {
        'title': 'Getting Started with React Hooks',
        'image': 'assets/react_hooks.png',
        'tags': ['React', 'Tutorial', 'Frontend'],
      },
      {
        'title': 'TypeScript Best Practices',
        'image': 'assets/typescript.png',
        'tags': ['TypeScript', 'Development'],
      },
    ];

    final post = posts[index];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1A1F36),
                image: DecorationImage(
                  image: AssetImage(post['image'] as String),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey[900],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (post['tags'] as List<String>).map((tag) {
                    Color tagColor;
                    Color bgColor;
                    switch (tag) {
                      case 'React':
                        tagColor = Color(0xFF2563EB);
                        bgColor = Color(0xFFDBEAFE);
                        break;
                      case 'Tutorial':
                        tagColor = Color(0xFF9333EA);
                        bgColor = Color(0xFFF3E8FF);
                        break;
                      case 'Frontend':
                        tagColor = Color(0xFF16A34A);
                        bgColor = Color(0xFFDCFCE7);
                        break;
                      case 'TypeScript':
                        tagColor = Color(0xFF2563EB);
                        bgColor = Color(0xFFDBEAFE);
                        break;
                      case 'Development':
                        tagColor = Color(0xFFEA580C);
                        bgColor = Color(0xFFFFEDD5);
                        break;
                      default:
                        tagColor = Colors.blue;
                        bgColor = Colors.blue.withOpacity(0.1);
                    }
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Connections',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isFollowersTab
                          ? Color(0xFF1A1F36)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isFollowersTab = true;
                        });
                      },
                      child: Text(
                        'Followers',
                        style: TextStyle(
                          color:
                              _isFollowersTab ? Colors.white : Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: !_isFollowersTab
                          ? Color(0xFF1A1F36)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isFollowersTab = false;
                        });
                      },
                      child: Text(
                        'Following',
                        style: TextStyle(
                          color: !_isFollowersTab
                              ? Colors.white
                              : Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchConnectionsController,
              decoration: InputDecoration(
                hintText: 'Search connections...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
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
    final followers = [
      {
        'name': 'Alex Chen',
        'username': '@alexchen',
        'image': 'https://randomuser.me/api/portraits/men/1.jpg',
        'isFollowing': false,
      },
      {
        'name': 'Maria Garcia',
        'username': '@mariagarcia',
        'image': 'https://randomuser.me/api/portraits/women/2.jpg',
        'isFollowing': true,
      },
    ];

    final following = [
      {
        'name': 'John Smith',
        'username': '@johnsmith',
        'image': 'https://randomuser.me/api/portraits/men/2.jpg',
        'isFollowing': true,
      },
      {
        'name': 'Emma Wilson',
        'username': '@emmawilson',
        'image': 'https://randomuser.me/api/portraits/women/3.jpg',
        'isFollowing': true,
      },
    ];

    final items = _isFollowersTab ? followers : following;
    final item = items[index];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(item['image'] as String),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[900],
                  ),
                ),
                Text(
                  item['username'] as String,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(color: Colors.grey[200]!),
              backgroundColor:
                  item['isFollowing'] as bool ? Colors.grey[100] : Colors.white,
            ),
            child: Text(
              _isFollowersTab
                  ? (item['isFollowing'] as bool ? 'Following' : 'Follow Back')
                  : 'Following',
              style: TextStyle(
                color: item['isFollowing'] as bool
                    ? Colors.grey[700]
                    : Colors.grey[900],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Social Media',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Add New',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
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
    final socialMedia = [
      {
        'platform': 'Twitter',
        'handle': '@sarahanderson',
        'icon': FontAwesomeIcons.twitter,
        'isActive': true,
      },
      {
        'platform': 'LinkedIn',
        'handle': 'Sarah Anderson',
        'icon': FontAwesomeIcons.linkedin,
        'isActive': true,
      },
      {
        'platform': 'GitHub',
        'handle': 'sarahanderson',
        'icon': FontAwesomeIcons.github,
        'isActive': false,
      },
    ];

    final account = socialMedia[index];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          FaIcon(
            account['icon'] as IconData,
            size: 24,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 16),
          Text(
            account['handle'] as String,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: account['isActive'] as bool
                  ? Color(0xFFE8F5E9) // Light green background
                  : Color(0xFFF5F5F5), // Light grey background
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              account['isActive'] as bool ? 'Active' : 'Inactive',
              style: TextStyle(
                color: account['isActive'] as bool
                    ? Color(0xFF2E7D32) // Dark green text
                    : Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.edit,
            size: 20,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment, int index) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                comment['author'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                comment['timeAgo'] as String,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.visibility_outlined, size: 20),
                onPressed: () {
                  print(
                      'Navigate to post ${comment['postId']} at comment position');
                },
                tooltip: 'View in post: ${comment['postTitle']}',
                color: Colors.grey[600],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment['content'] as String,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Text(
                  'On: ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  comment['postTitle'] as String,
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 12,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _expandedReplies[index] == true
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Quick Reply',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_expandedReplies[index] == true) ...[
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _replyControllers[index],
                    decoration: InputDecoration(
                      hintText: 'Write a reply...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.emoji_emotions_outlined,
                                color: Colors.grey[400]),
                            onPressed: () {},
                            tooltip: 'Add emoji',
                          ),
                          IconButton(
                            icon: Icon(Icons.send, color: Colors.blue),
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
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.format_bold, color: Colors.grey[600]),
                        onPressed: () {},
                        tooltip: 'Bold',
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.format_italic, color: Colors.grey[600]),
                        onPressed: () {},
                        tooltip: 'Italic',
                      ),
                      IconButton(
                        icon: Icon(Icons.link, color: Colors.grey[600]),
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

  Widget _buildQuickReply() {
    final latestComments = [
      {
        'author': 'Sarah Anderson',
        'content':
            'Great article! The React hooks explanation really helped me understand useEffect better.',
        'timeAgo': '2h ago',
        'postTitle': 'Understanding React Hooks',
        'postId': '1',
      },
      {
        'author': 'Sarah Anderson',
        'content':
            'The comparison between Next.js and Remix is very insightful. Would love to see more content like this.',
        'timeAgo': '1d ago',
        'postTitle': 'Next.js vs Remix Comparison',
        'postId': '2',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest Comments',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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

  Widget _buildForumsParticipated() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Forums Participated',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
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
              child: Text('Load More'),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildForumItem(int index) {
    final forums = [
      {
        'title': 'Best practices for React hooks',
        'description':
            'Started a discussion about useEffect dependencies and cleanup',
        'replies': '32',
        'views': '128',
        'likes': '45',
        'timeAgo': '2h ago',
      },
      {
        'title': 'Next.js vs Remix - Pros and Cons',
        'description':
            'Comparing modern React frameworks for enterprise applications',
        'replies': '56',
        'views': '342',
        'likes': '89',
        'timeAgo': '1d ago',
      },
    ];

    final forum = forums[index];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Discussion',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                forum['timeAgo'] as String,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            forum['title'] as String,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            forum['description'] as String,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildForumStat(
                  Icons.chat_bubble_outline, forum['replies'] as String),
              const SizedBox(width: 24),
              _buildForumStat(
                  Icons.visibility_outlined, forum['views'] as String),
              const SizedBox(width: 24),
              _buildForumStat(Icons.favorite_border, forum['likes'] as String),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForumStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentNotifications() {
    final notifications = [
      {
        'type': 'like',
        'user': 'John Doe',
        'action': 'liked your post',
        'target': 'Understanding React Hooks',
        'timeAgo': '2h ago',
      },
      {
        'type': 'comment',
        'user': 'Emma Wilson',
        'action': 'commented on your post',
        'target': 'TypeScript Best Practices',
        'timeAgo': '3h ago',
      },
      {
        'type': 'follow',
        'user': 'Alex Chen',
        'action': 'started following you',
        'target': '',
        'timeAgo': '5h ago',
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              IconData icon;
              Color iconColor;
              switch (notification['type']) {
                case 'like':
                  icon = Icons.favorite;
                  iconColor = Colors.red;
                  break;
                case 'comment':
                  icon = Icons.chat_bubble;
                  iconColor = Colors.blue;
                  break;
                case 'follow':
                  icon = Icons.person_add;
                  iconColor = Colors.green;
                  break;
                default:
                  icon = Icons.notifications;
                  iconColor = Colors.grey;
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  text: notification['user'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[900],
                                  ),
                                ),
                                TextSpan(text: ' ${notification['action']} '),
                                if (notification['target']!.isNotEmpty)
                                  TextSpan(
                                    text: notification['target'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification['timeAgo'] as String,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildProfileHeader(),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _buildSavedPosts(),
                                  const SizedBox(height: 24),
                                  _buildForumsParticipated(),
                                  const SizedBox(height: 24),
                                  _buildRecentNotifications(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  _buildQuickReply(),
                                  const SizedBox(height: 24),
                                  _buildSocialMediaSection(),
                                  const SizedBox(height: 24),
                                  _buildFollowersSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
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
