import 'package:flutter/material.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/inputs/search_box.dart';
import 'package:blogify_flutter/widgets/common/cards/hoverable_card.dart';
import 'package:blogify_flutter/widgets/common/loading/loading_shimmer.dart';
import 'package:blogify_flutter/widgets/common/menu_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/utils/menu_drawer.dart';

class CommunityForumView extends ConsumerWidget {
  const CommunityForumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          // Header Section - Fixed
          AppHeader.custom(
            title: 'Community & Forum',
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 1,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            titleStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
            actions: [
              SearchBox(
                hintText: 'Search discussions...',
                width: 280,
                height: 40,
                backgroundColor: Colors.grey.shade50,
                onChanged: (value) {
                  // Implement search functionality
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () {
                  // Implement filter functionality
                },
                tooltip: 'Filter discussions',
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 24,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  size: 24,
                ),
                onPressed: () => MenuDrawer.open(context),
              ),
            ],
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Community Categories Section - Full Width
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.075),
                          _buildCategoryCard(
                            icon: Icons.edit,
                            title: 'Writing Tips',
                            description: 'Share and learn writing techniques',
                            color: Colors.blue.shade50,
                            iconColor: Colors.blue.shade700,
                          ),
                          _buildCategoryCard(
                            icon: Icons.feedback,
                            title: 'Feedback Requests',
                            description: 'Get feedback on your content',
                            color: Colors.purple.shade50,
                            iconColor: Colors.purple.shade700,
                          ),
                          _buildCategoryCard(
                            icon: Icons.lightbulb,
                            title: 'Ideas & Inspiration',
                            description: 'Find your next writing topic',
                            color: Colors.green.shade50,
                            iconColor: Colors.green.shade700,
                          ),
                          _buildCategoryCard(
                            icon: Icons.group,
                            title: 'Collaborations',
                            description: 'Connect with other writers',
                            color: Colors.orange.shade50,
                            iconColor: Colors.orange.shade700,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.075),
                        ],
                      ),
                    ),
                  ),

                  // Content Section with 85% width
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            // Forum Threads Section
                            ..._buildThreadsList(),

                            const SizedBox(height: 16),

                            // Load More Button
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Implement load more functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Load More Discussions'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement new post creation
        },
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: HoverableCard(
        elevation: 1,
        hoverElevation: 8,
        shadowColor: iconColor.withOpacity(0.2),
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        onTap: () {},
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32, color: iconColor),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                softWrap: false,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  height: 1.2,
                ),
                softWrap: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildThreadsList() {
    return [
      _buildThreadCard(
        avatar: 'assets/avatars/sarah.jpg',
        author: 'Sarah Mitchell',
        title: 'How to create engaging blog introductions?',
        time: '2 hours ago',
        category: 'Writing Tips',
        replies: 24,
        views: 142,
      ),
      const SizedBox(height: 16),
      _buildThreadCard(
        avatar: 'assets/avatars/john.jpg',
        author: 'John Cooper',
        title: 'Looking for feedback on my latest tech article',
        time: '5 hours ago',
        category: 'Feedback',
        replies: 18,
        views: 89,
      ),
      const SizedBox(height: 16),
      _buildThreadCard(
        avatar: 'assets/avatars/emma.jpg',
        author: 'Emma Watson',
        title: 'Tips for writing compelling story endings',
        time: '1 day ago',
        category: 'Writing Tips',
        replies: 45,
        views: 230,
      ),
      const SizedBox(height: 16),
      _buildThreadCard(
        avatar: 'assets/avatars/michael.jpg',
        author: 'Michael Chen',
        title: 'Anyone interested in co-authoring a tech series?',
        time: '2 days ago',
        category: 'Collaborations',
        replies: 32,
        views: 178,
      ),
      const SizedBox(height: 16),
      _buildThreadCard(
        avatar: 'assets/avatars/sophia.jpg',
        author: 'Sophia Rodriguez',
        title: 'How do you overcome writer\'s block?',
        time: '3 days ago',
        category: 'Ideas & Inspiration',
        replies: 67,
        views: 345,
      ),
      const SizedBox(height: 16),
      _buildThreadCard(
        avatar: 'assets/avatars/david.jpg',
        author: 'David Kim',
        title: 'Need feedback on my blog\'s visual design',
        time: '4 days ago',
        category: 'Feedback',
        replies: 29,
        views: 156,
      ),
      const SizedBox(height: 16),
      _buildThreadCard(
        avatar: 'assets/avatars/lisa.jpg',
        author: 'Lisa Thompson',
        title: 'Best practices for SEO optimization in 2024',
        time: '5 days ago',
        category: 'Writing Tips',
        replies: 51,
        views: 289,
      ),
      const SizedBox(height: 16),
      _buildThreadCard(
        avatar: 'assets/avatars/james.jpg',
        author: 'James Wilson',
        title: 'Looking for writers in the AI/ML space',
        time: '6 days ago',
        category: 'Collaborations',
        replies: 38,
        views: 203,
      ),
    ];
  }

  Widget _buildThreadCard({
    required String avatar,
    required String author,
    required String title,
    required String time,
    required String category,
    required int replies,
    required int views,
  }) {
    final badgeColor = _getCategoryColor(category);

    return HoverableCard(
      elevation: 2,
      hoverElevation: 12,
      shadowColor: badgeColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
      backgroundColor: Colors.white,
      duration: const Duration(milliseconds: 150),
      onTap: () {},
      hoverColor: badgeColor.withOpacity(0.02),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(avatar),
              radius: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'by $author',
                          style: const TextStyle(
                            color: Color(0xFF4B5563),
                            fontSize: 15,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• $time',
                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: badgeColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMetricColumn(
                      icon: Icons.chat_bubble_outline,
                      count: replies,
                      label: 'Replies',
                    ),
                    const SizedBox(width: 32),
                    _buildMetricColumn(
                      icon: Icons.visibility_outlined,
                      count: views,
                      label: 'Views',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricColumn({
    required IconData icon,
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: const Color(0xFF374151),
            ),
            const SizedBox(width: 6),
            Text(
              '$count',
              style: const TextStyle(
                color: Color(0xFF374151),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF374151),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Writing Tips':
        return const Color(0xFF2563EB); // Blue
      case 'Feedback':
        return const Color(0xFF7C3AED); // Purple
      case 'Ideas & Inspiration':
        return const Color(0xFF059669); // Green
      case 'Collaborations':
        return const Color(0xFFD97706); // Orange
      default:
        return const Color(0xFF2563EB); // Default blue
    }
  }
}
