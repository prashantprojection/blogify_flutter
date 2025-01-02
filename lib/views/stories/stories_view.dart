/// A comprehensive web stories view that showcases interactive story cards with animations.
///
/// This file contains the following main components:
///
/// 1. [StoriesView] - The main view that displays all story-related content:
///   - Hero section with title and description
///   - Interactive story carousel with hover effects
///   - Category selection with horizontal scrolling
///   - Responsive grid of web stories
///   - CTA section
///   - Footer
///
/// 2. [StoryPlayer] - A widget for displaying individual story cards in the carousel:
///   - Handles image loading and error states
///   - Displays category badges
///   - Implements hover effects with neon glow
///   - Shows story metadata (title, author)
///
/// 3. [CategoryCard] - Interactive category selection cards:
///   - Displays category icon and title
///   - Implements hover and selection states
///   - Handles category filtering
///
/// 4. [WebStoryCard] - Grid item for displaying stories:
///   - Shows story preview with image
///   - Displays category, title, and author
///   - Implements hover effects with neon glow
///
/// Key Features:
/// - Responsive design that adapts to different screen sizes
/// - Smooth animations and transitions
/// - Interactive hover effects
/// - Category-based filtering
/// - Infinite carousel scrolling
/// - Error handling for image loading
///
/// Usage:
/// ```dart
/// StoriesView(
///   key: Key('stories_view'),
/// )
/// ```
///
/// The view uses several providers for state management:
/// - selectedCategoryProvider: Manages the currently selected category
/// - hoveredStoryProvider: Tracks which story is being hovered
/// - hoveredArrowProvider: Manages navigation arrow hover states
/// - currentIndexProvider: Tracks the current carousel index

import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

/// Provider that manages the currently selected category.
/// Defaults to 'All' category.
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

/// Provider that tracks which story is currently being hovered.
/// Returns null when no story is hovered.
final hoveredStoryProvider = StateProvider<String?>((ref) => null);

/// Provider that manages the hover state of carousel navigation arrows.
/// Returns 'left', 'right', or null.
final hoveredArrowProvider = StateProvider<String?>((ref) => null);

/// Provider that tracks the current index of the story carousel.
/// Used for carousel navigation and state management.
final currentIndexProvider = StateProvider<int>((ref) => 1);

/// A widget that displays an individual story in the carousel.
///
/// Features:
/// - Displays story image with gradient overlay
/// - Shows category badge
/// - Implements hover effects with neon glow
/// - Handles error states for image loading
class StoryPlayer extends ConsumerWidget {
  final String title;
  final String image;
  final String author;
  final String authorImage;
  final String category;
  final Color badgeColor;
  final bool isHovered;
  final String badgeName;

  const StoryPlayer({
    Key? key,
    required this.title,
    required this.image,
    required this.author,
    required this.authorImage,
    required this.category,
    required this.badgeColor,
    required this.badgeName,
    this.isHovered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 270,
      height: 479,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (isHovered)
            BoxShadow(
              color: badgeColor.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Story Image
            Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.error_outline, color: Colors.grey),
                );
              },
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            // Badge Name
            Positioned(
              left: 16,
              top: 16,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  category,
                  style: AppTheme.bodySmall.copyWith(
                    color: badgeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The main view widget that displays the stories interface.
///
/// Features:
/// - Responsive layout that adapts to screen size
/// - Interactive story carousel
/// - Category filtering system
/// - Grid view of web stories
/// - CTA section and footer
class StoriesView extends ConsumerStatefulWidget {
  const StoriesView({Key? key}) : super(key: key);

  @override
  _StoriesViewState createState() => _StoriesViewState();
}

class _StoriesViewState extends ConsumerState<StoriesView> {
  final _scrollController = ScrollController();
  late final CarouselController _carouselController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> stories = [
    {
      'title': 'The Future of AI in 2024',
      'image': 'https://images.unsplash.com/photo-1677442136019-21780ecad995',
      'author': 'John Smith',
      'authorImage': 'https://randomuser.me/api/portraits/men/1.jpg',
      'category': 'Technology',
      'badgeName': 'New',
      'badgeColor': Color(0xFF6366F1),
    },
    {
      'title': 'Healthy Living: Morning Routines',
      'image': 'https://images.unsplash.com/photo-1545205597-3d9d02c29597',
      'author': 'Sarah Johnson',
      'authorImage': 'https://randomuser.me/api/portraits/women/2.jpg',
      'category': 'Health',
      'badgeName': 'Featured',
      'badgeColor': Color(0xFF7C3AED),
    },
    {
      'title': 'Exploring Hidden Beaches in Bali',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800',
      'author': 'Mike Wilson',
      'authorImage': 'https://randomuser.me/api/portraits/men/3.jpg',
      'category': 'Travel',
      'badgeName': 'Trending',
      'badgeColor': Color(0xFFD97706),
    },
    {
      'title': 'Modern Work-Life Balance Tips',
      'image': 'https://images.unsplash.com/photo-1497215728101-856f4ea42174',
      'author': 'Emma Davis',
      'authorImage': 'https://randomuser.me/api/portraits/women/4.jpg',
      'category': 'Lifestyle',
      'badgeName': 'Popular',
      'badgeColor': Color(0xFF059669),
    },
    {
      'title': 'Gourmet Cooking at Home',
      'image': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d',
      'author': 'Chef Alex',
      'authorImage': 'https://randomuser.me/api/portraits/men/5.jpg',
      'category': 'Food',
      'badgeName': 'Must Read',
      'badgeColor': Color(0xFFDC2626),
    },
    {
      'title': 'Web3 and Future of Internet',
      'image': 'https://images.unsplash.com/photo-1639762681485-074b7f938ba0',
      'author': 'Tech Insider',
      'authorImage': 'https://randomuser.me/api/portraits/men/6.jpg',
      'category': 'Technology',
      'badgeName': 'Hot',
      'badgeColor': Color(0xFF6366F1),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth =
        screenWidth > 1200 ? screenWidth * 0.85 : screenWidth * 0.95;
    final isDesktop = screenWidth > 1100;
    final storyHeight = 479.0;
    final storyWidth = 270.0;
    final hoveredStory = ref.watch(hoveredStoryProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(),
            // Hero Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEFF2FC),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 54),
              child: Column(
                children: [
                  Text(
                    'Dive into Stories That Come Alive!',
                    style: AppTheme.headingLarge.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Swipe through engaging web stories, one frame at a time.',
                    style: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.subtitleColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Container(
                width: contentWidth,
                child: Column(
                  children: [
                    Container(
                      height: 630,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Center(
                                  child: FlutterCarousel(
                                    items: stories.map((story) {
                                      final isHovered =
                                          hoveredStory == story['title'];
                                      return MouseRegion(
                                        onEnter: (_) => ref
                                            .read(hoveredStoryProvider.notifier)
                                            .state = story['title'],
                                        onExit: (_) => ref
                                            .read(hoveredStoryProvider.notifier)
                                            .state = null,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          height: isDesktop ? 650 : 600,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                height: 479,
                                                child: StoryPlayer(
                                                  title: story['title'],
                                                  image: story['image'],
                                                  author: story['author'],
                                                  authorImage:
                                                      story['authorImage'],
                                                  category: story['category'],
                                                  badgeColor:
                                                      story['badgeColor'],
                                                  badgeName: story['badgeName'],
                                                  isHovered: isHovered,
                                                ),
                                              ),
                                              AnimatedPositioned(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                                left: 12,
                                                right: 0,
                                                bottom: 8,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // Category Badge
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            story['badgeColor']
                                                                .withOpacity(
                                                                    0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: Text(
                                                        story['badgeName'],
                                                        style: AppTheme
                                                            .bodySmall
                                                            .copyWith(
                                                          color: story[
                                                              'badgeColor'],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 12),
                                                    // Title
                                                    Text(
                                                      story['title'],
                                                      style: AppTheme
                                                          .headingSmall
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 8),
                                                    // Author
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 12,
                                                          backgroundImage:
                                                              NetworkImage(story[
                                                                  'authorImage']),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          story['author'],
                                                          style: AppTheme
                                                              .bodyMedium
                                                              .copyWith(
                                                            color: AppTheme
                                                                .subtitleColor,
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
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      height: isDesktop ? 700 : 650,
                                      viewportFraction: isDesktop ? 0.25 : 0.65,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: true,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 5),
                                      showIndicator: false,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.scale,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentPage = index;
                                        });
                                      },
                                      controller: _carouselController,
                                    ),
                                  ),
                                ),
                                // if (isDesktop)
                                Positioned.fill(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildNavigationArrow(true),
                                      _buildNavigationArrow(false),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 64),

                    // Explore Categories Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Explore Categories',
                              style: AppTheme.headingMedium,
                            ),
                            SizedBox(width: 16),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  _scrollController.animateTo(
                                    _scrollController.offset - 300,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: Icon(Icons.arrow_back,
                                    size: 20, color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  _scrollController.animateTo(
                                    _scrollController.offset + 300,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: Icon(Icons.arrow_forward,
                                    size: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        Container(
                          height: 180,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildCategoryCard(
                                  'All',
                                  IconsaxPlusLinear.category,
                                  AppTheme.primaryColor,
                                ),
                                SizedBox(width: 24),
                                _buildCategoryCard(
                                  'Technology',
                                  IconsaxPlusLinear.monitor,
                                  Color(0xFF6366F1),
                                ),
                                SizedBox(width: 24),
                                _buildCategoryCard(
                                  'Lifestyle',
                                  IconsaxPlusLinear.heart,
                                  Color(0xFF059669),
                                ),
                                SizedBox(width: 24),
                                _buildCategoryCard(
                                  'Travel',
                                  IconsaxPlusLinear.airplane,
                                  Color(0xFFD97706),
                                ),
                                SizedBox(width: 24),
                                _buildCategoryCard(
                                  'Food',
                                  IconsaxPlusLinear.cake,
                                  Color(0xFFDC2626),
                                ),
                                SizedBox(width: 24),
                                _buildCategoryCard(
                                  'Health',
                                  IconsaxPlusLinear.health,
                                  Color(0xFF7C3AED),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 64),

                    // Web Stories Grid
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Latest Web Stories',
                          style: AppTheme.headingMedium,
                        ),
                        SizedBox(height: 32),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount;
                            if (constraints.maxWidth > 1200) {
                              crossAxisCount = 5;
                            } else if (constraints.maxWidth > 900) {
                              crossAxisCount = 4;
                            } else if (constraints.maxWidth > 600) {
                              crossAxisCount = 3;
                            } else {
                              crossAxisCount = 1;
                            }
                            final selectedCategory =
                                ref.watch(selectedCategoryProvider);
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: 9 / 16,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                              ),
                              itemCount: selectedCategory == 'All'
                                  ? stories.length * 3
                                  : stories
                                      .where((s) =>
                                          s['category'] == selectedCategory)
                                      .length,
                              itemBuilder: (context, index) {
                                final filteredStories = selectedCategory ==
                                        'All'
                                    ? stories
                                    : stories
                                        .where((s) =>
                                            s['category'] == selectedCategory)
                                        .toList();

                                final story = selectedCategory == 'All'
                                    ? stories[index % stories.length]
                                    : filteredStories[index];

                                return WebStoryCard(
                                  title: story['title'],
                                  image: story['image'],
                                  author: story['author'],
                                  authorImage: story['authorImage'],
                                  category: story['category'],
                                  badgeColor: story['badgeColor'],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // CTA Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 64),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Story Deserves to Be Told',
                    style: AppTheme.headingLarge.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Start Creating',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white, width: 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Footer Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 48),
              decoration: BoxDecoration(
                color: Color(0xFF0F172A),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo and Copyright
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.menu_book_outlined,
                              color: Colors.white, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Blogify',
                            style: AppTheme.headingMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 32),
                      Text(
                        '© 2025 All rights reserved',
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  // Social Links
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(IconsaxPlusLinear.message,
                            color: Colors.white),
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(IconsaxPlusLinear.gallery,
                            color: Colors.white),
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(IconsaxPlusLinear.link, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationArrow(bool isLeft) {
    return MouseRegion(
      onEnter: (_) => ref.read(hoveredArrowProvider.notifier).state =
          isLeft ? 'left' : 'right',
      onExit: (_) => ref.read(hoveredArrowProvider.notifier).state = null,
      child: GestureDetector(
        onTap: () {
          if (isLeft) {
            int newPage = _currentPage - 1;
            if (newPage < 0) newPage = stories.length - 1;
            setState(() {
              _currentPage = newPage;
            });
            _carouselController.previousPage(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          } else {
            int newPage = _currentPage + 1;
            if (newPage >= stories.length) newPage = 0;
            setState(() {
              _currentPage = newPage;
            });
            _carouselController.nextPage(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            isLeft ? Icons.arrow_back : Icons.arrow_forward,
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return CategoryCard(
      title: title,
      icon: icon,
      color: color,
    );
  }
}

/// A widget that displays a category selection card.
///
/// Features:
/// - Interactive hover and selection states
/// - Category icon and title display
/// - Click handling for category selection
/// - Smooth animations for state changes
class CategoryCard extends ConsumerStatefulWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  ConsumerState<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends ConsumerState<CategoryCard> {
  bool isHovered = false;

  void _handleCategorySelect() {
    ref.read(selectedCategoryProvider.notifier).state = widget.title;
    // Scroll to the grid section
    Scrollable.ensureVisible(
      context,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final isSelected = selectedCategory == widget.title;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: _handleCategorySelect,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.identity()..translate(0, isHovered ? -4 : 0),
          width: 220,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? widget.color.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? widget.color : Colors.grey.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              if (isHovered || isSelected)
                BoxShadow(
                  color: widget.color.withOpacity(0.2),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                widget.icon,
                size: 28,
                color: widget.color,
              ),
              SizedBox(height: 12),
              Text(
                widget.title,
                style: AppTheme.headingSmall.copyWith(
                  color: isSelected ? widget.color : null,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 36,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      isSelected ? widget.color : widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Explore Category',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : widget.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget that displays a story card in the grid view.
///
/// Features:
/// - Story preview with image
/// - Category badge display
/// - Title and author information
/// - Hover effects with neon glow
/// - Interactive selection state
class WebStoryCard extends ConsumerStatefulWidget {
  final String title;
  final String image;
  final String author;
  final String authorImage;
  final String category;
  final Color badgeColor;

  const WebStoryCard({
    Key? key,
    required this.title,
    required this.image,
    required this.author,
    required this.authorImage,
    required this.category,
    required this.badgeColor,
  }) : super(key: key);

  @override
  ConsumerState<WebStoryCard> createState() => _WebStoryCardState();
}

class _WebStoryCardState extends ConsumerState<WebStoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final selectedStory = ref.watch(hoveredStoryProvider);
    final isSelected = selectedStory == widget.title;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          ref.read(hoveredStoryProvider.notifier).state =
              isSelected ? null : widget.title;
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..translate(0, (isHovered || isSelected) ? -4 : 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (isHovered || isSelected)
                BoxShadow(
                  color: widget.badgeColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Story Image
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.error_outline, color: Colors.grey),
                      );
                    },
                  ),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Category Text
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.category,
                      style: AppTheme.bodySmall.copyWith(
                        color: widget.badgeColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // Title and Author
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTheme.headingSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(widget.authorImage),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.author,
                              style: AppTheme.bodyMedium.copyWith(
                                color: Colors.white.withOpacity(0.8),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
