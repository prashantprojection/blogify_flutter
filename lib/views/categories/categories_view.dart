import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';

final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final hoveredCategoryProvider = StateProvider<String?>((ref) => null);

final List<Map<String, dynamic>> featuredCategories = [
  {
    'title': 'Programming',
    'icon': Icons.code,
    'color': Colors.blue,
    'blogs': '2.5k blogs',
    'description': 'Explore coding tutorials and tech insights',
  },
  {
    'title': 'Design',
    'icon': Icons.palette,
    'color': Colors.purple,
    'blogs': '1.8k blogs',
    'description': 'Creative insights and design resources',
  },
  {
    'title': 'Business',
    'icon': Icons.trending_up,
    'color': Colors.green,
    'blogs': '3.2k blogs',
    'description': 'Business strategies and success stories',
  },
];

final List<Map<String, dynamic>> allCategories = [
  {
    'title': 'Photography',
    'icon': Icons.camera_alt,
    'color': Colors.orange,
    'blogs': '1.2k blogs',
    'description': 'Tips and techniques for photographers',
  },
  {
    'title': 'Web Development',
    'icon': Icons.web,
    'color': Colors.indigo,
    'blogs': '2.1k blogs',
    'description': 'Web development tutorials and insights',
  },
  {
    'title': 'Mobile Apps',
    'icon': Icons.phone_android,
    'color': Colors.pink,
    'blogs': '1.5k blogs',
    'description': 'Mobile app development and design',
  },
  {
    'title': 'Artificial Intelligence',
    'icon': Icons.psychology,
    'color': Colors.teal,
    'blogs': '900 blogs',
    'description': 'AI and machine learning insights',
  },
  {
    'title': 'Technology',
    'icon': Icons.computer,
    'blogs': '4.2k blogs',
    'color': Colors.red,
    'description': 'Latest technology trends and news with latest tech news',
  },
  {
    'title': 'Writing',
    'icon': Icons.edit,
    'blogs': '1.6k blogs',
    'color': Colors.brown,
    'description': 'Writing tips and storytelling techniques',
  },
  {
    'title': 'Marketing',
    'icon': Icons.trending_up,
    'blogs': '2.8k blogs',
    'color': Colors.deepPurple,
    'description': 'Digital marketing strategies and tips',
  },
  {
    'title': 'Health & Fitness',
    'icon': Icons.fitness_center,
    'blogs': '2.3k blogs',
    'color': Colors.green,
    'description': 'Health tips and fitness guides',
  },
];

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  final searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth > 600 ? screenWidth * 0.85 : screenWidth;
    final cardWidth = (contentWidth - 128) / 4;
    // Subtracting total horizontal padding and spacing

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with white background
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Container(
                  width: contentWidth,
                  padding: EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore Categories',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Discover topics that inspire you to share and learn',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Search and Filter Section with white background
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Container(
                  width: contentWidth,
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.shade100, width: 0.3),
                          ),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search for categories...',
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              filled: true,
                              hoverColor: Colors.white,
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      _buildFilterChip('🔥 Trending', Colors.blue.shade50),
                      SizedBox(width: 8),
                      _buildFilterChip('🆕 New', Colors.green.shade50),
                      SizedBox(width: 8),
                      _buildFilterChip(
                          '⭐ Editor\'s Choice', Colors.purple.shade50),
                    ],
                  ),
                ),
              ),
            ),
            // Main Content
            Center(
              child: Container(
                width: contentWidth,
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Categories Section
                    Text(
                      'Featured Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: featuredCategories.map((category) {
                        return SizedBox(
                          width: cardWidth,
                          child: _buildCategoryCard(
                            title: category['title'] as String,
                            icon: category['icon'] as IconData,
                            color: category['color'] as Color,
                            blogs: category['blogs'] as String,
                            description: category['description'] as String,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 48),

                    // All Categories Section
                    Text(
                      'All Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: allCategories.map((category) {
                        if (searchQuery.isNotEmpty &&
                            !category['title']
                                .toString()
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase())) {
                          return SizedBox.shrink();
                        }
                        return SizedBox(
                          width: cardWidth,
                          child: _buildCategoryCard(
                            title: category['title'] as String,
                            icon: category['icon'] as IconData,
                            color: category['color'] as Color,
                            blogs: category['blogs'] as String,
                            description: category['description'] as String,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 48),

                    // CTA Section
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF4B6BFB),
                            Color(0xFF9C3FE4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t see your favorite topic?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Create a new category!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 24),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.add, color: Color(0xFF4B6BFB)),
                                label: Text(
                                  'Suggest a Category',
                                  style: TextStyle(
                                    color: Color(0xFF4B6BFB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Find Your Passion with Blogify',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        'Technology',
                        'Design',
                        'Business',
                        'Lifestyle',
                        'Health',
                      ]
                          .map((category) => TextButton(
                                onPressed: () {},
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: backgroundColor == Colors.blue.shade50
              ? Colors.blue.shade700
              : backgroundColor == Colors.green.shade50
                  ? Colors.green.shade700
                  : Colors.purple.shade700,
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required IconData icon,
    required Color color,
    required String blogs,
    required String description,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isHovered = ref.watch(hoveredCategoryProvider) == title;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 200),
            tween: Tween<double>(begin: 1, end: isHovered ? 1.02 : 1),
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: Transform.translate(
                  offset: Offset(0, isHovered ? -4 : 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: Offset(0, 2),
                        ),
                        if (isHovered)
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 2,
                            offset: Offset(0, -4),
                          ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            boxShadow: isHovered
                                ? [
                                    BoxShadow(
                                      color: color.withOpacity(0.3),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(icon, color: color, size: 42),
                        ),
                        SizedBox(height: 12),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isHovered ? color : Colors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: isHovered
                                    ? [
                                        BoxShadow(
                                          color: color.withOpacity(0.2),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Text(
                                blogs,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Explore →',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                ),
              );
            },
          ),
          onEnter: (_) =>
              ref.read(hoveredCategoryProvider.notifier).state = title,
          onExit: (_) =>
              ref.read(hoveredCategoryProvider.notifier).state = null,
        );
      },
    );
  }
}
