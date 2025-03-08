import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:blogify_flutter/views/explore/explore_temp_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/neon_border_effect.dart';
import 'package:blogify_flutter/controllers/article_controller.dart';
import 'package:blogify_flutter/models/article.dart';
import 'package:blogify_flutter/utils/navigation_helper.dart';
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

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  String selectedCategory = 'Most Popular';
  bool isHovered = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Add a method to check if the screen is mobile
  bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  // Add a method to check if the screen is tablet
  bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;
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
    final theme = ref.watch(themeProvider);
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            vertical: theme.spacing.extraLarge,
            horizontal: theme.spacing.large),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Explore the World of Blogging',
              style: theme.typography.headline
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w700)),
          SizedBox(height: theme.spacing.large),
          // Search Box
          _buildSearchBar(),
          SizedBox(height: theme.spacing.extraLarge),
          // Trending Topics
          _buildTrendingTopicsSection(),
          SizedBox(height: theme.spacing.extraLarge),
          // Sort By Section
          _buildSortBySection(),
          SizedBox(height: theme.spacing.extraLarge),
          // Popular Authors Section
          _buildPopularAuthorsSection(),
          SizedBox(height: theme.spacing.extraLarge),
          // Stay Updated Section
          _buildStayUpdatedSection()
        ]));
  }

  Widget _buildSearchBar() {
    final theme = ref.watch(themeProvider);
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: theme.spacing.medium),
        decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: theme.corners.roundedSmall,
            border: Border.all(color: theme.colors.outline)),
        child: Row(children: [
          Icon(Icons.search, color: theme.colors.onSurfaceVariant),
          SizedBox(width: theme.spacing.small),
          Expanded(
              child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search articles...',
                      hintStyle: theme.typography.body
                          .copyWith(color: theme.colors.onSurfaceVariant),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: theme.spacing.small)),
                  style: theme.typography.body)),
          Container(
              height: 24,
              width: theme.borders.small,
              color: theme.colors.outline,
              margin: EdgeInsets.symmetric(horizontal: theme.spacing.small)),
          Tooltip(
              message: 'Advanced filters',
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      borderRadius: theme.corners.roundedMedium,
                      onTap: () {},
                      child: Container(
                          padding: EdgeInsets.all(theme.spacing.small),
                          child: Icon(Icons.tune_rounded,
                              size: 20, color: theme.colors.onSurface)))))
        ]));
  }

  Widget _buildTrendingTopicsSection() {
    final theme = ref.watch(themeProvider);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Trending Topics',
        style: theme.typography.title.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: theme.spacing.medium),
      _buildTrendingTopic(
        'Travel Diaries',
        Icons.flight_takeoff,
        '2.5k',
        Colors.blue,
      ),
      SizedBox(height: theme.spacing.small),
      _buildTrendingTopic(
        'Tech Innovations',
        Icons.computer,
        '1.4k',
        Colors.purple,
      ),
      SizedBox(height: theme.spacing.small),
      _buildTrendingTopic(
        'Food & Recipes',
        Icons.restaurant_menu,
        '1.2k',
        Colors.orange,
      ),
      SizedBox(height: theme.spacing.medium),
      TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text('View All Topics',
              style: theme.typography.button
                  .copyWith(color: theme.colors.primary)))
    ]);
  }

  Widget _buildSortBySection() {
    final theme = ref.watch(themeProvider);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Sort By',
          style: theme.typography.title
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
      SizedBox(height: theme.spacing.small),
      _buildSortByDropdown()
    ]);
  }

  Widget _buildPopularAuthorsSection() {
    final theme = ref.watch(themeProvider);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Popular Authors',
          style: theme.typography.title
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
      SizedBox(height: theme.spacing.medium),
      _buildPopularAuthor('Sarah Johnson', '12.4k followers',
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330'),
      SizedBox(height: theme.spacing.small),
      _buildPopularAuthor('Mark Thompson', '8.3k followers',
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e'),
      SizedBox(height: theme.spacing.small),
      _buildPopularAuthor('Emily Chen', '15.2k followers',
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80')
    ]);
  }

  Widget _buildStayUpdatedSection() {
    final theme = ref.watch(themeProvider);
    return Container(
        padding: EdgeInsets.all(theme.spacing.large),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [theme.colors.primary, theme.colors.secondary]),
            borderRadius: theme.corners.roundedMedium),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Stay Updated!',
              style: theme.typography.title.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colors.onPrimary)),
          SizedBox(height: theme.spacing.small),
          Text('Get exclusive content delivered to your inbox',
              style: theme.typography.body.copyWith(
                  fontSize: 14,
                  color: theme.colors.onPrimary.withOpacity(0.9))),
          SizedBox(height: theme.spacing.medium),
          MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: theme.corners.roundedSmall,
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                  color: theme.colors.primary.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 2)
                            ]
                          : []),
                  child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: theme.typography.body.copyWith(
                            color: theme.colors.onSurfaceVariant, fontSize: 14),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.medium),
                        border: InputBorder.none,
                      ),
                      style: theme.typography.body))),
          SizedBox(height: theme.spacing.small),
          MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.surface,
                          padding: EdgeInsets.symmetric(
                              vertical: theme.spacing.medium),
                          elevation: isHovered ? 8 : 0,
                          shadowColor: isHovered
                              ? theme.colors.primary.withOpacity(0.3)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: theme.corners.roundedSmall)),
                      child: Text('Subscribe',
                          style: theme.typography.button
                              .copyWith(color: theme.colors.primary)))))
        ]));
  }

  void _navigateToArticle(BuildContext context, String postId) {
    final articles = ref.read(sampleArticlesProvider);
    final article = articles.firstWhere((article) => article.id == postId,
        orElse: () => articles.first);
    NavigationHelper.navigateToArticle(context, article);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = isMobileScreen(context);
    final isTablet = isTabletScreen(context);
    final theme = ref.watch(themeProvider);
    final contentPadding =
        isMobile ? theme.spacing.medium : theme.spacing.large;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: theme.colors.background,
        appBar: AppHeader(
            isLarge: false,
            leading: isMobile
                ? IconButton(
                    icon: Icon(Icons.menu, color: theme.colors.onBackground),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer())
                : null,
            elevation: 1,
            mobileActions: [
              IconButton(
                  icon: Icon(Icons.notifications_outlined,
                      color: theme.colors.onBackground),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.person_outline,
                      color: theme.colors.onBackground),
                  onPressed: () {})
            ]),
        drawer: isMobile
            ? Drawer(child: SafeArea(child: _buildSidebarContent()))
            : null,
        body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (!isMobile)
            Container(
                width: isTablet ? screenWidth * 0.3 : screenWidth * 0.23,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: theme.colors.surface.withOpacity(0.8),
                    border: Border(
                      right: BorderSide(color: theme.colors.outline),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: theme.colors.shadow.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5)
                    ]),
                child: ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: _buildSidebarContent()))),
          Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: theme.colors.background,
                  child: SingleChildScrollView(
                      padding: EdgeInsets.all(contentPadding),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLatestPostsSection(isMobile),
                            SizedBox(height: theme.spacing.extraLarge),
                            Text('Popular Collections',
                                style: theme.typography.headline.copyWith(
                                    fontSize: isMobile ? 20 : 24,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: theme.spacing.large),
                            _buildCollectionsGrid(screenWidth, contentPadding),
                            SizedBox(height: theme.spacing.extraLarge),
                            Text('Community Highlights',
                                style: theme.typography.headline.copyWith(
                                    fontSize: isMobile ? 20 : 24,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: theme.spacing.large),
                            _buildHighlightsGrid(screenWidth, contentPadding)
                          ]))))
        ]));
  }

  Widget _buildLatestPostsSection(bool isMobile) {
    final articles = ref.watch(sampleArticlesProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isGridView = ref.watch(viewTypeProvider);
    final theme = ref.watch(themeProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Latest Posts',
            style: TextStyle(
                fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.w700)),
        Row(children: [
          IconButton(
              icon: Icon(Icons.grid_view_rounded,
                  color: isGridView ? theme.colors.primary : Colors.grey),
              onPressed: () =>
                  ref.read(viewTypeProvider.notifier).state = true),
          IconButton(
              icon: Icon(Icons.view_agenda_rounded,
                  color: !isGridView ? theme.colors.primary : Colors.grey),
              onPressed: () =>
                  ref.read(viewTypeProvider.notifier).state = false)
        ])
      ]),
      SizedBox(height: theme.spacing.large),
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
                      crossAxisSpacing: isMobile ? 8 : 16,
                      mainAxisSpacing: isMobile ? 8 : 16,
                      mainAxisExtent: 400),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return _buildLatestPostCard(true, postId: 'post-$index');
                  });
            }

            return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: articles.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: theme.spacing.medium),
                itemBuilder: (context, index) {
                  return _buildLatestPostCard(false, postId: 'post-$index');
                });
          },
          loading: () => Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    CircularProgressIndicator(),
                    SizedBox(height: theme.spacing.medium),
                    Text(AppStrings.loading)
                  ])),
          error: (error, stackTrace) => ErrorView(
              message: error.toString(),
              onRetry: () {
                // Handle retry logic
              }))
    ]);
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
    final theme = ref.watch(themeProvider);

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
                        color: theme.colors.surface,
                        borderRadius: theme.corners.roundedMedium,
                        border: Border.all(color: theme.colors.outline),
                        boxShadow: [
                          BoxShadow(
                              color: isHovered
                                  ? theme.colors.primary.withOpacity(0.4)
                                  : theme.colors.shadow.withOpacity(0.1),
                              blurRadius: 20,
                              offset: Offset(0, 8))
                        ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image Section with Fixed Height
                          SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        theme.corners.roundedMedium.topLeft,
                                    topRight:
                                        theme.corners.roundedMedium.topRight,
                                  ),
                                  child: Image.network(imageUrl,
                                      fit: BoxFit.cover))),
                          // Content Section
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(theme.spacing.medium),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Category Tag
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    theme.spacing.medium,
                                                vertical: theme.spacing.small),
                                            decoration: BoxDecoration(
                                                color: theme.colors.primary
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    theme.corners.roundedLarge),
                                            child: Text(category,
                                                style: theme.typography.body
                                                    .copyWith(fontSize: 14))),
                                        SizedBox(height: theme.spacing.medium),
                                        // Title
                                        Text(
                                          title,
                                          style: theme.typography.title
                                              .copyWith(
                                                  fontSize: 20,
                                                  color:
                                                      theme.colors.onSurface),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: theme.spacing.small),
                                        // Content
                                        Expanded(
                                            child: Text(content,
                                                style: theme.typography.body
                                                    .copyWith(
                                                        color: theme.colors
                                                            .onSurfaceVariant),
                                                maxLines: 3,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        // Author Section
                                        Row(children: [
                                          CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330')),
                                          SizedBox(width: theme.spacing.small),
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                Text(author,
                                                    style: theme.typography.body
                                                        .copyWith(
                                                            color: theme.colors
                                                                .onSurface)),
                                                Text(date,
                                                    style: theme
                                                        .typography.label
                                                        .copyWith(
                                                            color: theme.colors
                                                                .onSurfaceVariant))
                                              ])),
                                          if (isHovered)
                                            Container(
                                                padding: EdgeInsets.all(
                                                    theme.spacing.small),
                                                decoration: BoxDecoration(
                                                    color: theme.colors.primary
                                                        .withOpacity(0.1),
                                                    shape: BoxShape.circle),
                                                child: Icon(Icons.arrow_forward,
                                                    size: 16,
                                                    color:
                                                        theme.colors.primary))
                                        ])
                                      ])))
                        ]))),
            onEnter: (_) =>
                ref.read(hoveredLatestPostProvider.notifier).state = postId,
            onExit: (_) =>
                ref.read(hoveredLatestPostProvider.notifier).state = null,
          );
        },
      );
    }

    // List view card layout
    return Consumer(builder: (context, ref, child) {
      final isHovered = ref.watch(hoveredLatestPostProvider) == postId;
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => _navigateToArticle(context, postId),
              child: Container(
                  height: isMobile ? 140 : null,
                  decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: theme.corners.roundedMedium,
                      border: Border.all(color: theme.colors.outline),
                      boxShadow: [
                        BoxShadow(
                            color: isHovered
                                ? theme.colors.primary.withOpacity(0.4)
                                : theme.colors.shadow.withOpacity(0.1),
                            blurRadius: 20,
                            offset: Offset(0, 8))
                      ]),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image on the left
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: theme.corners.roundedMedium.topLeft,
                                bottomLeft:
                                    theme.corners.roundedMedium.bottomLeft),
                            child: Image.network(imageUrl,
                                width: isMobile ? 140 : 200,
                                height: isMobile ? 140 : 200,
                                fit: BoxFit.cover)),

                        // Content
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(theme.spacing.medium),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Category and Date
                                      Row(children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: theme.spacing.small,
                                                vertical:
                                                    theme.spacing.extraSmall),
                                            decoration: BoxDecoration(
                                                color: theme.colors.primary
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    theme.corners.roundedLarge),
                                            child: Text(category,
                                                style: theme.typography.body
                                                    .copyWith(fontSize: 14))),
                                        SizedBox(width: theme.spacing.small),
                                        Text(date,
                                            style: theme.typography.body
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: theme.colors
                                                        .onSurfaceVariant))
                                      ]),
                                      SizedBox(height: theme.spacing.small),

                                      // Title
                                      Text(title,
                                          style: theme.typography.title
                                              .copyWith(
                                                  fontSize: 20,
                                                  color:
                                                      theme.colors.onSurface),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                      SizedBox(
                                          height: theme.spacing.extraSmall),

                                      // Content
                                      if (!isMobile) ...[
                                        Text(content,
                                            style: theme.typography.body
                                                .copyWith(
                                                    color: theme.colors
                                                        .onSurfaceVariant),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                        SizedBox(height: theme.spacing.medium)
                                      ],

                                      // Author info
                                      if (!isMobile)
                                        Row(children: [
                                          CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330')),
                                          SizedBox(width: theme.spacing.small),
                                          Text(author,
                                              style: theme.typography.body
                                                  .copyWith(
                                                      color: theme
                                                          .colors.onSurface)),
                                          Spacer(),
                                          if (isHovered)
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        theme.spacing.medium,
                                                    vertical:
                                                        theme.spacing.small),
                                                decoration: BoxDecoration(
                                                    color: theme.colors.primary
                                                        .withOpacity(0.1),
                                                    borderRadius: theme
                                                        .corners.roundedLarge),
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('Read More',
                                                          style: theme
                                                              .typography.label
                                                              .copyWith(
                                                                  color: theme
                                                                      .colors
                                                                      .primary)),
                                                      SizedBox(
                                                          width: theme.spacing
                                                              .extraSmall),
                                                      Icon(Icons.arrow_forward,
                                                          size: 16,
                                                          color: theme
                                                              .colors.primary)
                                                    ]))
                                        ]),

                                      // Author info for mobile (simplified)
                                      if (isMobile)
                                        Row(children: [
                                          CircleAvatar(
                                              radius: 12,
                                              backgroundImage: NetworkImage(
                                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330')),
                                          SizedBox(
                                              width: theme.spacing.extraSmall),
                                          Expanded(
                                              child: Text(author,
                                                  style: theme.typography.body
                                                      .copyWith(
                                                          color: theme.colors
                                                              .onSurface),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis))
                                        ])
                                    ])))
                      ]))),
          onEnter: (_) =>
              ref.read(hoveredLatestPostProvider.notifier).state = postId,
          onExit: (_) =>
              ref.read(hoveredLatestPostProvider.notifier).state = null);
    });
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
            childAspectRatio: isMobile ? 1 : (screenWidth > 1200 ? 1.5 : 1.3)),
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final collection = collections[index];
          return _buildCollectionCard(
              collectionId: '$collection-$index',
              title: collection['title'] as String,
              description: collection['description'] as String,
              images: (collection['images'] as List<String>));
        });
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
            childAspectRatio: isMobile ? 1.2 : 1.5),
        itemCount: 8,
        itemBuilder: (context, index) {
          final highlight = highlights[index];
          return _buildHighlightCard(
              highlightId: 'highlight-$index',
              title: highlight['title'] as String,
              likes: highlight['likes'] as String,
              icon: highlight['icon'] as IconData,
              color: highlight['color'] as Color);
        });
  }

  Widget _buildTrendingTopic(
      String title, IconData icon, String count, Color badgeColor) {
    final theme = ref.watch(themeProvider);
    return Consumer(builder: (context, ref, child) {
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
                            padding: EdgeInsets.all(theme.spacing.medium),
                            decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: theme.corners.roundedSmall,
                                border: Border.all(color: theme.colors.outline),
                                boxShadow: isHovered
                                    ? [
                                        BoxShadow(
                                            color: badgeColor.withOpacity(0.2),
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                            offset: Offset(0, -2))
                                      ]
                                    : []),
                            child: Row(children: [
                              Container(
                                  padding: EdgeInsets.all(theme.spacing.small),
                                  decoration: BoxDecoration(
                                      color: badgeColor.withOpacity(0.1),
                                      borderRadius: theme.corners.roundedSmall),
                                  child:
                                      Icon(icon, color: badgeColor, size: 20)),
                              SizedBox(width: theme.spacing.medium),
                              Expanded(
                                  child: Text(title,
                                      style: theme.typography.body.copyWith(
                                          fontWeight: FontWeight.w500))),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: theme.spacing.small,
                                      vertical: theme.spacing.extraSmall),
                                  decoration: BoxDecoration(
                                    color: theme.colors.surfaceVariant,
                                    borderRadius: theme.corners.roundedLarge,
                                  ),
                                  child: Text(count,
                                      style: theme.typography.label.copyWith(
                                          color:
                                              theme.colors.onSurfaceVariant)))
                            ]))));
              }),
          onEnter: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = title,
          onExit: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = null);
    });
  }

  Widget _buildPopularAuthor(String name, String followers, String imageUrl) {
    final theme = ref.watch(themeProvider);
    return Consumer(builder: (context, ref, child) {
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
                            padding: EdgeInsets.all(theme.spacing.medium),
                            decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: theme.corners.roundedSmall,
                                boxShadow: isHovered
                                    ? [
                                        BoxShadow(
                                            color: theme.colors.primary
                                                .withOpacity(0.1),
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                            offset: Offset(0, -2))
                                      ]
                                    : []),
                            child: Row(children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(imageUrl),
                              ),
                              SizedBox(width: theme.spacing.medium),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(name,
                                        style: theme.typography.body.copyWith(
                                            fontWeight: FontWeight.w600)),
                                    Text(followers,
                                        style: theme.typography.label.copyWith(
                                            color:
                                                theme.colors.onSurfaceVariant))
                                  ])),
                              MouseRegion(
                                  onEnter: (_) =>
                                      ref.read(hoveredAuthorButtonProvider.notifier).state =
                                          name,
                                  onExit: (_) =>
                                      ref.read(hoveredAuthorButtonProvider.notifier).state =
                                          null,
                                  child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                          foregroundColor: theme.colors.primary,
                                          side: BorderSide(
                                              color: theme.colors.primary),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: theme.spacing.medium,
                                              vertical: 0),
                                          minimumSize: Size(0, 30),
                                          elevation: isButtonHovered ? 4 : 0,
                                          backgroundColor: isButtonHovered
                                              ? theme.colors.primary
                                                  .withOpacity(0.05)
                                              : Colors.transparent,
                                          shadowColor: isButtonHovered
                                              ? theme.colors.primary
                                                  .withOpacity(0.3)
                                              : Colors.transparent),
                                      child: Text('Follow', style: theme.typography.button)))
                            ]))));
              }),
          onEnter: (_) => ref.read(hoveredAuthorProvider.notifier).state = name,
          onExit: (_) => ref.read(hoveredAuthorProvider.notifier).state = null);
    });
  }

  Widget _buildCollectionCard({
    required String collectionId,
    required String title,
    required String description,
    required List<String> images,
  }) {
    final theme = ref.watch(themeProvider);
    return Consumer(builder: (context, ref, child) {
      final isHovered = ref.watch(hoveredCollectionProvider) == collectionId;
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Stack(children: [
            Container(
                height: 280,
                padding: EdgeInsets.all(theme.spacing.large),
                decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: theme.corners.roundedMedium,
                    border: Border.all(color: theme.colors.outline),
                    boxShadow: [
                      BoxShadow(
                          color: isHovered
                              ? theme.colors.primary.withOpacity(0.4)
                              : theme.colors.shadow.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: isHovered ? 2 : 0,
                          offset: Offset(0, 4))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: theme.typography.title.copyWith(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: theme.spacing.small),
                      Text(description,
                          style: theme.typography.body
                              .copyWith(color: theme.colors.onSurfaceVariant),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: theme.spacing.medium),
                      Expanded(
                          child: Row(
                              children: images.take(3).map((url) {
                        final isLast = url == images.last || url == images[2];
                        return Expanded(
                            child: Container(
                                margin: EdgeInsets.only(
                                    right: isLast ? 0 : theme.spacing.small),
                                child: ClipRRect(
                                    borderRadius: theme.corners.roundedSmall,
                                    child: Image.network(url,
                                        fit: BoxFit.cover,
                                        height: double.infinity, loadingBuilder:
                                            (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                          color: theme.colors.surfaceVariant,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null)));
                                    }, errorBuilder:
                                            (context, error, stackTrace) {
                                      return Container(
                                          color: theme.colors.surfaceVariant,
                                          child: Icon(Icons.error_outline,
                                              color: theme.colors.error));
                                    }))));
                      }).toList())),
                      SizedBox(height: theme.spacing.medium),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${images.length} items',
                                style: theme.typography.body.copyWith(
                                    color: theme.colors.onSurfaceVariant)),
                            Text('View →',
                                style: theme.typography.button
                                    .copyWith(color: theme.colors.primary))
                          ])
                    ])),
            if (isHovered)
              Positioned.fill(
                  child: NeonBorderEffect(
                      borderRadius: theme.corners.roundedMedium.topLeft.x,
                      margin: EdgeInsets.zero))
          ]),
          onEnter: (_) =>
              ref.read(hoveredCollectionProvider.notifier).state = collectionId,
          onExit: (_) =>
              ref.read(hoveredCollectionProvider.notifier).state = null);
    });
  }

  Widget _buildHighlightCard(
      {required String highlightId,
      required String title,
      required String likes,
      required IconData icon,
      required Color color}) {
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeProvider);
      final isHovered = ref.watch(hoveredHighlightProvider) == highlightId;
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Stack(children: [
            Container(
                padding: EdgeInsets.all(theme.spacing.large),
                decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: theme.corners.roundedMedium,
                    border: Border.all(color: theme.colors.outline),
                    boxShadow: [
                      BoxShadow(
                          color: isHovered
                              ? theme.colors.primary.withOpacity(0.4)
                              : theme.colors.shadow.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: isHovered ? 2 : 0,
                          offset: Offset(0, 4))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                            padding: EdgeInsets.all(theme.spacing.small),
                            decoration: BoxDecoration(
                                color: theme.colors.primary.withOpacity(0.1),
                                borderRadius: theme.corners.roundedLarge),
                            child: Icon(icon,
                                color: theme.colors.primary, size: 20)),
                        SizedBox(width: theme.spacing.medium),
                        Expanded(
                            child: Text(title,
                                style: theme.typography.title
                                    .copyWith(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis))
                      ]),
                      Spacer(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('$likes likes',
                                style: theme.typography.body.copyWith(
                                    fontSize: 14,
                                    color: theme.colors.onSurfaceVariant)),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(50, 30),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                                child: Text('View →',
                                    style: theme.typography.button))
                          ])
                    ])),
            if (isHovered)
              Positioned.fill(
                  child: NeonBorderEffect(
                      borderRadius: theme.corners.roundedMedium.topLeft.x,
                      margin: EdgeInsets.zero))
          ]),
          onEnter: (_) =>
              ref.read(hoveredHighlightProvider.notifier).state = highlightId,
          onExit: (_) =>
              ref.read(hoveredHighlightProvider.notifier).state = null);
    });
  }

  Widget _buildSortByDropdown() {
    final theme = ref.watch(themeProvider);
    return Consumer(builder: (context, ref, child) {
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
                            padding: EdgeInsets.symmetric(
                                horizontal: theme.spacing.medium),
                            height: 40,
                            decoration: BoxDecoration(
                                color: theme.colors.surfaceVariant,
                                borderRadius: theme.corners.roundedLarge,
                                boxShadow: isHovered
                                    ? [
                                        BoxShadow(
                                            color: theme.colors.primary
                                                .withOpacity(0.2),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                            offset: Offset(0, -2))
                                      ]
                                    : []),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: selectedCategory,
                                    isExpanded: true,
                                    items: [
                                      'Most Popular',
                                      'Most Recent',
                                      'Highest Rated'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCategory = value!;
                                      });
                                    })))));
              }),
          onEnter: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = 'sort-by',
          onExit: (_) =>
              ref.read(hoveredTrendingTopicProvider.notifier).state = null);
    });
  }
}
