import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/app_footer.dart';
import 'package:blogify_flutter/widgets/common/hoverable_cards.dart';
import 'package:blogify_flutter/widgets/common/neon_border_effect.dart';

final viewTypeProvider =
    StateProvider<bool>((ref) => false); // false = list view, true = grid view
final selectedCategoriesProvider = StateProvider<List<String>>((ref) => []);

// Add hover state providers for different card types
final hoveredTrendingTopicProvider = StateProvider<String?>((ref) => null);
final hoveredFeaturedPostProvider = StateProvider<String?>((ref) => null);
final hoveredLatestPostProvider = StateProvider<String?>((ref) => null);
final hoveredCollectionProvider = StateProvider<String?>((ref) => null);
final hoveredHighlightProvider = StateProvider<String?>((ref) => null);
final hoveredAuthorProvider = StateProvider<String?>((ref) => null);
final hoveredAuthorButtonProvider = StateProvider<String?>((ref) => null);

// Add collections data
final List<Map<String, dynamic>> collections = [
  {
    'title': 'Travel Adventures',
    'description': 'Curated selection of the best travel experiences...',
    'images': <String>[
      'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf',
      'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09',
      'https://images.unsplash.com/photo-1593941707882-a5bba14938c7',
    ],
  },
  {
    'title': 'Tech Innovations',
    'description': 'Latest breakthroughs in technology and science...',
    'images': <String>[
      'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158',
      'https://images.unsplash.com/photo-1563770660941-20978e870e26',
      'https://images.unsplash.com/photo-1451187580459-43490279c0fa',
    ],
  },
  {
    'title': 'Culinary Delights',
    'description': 'Explore world cuisines and cooking techniques...',
    'images': <String>[
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38',
    ],
  },
  {
    'title': 'Urban Photography',
    'description': 'Stunning cityscapes and street photography...',
    'images': <String>[
      'https://images.unsplash.com/photo-1449824913935-59a10b8d2000',
      'https://images.unsplash.com/photo-1444723121867-7a241cacace9',
      'https://images.unsplash.com/photo-1514924013411-cbf25faa35bb',
    ],
  },
  {
    'title': 'Fitness & Wellness',
    'description': 'Tips for healthy living and workout routines...',
    'images': <String>[
      'https://images.unsplash.com/photo-1517836357463-d25dfeac3438',
      'https://images.unsplash.com/photo-1518611012118-696072aa579a',
      'https://images.unsplash.com/photo-1574680096145-d05b474e2155',
    ],
  },
  {
    'title': 'Art & Design',
    'description': 'Creative inspiration and artistic techniques...',
    'images': <String>[
      'https://images.unsplash.com/photo-1513364776144-60967b0f800f',
      'https://images.unsplash.com/photo-1513364776144-60967b0f800f',
      'https://images.unsplash.com/photo-1513364776144-60967b0f800f',
    ],
  },
  {
    'title': 'Nature Escapes',
    'description': 'Beautiful landscapes and outdoor adventures...',
    'images': <String>[
      'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
      'https://images.unsplash.com/photo-1439853949127-fa647821eba0',
      'https://images.unsplash.com/photo-1455218873509-8097305ee378',
    ],
  },
  {
    'title': 'Home & Living',
    'description': 'Interior design and home improvement ideas...',
    'images': <String>[
      'https://images.unsplash.com/photo-1484154218962-a197022b5858',
      'https://images.unsplash.com/photo-1493809842364-78817add7ffb',
      'https://images.unsplash.com/photo-1501183638710-841dd1904471',
    ],
  },
];

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  ConsumerState<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  String selectedCategory = 'Most Popular';
  bool isHovered = false;

  // Add a method to calculate grid columns based on screen width
  int _getGridColumns(double width) {
    if (width > 1500) return 4;
    if (width > 1200) return 3;
    if (width > 800) return 2;
    return 1;
  }

  // Add a method to calculate item spacing based on screen width
  double _getItemSpacing(double width) {
    if (width > 1200) return 24;
    if (width > 800) return 16;
    return 12;
  }

  // Update the grid columns calculation for collections
  int _getCollectionGridColumns(double width) {
    if (width > 1800) return 4;
    if (width > 1400) return 3;
    if (width > 800) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final isGridView = ref.watch(viewTypeProvider);
    final selectedCategories = ref.watch(selectedCategoriesProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final gridColumns = _getGridColumns(screenWidth);
    final itemSpacing = _getItemSpacing(screenWidth);
    final contentWidth =
        screenWidth > 1600 ? screenWidth * 0.7 : screenWidth * 0.85;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Section (23% width)
                Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Section
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Explore the World of Blogging',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  // Modern Search Box
                                  MouseRegion(
                                    cursor: SystemMouseCursors.text,
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.04),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 16),
                                            child: Icon(
                                              Icons.search_rounded,
                                              color: AppTheme.primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF1F2937),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'Search...',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  vertical: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 28,
                                            width: 1,
                                            color: Colors.grey.shade200,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                          ),
                                          Tooltip(
                                            message: 'Advanced filters',
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: Icon(
                                                    Icons.tune_rounded,
                                                    color:
                                                        AppTheme.primaryColor,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 48),

                            // Trending Topics Section
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trending Topics',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  _buildTrendingTopic(
                                    'Travel Diaries',
                                    Icons.flight_takeoff,
                                    '2.5k',
                                    Colors.blue,
                                  ),
                                  SizedBox(height: 12),
                                  _buildTrendingTopic(
                                    'Tech Innovations',
                                    Icons.computer,
                                    '1.4k',
                                    Colors.purple,
                                  ),
                                  SizedBox(height: 12),
                                  _buildTrendingTopic(
                                    'Food & Recipes',
                                    Icons.restaurant_menu,
                                    '1.2k',
                                    Colors.orange,
                                  ),
                                  SizedBox(height: 16),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('View All Topics'),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(50, 30),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 48),

                            // Sort By Section
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sort By',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  _buildSortByDropdown(),
                                ],
                              ),
                            ),

                            SizedBox(height: 48),

                            // Popular Authors Section
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Popular Authors',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  _buildPopularAuthor(
                                    'Sarah Johnson',
                                    '12.4k followers',
                                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                                  ),
                                  SizedBox(height: 12),
                                  _buildPopularAuthor(
                                    'Mark Thompson',
                                    '8.3k followers',
                                    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
                                  ),
                                  SizedBox(height: 12),
                                  _buildPopularAuthor(
                                    'Emily Chen',
                                    '15.2k followers',
                                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
                                  ),
                                  SizedBox(height: 12),
                                  _buildPopularAuthor(
                                    'David Wilson',
                                    '10.1k followers',
                                    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e',
                                  ),
                                  SizedBox(height: 12),
                                  _buildPopularAuthor(
                                    'Sofia Rodriguez',
                                    '9.8k followers',
                                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb',
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 48),

                            // Stay Updated Section
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Container(
                                padding: EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.blue.shade300,
                                      Colors.purple.shade300,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stay Updated!',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Get exclusive content delivered to your inbox',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    MouseRegion(
                                      onEnter: (_) =>
                                          setState(() => isHovered = true),
                                      onExit: (_) =>
                                          setState(() => isHovered = false),
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: isHovered
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                    blurRadius: 8,
                                                    spreadRadius: 2,
                                                  ),
                                                ]
                                              : [],
                                        ),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Enter your email',
                                            hintStyle: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 14,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    MouseRegion(
                                      onEnter: (_) =>
                                          setState(() => isHovered = true),
                                      onExit: (_) =>
                                          setState(() => isHovered = false),
                                      child: Container(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('Subscribe'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor:
                                                Colors.blue.shade700,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12),
                                            elevation: isHovered ? 8 : 0,
                                            shadowColor: isHovered
                                                ? Colors.white.withOpacity(0.3)
                                                : Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
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
                      ),
                    ),
                  ),
                ),

                // Right Section (77% width)
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey.shade50,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Featured Posts Section
                          Text(
                            'Featured Posts',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: _buildFeaturedPostCard(
                                  'Ultimate Travel Guide 2025',
                                  'Discover the most breathtaking destinations for your next adventure...',
                                  'https://images.unsplash.com/photo-1585409677983-0f6c41ca9c3b',
                                  'Alex Rives',
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: _buildFeaturedPostCard(
                                  'Future of Technology',
                                  'Exploring the latest trends in AI and machine learning...',
                                  'https://images.unsplash.com/photo-1581783898377-1c85bf937427',
                                  'Marie Chen',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: _buildFeaturedPostCard(
                                  'Sustainable Living',
                                  'Simple ways to reduce your carbon footprint and live eco-friendly...',
                                  'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09',
                                  'Emma Green',
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: _buildFeaturedPostCard(
                                  'Modern Architecture',
                                  'Exploring innovative designs and sustainable building practices...',
                                  'https://images.unsplash.com/photo-1511818966892-d7d671e672a2',
                                  'James Foster',
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 40),

                          // Latest Posts Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Latest Posts',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isGridView
                                          ? Icons.grid_view
                                          : Icons.view_agenda,
                                      color: Colors.grey.shade700,
                                    ),
                                    onPressed: () {
                                      ref
                                          .read(viewTypeProvider.notifier)
                                          .state = !isGridView;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          if (isGridView)
                            Wrap(
                              spacing: 24,
                              runSpacing: 24,
                              children: List.generate(9, (index) {
                                return Container(
                                  width: 320,
                                  child: _buildLatestPostCard(isGridView,
                                      postId: 'post-$index'),
                                );
                              }),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 9,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 24),
                              itemBuilder: (context, index) {
                                return _buildLatestPostCard(isGridView,
                                    postId: 'post-$index');
                              },
                            ),

                          SizedBox(height: 40),

                          // Popular Collections Section
                          Text(
                            'Popular Collections',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 24),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  _getCollectionGridColumns(screenWidth),
                              crossAxisSpacing: itemSpacing,
                              mainAxisSpacing: itemSpacing,
                              childAspectRatio: screenWidth > 800 ? 1.5 : 1.3,
                            ),
                            itemCount: collections.length,
                            itemBuilder: (context, index) {
                              final collection = collections[index];
                              return _buildCollectionCard(
                                collectionId: 'collection-$index',
                                title: collection['title'] as String,
                                description:
                                    collection['description'] as String,
                                images: (collection['images'] as List<String>),
                              );
                            },
                          ),

                          SizedBox(height: 40),

                          // Community Highlights Section
                          Text(
                            'Community Highlights',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 24),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: gridColumns,
                              crossAxisSpacing: itemSpacing,
                              mainAxisSpacing: itemSpacing,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              final highlights = [
                                {
                                  'title': 'Photography Tips',
                                  'likes': '1.2K',
                                  'icon': Icons.thumb_up,
                                  'color': Colors.blue
                                },
                                {
                                  'title': 'Best Travel Stories',
                                  'likes': '2.5K',
                                  'icon': Icons.trending_up,
                                  'color': Colors.orange
                                },
                                {
                                  'title': 'Tech Reviews',
                                  'likes': '1.8K',
                                  'icon': Icons.star,
                                  'color': Colors.purple
                                },
                                {
                                  'title': 'Cooking Guides',
                                  'likes': '3.1K',
                                  'icon': Icons.favorite,
                                  'color': Colors.red
                                },
                                {
                                  'title': 'Fitness Journey',
                                  'likes': '1.5K',
                                  'icon': Icons.directions_run,
                                  'color': Colors.green
                                },
                                {
                                  'title': 'Art Tutorials',
                                  'likes': '2.2K',
                                  'icon': Icons.palette,
                                  'color': Colors.pink
                                },
                                {
                                  'title': 'Book Reviews',
                                  'likes': '1.9K',
                                  'icon': Icons.menu_book,
                                  'color': Colors.teal
                                },
                                {
                                  'title': 'DIY Projects',
                                  'likes': '2.7K',
                                  'icon': Icons.build,
                                  'color': Colors.amber
                                },
                              ];
                              final highlight = highlights[index];
                              return _buildHighlightCard(
                                highlightId: 'highlight-$index',
                                title: highlight['title'] as String,
                                likes: highlight['likes'] as String,
                                icon: highlight['icon'] as IconData,
                                color: highlight['color'] as Color,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTopic(
      String title, IconData icon, String count, Color color) {
    return Consumer(
      builder: (context, ref, child) {
        final isHovered = ref.watch(hoveredTrendingTopicProvider) == title;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 200),
            tween: Tween<double>(begin: 1, end: isHovered ? 1.02 : 1),
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Transform.translate(
                  offset: Offset(0, isHovered ? -2 : 0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: color.withOpacity(0.2),
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: Offset(0, -2),
                              )
                            ]
                          : [],
                    ),
                    child: child,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    count,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onEnter: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = title,
          onExit: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = null,
        );
      },
    );
  }

  Widget _buildPopularAuthor(String name, String followers, String imageUrl) {
    return Consumer(
      builder: (context, ref, child) {
        final isHovered = ref.watch(hoveredAuthorProvider) == name;
        final isButtonHovered = ref.watch(hoveredAuthorButtonProvider) == name;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 200),
            tween: Tween<double>(begin: 1, end: isHovered ? 1.02 : 1),
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Transform.translate(
                  offset: Offset(0, isHovered ? -2 : 0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.1),
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: Offset(0, -2),
                              )
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                followers,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MouseRegion(
                          onEnter: (_) => ref
                              .read(hoveredAuthorButtonProvider.notifier)
                              .state = name,
                          onExit: (_) => ref
                              .read(hoveredAuthorButtonProvider.notifier)
                              .state = null,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text('Follow'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: BorderSide(color: Colors.blue),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              minimumSize: Size(0, 30),
                              elevation: isButtonHovered ? 4 : 0,
                              backgroundColor: isButtonHovered
                                  ? Colors.blue.withOpacity(0.05)
                                  : Colors.transparent,
                              shadowColor: isButtonHovered
                                  ? Colors.blue.withOpacity(0.3)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          onEnter: (_) => ref.read(hoveredAuthorProvider.notifier).state = name,
          onExit: (_) => ref.read(hoveredAuthorProvider.notifier).state = null,
        );
      },
    );
  }

  Widget _buildFeaturedPostCard(
      String title, String description, String imageUrl, String author) {
    return Consumer(
      builder: (context, ref, child) {
        final isHovered = ref.watch(hoveredFeaturedPostProvider) == title;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isHovered
                          ? AppTheme.primaryColor.withOpacity(0.4)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      spreadRadius: isHovered ? 2 : 0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTheme.headingSmall,
                          ),
                          SizedBox(height: 12),
                          Text(
                            description,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.secondaryTextColor,
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage('https://i.pravatar.cc/150'),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    author,
                                    style: AppTheme.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '5 min read',
                                    style: AppTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Spacer(),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: isHovered ? 1.0 : 0.0,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.primaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: AppTheme.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isHovered)
                Positioned.fill(
                  child: NeonBorderEffect(
                    borderRadius: 16,
                    margin: EdgeInsets.zero,
                  ),
                ),
            ],
          ),
          onEnter: (_) =>
              ref.read(hoveredFeaturedPostProvider.notifier).state = title,
          onExit: (_) =>
              ref.read(hoveredFeaturedPostProvider.notifier).state = null,
        );
      },
    );
  }

  Widget _buildLatestPostCard(bool isGrid, {required String postId}) {
    final String title = 'The Future of AI in Healthcare';
    final String content =
        'Artificial Intelligence is revolutionizing healthcare with innovative solutions for diagnosis, treatment planning, and patient care. From machine learning algorithms analyzing medical images to AI-powered robotic surgery assistants, the possibilities are endless...';
    final String author = 'Dr. Sarah Johnson';
    final String date = '2 hours ago';
    final String imageUrl =
        'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d';
    final String category = 'Technology';

    if (isGrid) {
      return Consumer(
        builder: (context, ref, child) {
          final isHovered = ref.watch(hoveredLatestPostProvider) == postId;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: isHovered
                        ? AppTheme.primaryColor.withOpacity(0.4)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image with category and date overlay
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          imageUrl,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            date,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        // Content
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16),
                        // Author info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    author,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xFF1F2937),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Author',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isHovered)
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onEnter: (_) =>
                ref.read(hoveredLatestPostProvider.notifier).state = postId,
            onExit: (_) =>
                ref.read(hoveredLatestPostProvider.notifier).state = null,
          );
        },
      );
    } else {
      return Consumer(
        builder: (context, ref, child) {
          final isHovered = ref.watch(hoveredLatestPostProvider) == postId;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: isHovered
                        ? AppTheme.primaryColor.withOpacity(0.4)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category and Date
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                date,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Title
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Blog Content
                          Text(
                            content,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              height: 1.6,
                              letterSpacing: 0.15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                          // Author
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                author,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              const Spacer(),
                              // Read More
                              if (isHovered)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Read More',
                                        style: TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 16,
                                        color: AppTheme.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onEnter: (_) =>
                ref.read(hoveredLatestPostProvider.notifier).state = postId,
            onExit: (_) =>
                ref.read(hoveredLatestPostProvider.notifier).state = null,
          );
        },
      );
    }
  }

  Widget _buildCollectionCard({
    required String collectionId,
    required String title,
    required String description,
    required List<String> images,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isHovered = ref.watch(hoveredCollectionProvider) == collectionId;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Stack(
            children: [
              Container(
                height: 280, // Fixed total height
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: isHovered
                          ? AppTheme.primaryColor.withOpacity(0.4)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      spreadRadius: isHovered ? 2 : 0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),

                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),

                    // Images
                    Expanded(
                      child: Row(
                        children: images.take(3).map((url) {
                          final isLast = url == images.last || url == images[2];
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: isLast ? 0 : 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey.shade100,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade100,
                                      child: Icon(Icons.error_outline,
                                          color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${images.length} items',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            'View →',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isHovered)
                Positioned.fill(
                  child: NeonBorderEffect(
                    borderRadius: 12,
                    margin: EdgeInsets.zero,
                  ),
                ),
            ],
          ),
          onEnter: (_) =>
              ref.read(hoveredCollectionProvider.notifier).state = collectionId,
          onExit: (_) =>
              ref.read(hoveredCollectionProvider.notifier).state = null,
        );
      },
    );
  }

  Widget _buildHighlightCard({
    required String highlightId,
    required String title,
    required String likes,
    required IconData icon,
    required Color color,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isHovered = ref.watch(hoveredHighlightProvider) == highlightId;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: isHovered
                          ? color.withOpacity(0.4)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      spreadRadius: isHovered ? 2 : 0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            icon,
                            color: color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$likes likes',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('View →'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isHovered)
                Positioned.fill(
                  child: NeonBorderEffect(
                    borderRadius: 12,
                    margin: EdgeInsets.zero,
                  ),
                ),
            ],
          ),
          onEnter: (_) =>
              ref.read(hoveredHighlightProvider.notifier).state = highlightId,
          onExit: (_) =>
              ref.read(hoveredHighlightProvider.notifier).state = null,
        );
      },
    );
  }

  Widget _buildFilterChip(String category, bool isSelected) {
    return Consumer(
      builder: (context, ref, child) {
        final isHovered =
            ref.watch(hoveredTrendingTopicProvider) == 'filter-$category';
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 200),
            tween: Tween<double>(begin: 1, end: isHovered ? 1.02 : 1),
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Transform.translate(
                  offset: Offset(0, isHovered ? -2 : 0),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      final categories = List<String>.from(
                          ref.read(selectedCategoriesProvider));
                      if (selected) {
                        categories.add(category);
                      } else {
                        categories.remove(category);
                      }
                      ref.read(selectedCategoriesProvider.notifier).state =
                          categories;
                    },
                    backgroundColor: Colors.grey.shade50,
                    selectedColor: Colors.blue.shade100,
                    checkmarkColor: Colors.blue,
                    elevation: isHovered ? 4 : 0,
                    shadowColor: isHovered
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.transparent,
                  ),
                ),
              );
            },
          ),
          onEnter: (_) => ref
              .read(hoveredTrendingTopicProvider.notifier)
              .state = 'filter-$category',
          onExit: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = null,
        );
      },
    );
  }

  Widget _buildSortByDropdown() {
    return Consumer(
      builder: (context, ref, child) {
        final isHovered = ref.watch(hoveredTrendingTopicProvider) == 'sort-by';
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 200),
            tween: Tween<double>(begin: 1, end: isHovered ? 1.02 : 1),
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Transform.translate(
                  offset: Offset(0, isHovered ? -2 : 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(0, -2),
                              ),
                            ]
                          : [],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        items: ['Most Popular', 'Most Recent', 'Highest Rated']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          onEnter: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = 'sort-by',
          onExit: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = null,
        );
      },
    );
  }
}
