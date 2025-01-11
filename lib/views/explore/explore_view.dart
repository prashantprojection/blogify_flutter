import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/app_footer.dart';
import 'package:blogify_flutter/widgets/common/hoverable_cards.dart';
import 'package:blogify_flutter/widgets/common/neon_border_effect.dart';
import 'package:blogify_flutter/views/article/article_view.dart';
import 'package:blogify_flutter/controllers/article_controller.dart';
import 'package:blogify_flutter/models/article.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/utils/navigation_helper.dart';
import 'package:blogify_flutter/constants/ui_constants.dart';
import 'package:blogify_flutter/constants/app_strings.dart';
import 'package:blogify_flutter/widgets/common/error_widgets.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Add a method to check if the screen is mobile
  bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < UIConstants.tabletBreakpoint;
  }

  // Add a method to check if the screen is tablet
  bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= UIConstants.tabletBreakpoint &&
        MediaQuery.of(context).size.width < UIConstants.desktopBreakpoint;
  }

  // Update the grid columns calculation
  int _getGridColumns(double width) {
    if (width < 768) return 1;
    if (width < 1024) return 2;
    if (width < 1440) return 3;
    return 4;
  }

  // Update collection grid columns
  int _getCollectionGridColumns(double width) {
    if (width >= 1800) return 4;
    if (width >= 1400) return 3;
    if (width >= 768) return 2;
    return 1;
  }

  // Add a method to build the sidebar content
  Widget _buildSidebarContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
          // Search Box
          _buildSearchBar(),
          SizedBox(height: 48),
          // Trending Topics
          _buildTrendingTopicsSection(),
          SizedBox(height: 48),
          // Sort By Section
          _buildSortBySection(),
          SizedBox(height: 48),
          // Popular Authors Section
          _buildPopularAuthorsSection(),
          SizedBox(height: 48),
          // Stay Updated Section
          _buildStayUpdatedSection(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: UIConstants.inputHeight,
      padding: EdgeInsets.symmetric(horizontal: UIConstants.spacingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(UIConstants.radiusM),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade400),
          SizedBox(width: UIConstants.spacingS),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search articles...',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: UIConstants.spacingM),
              ),
            ),
          ),
          Container(
            height: UIConstants.iconSize + 4,
            width: 1,
            color: Colors.grey.shade200,
            margin: EdgeInsets.symmetric(horizontal: UIConstants.spacingS),
          ),
          Tooltip(
            message: 'Advanced filters',
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(UIConstants.radiusXL),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(UIConstants.spacingS),
                  child: Icon(
                    Icons.tune_rounded,
                    color: AppTheme.primaryColor,
                    size: UIConstants.iconSize - 4,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: UIConstants.spacingS),
        ],
      ),
    );
  }

  Widget _buildTrendingTopicsSection() {
    return Column(
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
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Widget _buildSortBySection() {
    return Column(
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
    );
  }

  Widget _buildPopularAuthorsSection() {
    return Column(
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
      ],
    );
  }

  Widget _buildStayUpdatedSection() {
    return Container(
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
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Subscribe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade700,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  elevation: isHovered ? 8 : 0,
                  shadowColor: isHovered
                      ? Colors.white.withOpacity(0.3)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToArticle(BuildContext context, String postId) {
    final articles = ref.read(sampleArticlesProvider);
    final article = articles.firstWhere(
      (article) => article.id == postId,
      orElse: () => articles.first,
    );
    NavigationHelper.navigateToArticle(context, article);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = isMobileScreen(context);
    final isTablet = isTabletScreen(context);
    final contentPadding = isMobile ? 16.0 : 32.0;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppHeader(
        isLarge: false,
        leading: isMobile
            ? IconButton(
                icon: Icon(Icons.menu, color: Colors.grey.shade800),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              )
            : null,
        elevation: 1,
        mobileActions: [
          IconButton(
            icon:
                Icon(Icons.notifications_outlined, color: Colors.grey.shade800),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.grey.shade800),
            onPressed: () {},
          ),
        ],
      ),
      drawer: isMobile
          ? Drawer(
              child: SafeArea(
                child: _buildSidebarContent(),
              ),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar for tablet and desktop
          if (!isMobile)
            Container(
              width: isTablet ? screenWidth * 0.3 : screenWidth * 0.23,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border(
                  right: BorderSide(color: Colors.grey.shade200),
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
                  child: _buildSidebarContent(),
                ),
              ),
            ),

          // Main content
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade50,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(contentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Latest Posts Section
                    _buildLatestPostsSection(isMobile),

                    SizedBox(height: 40),

                    // Popular Collections Section
                    Text(
                      'Popular Collections',
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildCollectionsGrid(screenWidth, contentPadding),

                    SizedBox(height: 40),

                    // Community Highlights Section
                    Text(
                      'Community Highlights',
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildHighlightsGrid(screenWidth, contentPadding),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestPostsSection(bool isMobile) {
    final articles = ref.watch(sampleArticlesProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final contentPadding =
        isMobile ? UIConstants.spacingM : UIConstants.spacingL;
    final isGridView = ref.watch(viewTypeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Posts',
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.grid_view_rounded,
                    color: isGridView ? AppTheme.primaryColor : Colors.grey,
                  ),
                  onPressed: () =>
                      ref.read(viewTypeProvider.notifier).state = true,
                ),
                IconButton(
                  icon: Icon(
                    Icons.view_agenda_rounded,
                    color: !isGridView ? AppTheme.primaryColor : Colors.grey,
                  ),
                  onPressed: () =>
                      ref.read(viewTypeProvider.notifier).state = false,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: UIConstants.spacingL),
        AsyncValueWidget<List<Article>>(
          value: AsyncValue.data(articles),
          data: (articles) {
            if (articles.isEmpty) {
              return EmptyStateView(
                message: AppStrings.noContent,
                icon: Icons.article_outlined,
                actionLabel: 'Create Article',
                onAction: () {
                  // Handle create article action
                },
              );
            }

            if (isGridView) {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getGridColumns(screenWidth),
                  crossAxisSpacing:
                      isMobile ? UIConstants.spacingM : UIConstants.spacingL,
                  mainAxisSpacing:
                      isMobile ? UIConstants.spacingM : UIConstants.spacingL,
                  mainAxisExtent: 400,
                ),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return _buildLatestPostCard(true, postId: 'post-$index');
                },
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: articles.length,
              separatorBuilder: (context, index) => SizedBox(
                height: isMobile ? UIConstants.spacingM : UIConstants.spacingL,
              ),
              itemBuilder: (context, index) {
                return _buildLatestPostCard(false, postId: 'post-$index');
              },
            );
          },
          loading: () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: UIConstants.spacingM),
                Text(AppStrings.loading),
              ],
            ),
          ),
          error: (error, stackTrace) => ErrorView(
            message: error.toString(),
            onRetry: () {
              // Handle retry logic
            },
          ),
        ),
      ],
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    if (isGrid) {
      return Consumer(
        builder: (context, ref, child) {
          final isHovered = ref.watch(hoveredLatestPostProvider) == postId;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _navigateToArticle(context, postId),
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
                  children: [
                    // Image Section with Fixed Height
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Content Section
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category Tag
                            Container(
                              padding: EdgeInsets.symmetric(
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
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
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
                            Expanded(
                              child: Text(
                                content,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  height: 1.5,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Author Section
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        date,
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
                                      color: AppTheme.primaryColor
                                          .withOpacity(0.1),
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

    // List view card layout
    return Consumer(
      builder: (context, ref, child) {
        final isHovered = ref.watch(hoveredLatestPostProvider) == postId;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _navigateToArticle(context, postId),
            child: Container(
              height: isMobile ? 140 : null,
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image on the left
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      imageUrl,
                      width: isMobile ? 140 : 200,
                      height: isMobile ? 140 : 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Category and Date
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                date,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Title
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),

                          // Content
                          if (!isMobile) ...[
                            Text(
                              content,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 12),
                          ],

                          // Author info
                          if (!isMobile)
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  author,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                Spacer(),
                                if (isHovered)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor
                                          .withOpacity(0.1),
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
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(width: 4),
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

                          // Author info for mobile (simplified)
                          if (isMobile)
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                                  ),
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    author,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF1F2937),
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

  Widget _buildCollectionsGrid(double screenWidth, double spacing) {
    final isMobile = screenWidth < 768;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCollectionGridColumns(screenWidth),
        crossAxisSpacing: isMobile ? 16 : spacing,
        mainAxisSpacing: isMobile ? 16 : spacing,
        childAspectRatio: isMobile ? 1 : (screenWidth > 1200 ? 1.5 : 1.3),
      ),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        return _buildCollectionCard(
          collectionId: 'collection-$index',
          title: collection['title'] as String,
          description: collection['description'] as String,
          images: (collection['images'] as List<String>),
        );
      },
    );
  }

  Widget _buildHighlightsGrid(double screenWidth, double spacing) {
    final isMobile = screenWidth < 768;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : _getGridColumns(screenWidth),
        crossAxisSpacing: isMobile ? 16 : spacing,
        mainAxisSpacing: isMobile ? 16 : spacing,
        childAspectRatio: isMobile ? 1.2 : 1.5,
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
