import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:blogify_flutter/models/home_page_model/temp_data_model.dart';
import 'package:blogify_flutter/widgets/common/sections/hero_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/app_footer.dart';
import 'package:blogify_flutter/widgets/common/hoverable_cards.dart';
import 'package:blogify_flutter/controllers/article_controller.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool isHovered = false;
  final ScrollController _webStoriesController = ScrollController();
  final ScrollController _featuredStoriesController = ScrollController();

  Widget _buildCategoryCard(
    double width,
    IconData icon,
    String title,
    String description,
    Color color, {
    bool isMobile = false,
  }) {
    return SizedBox(
      width: width,
      child: HoverableCategoryCard(
        icon: icon,
        title: title,
        description: description,
        badgeColor: color,
      ),
    );
  }

  @override
  void dispose() {
    _webStoriesController.dispose();
    _featuredStoriesController.dispose();
    super.dispose();
  }

  void _scrollStories(bool forward, ScrollController controller) {
    if (controller.hasClients) {
      final currentPosition = controller.offset;
      final scrollAmount = MediaQuery.of(context).size.width * 0.8;
      final targetPosition = forward
          ? currentPosition + scrollAmount
          : currentPosition - scrollAmount;

      controller.animateTo(
        targetPosition.clamp(0.0, controller.position.maxScrollExtent),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;
  }

  Widget _buildResponsiveSection({
    required Widget child,
    required bool isMobile,
    required bool isTablet,
    required bool background,
    EdgeInsets? padding,
  }) {
    final theme = ref.watch(themeProvider);
    return Container(
      width: double.infinity,
      color: background ? theme.colors.surface : theme.colors.surfaceVariant,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: isMobile ? 32 : (isTablet ? 48 : 64),
            horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
          ),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * (isMobile ? 0.95 : 0.9),
          child: child,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool isMobile = false}) {
    final theme = ref.watch(themeProvider);
    return Text(
      title,
      style: theme.typography.headline.copyWith(
        fontSize: isMobile ? 24 : 28,
        color: theme.colors.primary,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildFeaturedStoriesSection(
      BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    final articles = ref.watch(sampleArticlesProvider);
    final cardWidth = isMobile
        ? MediaQuery.of(context).size.width * 0.85
        : isTablet
            ? MediaQuery.of(context).size.width * 0.6
            : 360.0;

    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      background: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Featured Stories', isMobile: isMobile),
              if (!isMobile)
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: theme.colors.primary),
                      onPressed: () =>
                          _scrollStories(false, _featuredStoriesController),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios,
                          color: theme.colors.primary),
                      onPressed: () =>
                          _scrollStories(true, _featuredStoriesController),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 24),
          SingleChildScrollView(
            controller: _featuredStoriesController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                articles.length,
                (index) => Container(
                  width: cardWidth,
                  margin: EdgeInsets.only(
                    right:
                        index == articles.length - 1 ? 0 : (isMobile ? 16 : 24),
                  ),
                  child: HoverablePostCard(
                    article: articles[index],
                    isHovered: isHovered,
                    onHover: () => setState(() {
                      isHovered = !isHovered;
                    }),
                  ),
                ),
              ),
            ),
          ),
          if (isMobile) ...[
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: theme.colors.primary),
                  onPressed: () =>
                      _scrollStories(false, _featuredStoriesController),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                      color: theme.colors.primary),
                  onPressed: () =>
                      _scrollStories(true, _featuredStoriesController),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWebStoriesSection(
      BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      background: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Web Stories', isMobile: isMobile),
              if (!isMobile)
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: theme.colors.primary),
                      onPressed: () =>
                          _scrollStories(false, _webStoriesController),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios,
                          color: theme.colors.primary),
                      onPressed: () =>
                          _scrollStories(true, _webStoriesController),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 24),
          SizedBox(
            height: isMobile ? 400.0 : (isTablet ? 440.0 : 479.0),
            child: ListView(
              controller: _webStoriesController,
              scrollDirection: Axis.horizontal,
              children: webStories
                  .map((story) => Container(
                        width: isMobile
                            ? MediaQuery.of(context).size.width * 0.7
                            : isTablet
                                ? MediaQuery.of(context).size.width * 0.5
                                : 360.0,
                        margin: EdgeInsets.only(right: isMobile ? 16 : 24),
                        child: HoverableWebStoryCard(
                          title: story.title,
                          subtitle: story.subtitle,
                          imageUrl: story.imageUrl,
                          badgeColor: story.badgeColor,
                        ),
                      ))
                  .toList(),
            ),
          ),
          if (isMobile) ...[
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: theme.colors.primary),
                  onPressed: () => _scrollStories(false, _webStoriesController),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                      color: theme.colors.primary),
                  onPressed: () => _scrollStories(true, _webStoriesController),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(
      BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      background: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Explore Categories', isMobile: isMobile),
                  SizedBox(height: 8),
                  Text(
                    'Discover content that matters to you',
                    style: theme.typography.body.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => context.go('/categories'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: theme.typography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                        color: theme.colors.primary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 14 : 16,
                      color: theme.colors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 24 : 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth > 1200
                  ? (constraints.maxWidth - 72) / 4
                  : constraints.maxWidth > 800
                      ? (constraints.maxWidth - 48) / 3
                      : constraints.maxWidth > 600
                          ? (constraints.maxWidth - 24) / 2
                          : constraints.maxWidth;

              return Wrap(
                spacing: isMobile ? 16 : 24,
                runSpacing: isMobile ? 16 : 24,
                children: categories
                    .map(
                      (category) => _buildCategoryCard(
                        cardWidth,
                        category.icon,
                        category.title,
                        category.description,
                        category.color,
                        isMobile: isMobile,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection(
      BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      background: true,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: isMobile ? 32 : 48),
        padding: EdgeInsets.all(isMobile ? 24 : 48),
        decoration: BoxDecoration(
          color: theme.colors.primary,
          backgroundBlendMode: BlendMode.darken,
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage('assets/effects/newsletter.png'),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Never Miss a Story!',
              style: theme.typography.headline.copyWith(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.w700,
                color: theme.colors.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              'Subscribe to our newsletter and get the best stories delivered to your inbox.',
              style: theme.typography.body.copyWith(
                fontSize: isMobile ? 14 : 16,
                color: theme.colors.onPrimary.withOpacity(0.9),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 24 : 32),
            if (isMobile)
              Column(
                children: [
                  _buildNewsletterInput('Your name'),
                  SizedBox(height: 16),
                  _buildNewsletterInput('Your email'),
                  SizedBox(height: 16),
                  _buildNewsletterButton(isMobile),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: isTablet ? 200 : 250,
                    child: _buildNewsletterInput('Your name'),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: isTablet ? 200 : 250,
                    child: _buildNewsletterInput('Your email'),
                  ),
                  SizedBox(width: 16),
                  _buildNewsletterButton(isMobile),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsletterInput(String hint) {
    final theme = ref.watch(themeProvider);
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: theme.colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      style: theme.typography.body,
    );
  }

  Widget _buildNewsletterButton(bool isMobile) {
    final theme = ref.watch(themeProvider);
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colors.surface,
        foregroundColor: theme.colors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 32,
          vertical: isMobile ? 12 : 16,
        ),
        minimumSize: Size(isMobile ? double.infinity : 120, 44),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: theme.typography.caption.copyWith(
          fontSize: isMobile ? 14 : 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text('Subscribe'),
    );
  }

  Widget _buildTopAuthorsSection(
      BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      background: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Top Authors', isMobile: isMobile),
              TextButton(
                onPressed: () => context.go('/authors'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: theme.typography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                        color: theme.colors.primary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 14 : 16,
                      color: theme.colors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 24 : 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth > 1200
                  ? (constraints.maxWidth - 72) / 4
                  : constraints.maxWidth > 800
                      ? (constraints.maxWidth - 48) / 3
                      : constraints.maxWidth > 600
                          ? (constraints.maxWidth - 24) / 2
                          : constraints.maxWidth;

              return Wrap(
                spacing: isMobile ? 16 : 24,
                runSpacing: isMobile ? 16 : 24,
                children: topAuthors
                    .map(
                      (author) => SizedBox(
                        width: cardWidth,
                        child: HoverableAuthorCard(
                          name: author.name,
                          imageUrl: author.imageUrl,
                          bio: author.bio,
                          followers: author.followers,
                          articles: author.articles,
                          category: author.specialty,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBlogOfTheDaySection(
      BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      background: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Blog of the Day', isMobile: isMobile),
          SizedBox(height: isMobile ? 24 : 32),
          HoverableBlogOfDayCard(
            title: 'The Future of Sustainable Technology',
            author: 'Sarah Johnson',
            authorImageUrl:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
            category: 'Technology',
            imageUrl:
                'https://images.unsplash.com/photo-1518770660439-4636190af475',
            excerpt:
                'Exploring how technology is shaping a sustainable future through innovative solutions and green initiatives.',
            readTime: '8 min read',
            publishedDate: 'Feb 15, 2024',
          ),
        ],
      ),
    );
  }

  Widget _buildPopularChannelsSection(
      BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      background: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Popular Channels', isMobile: isMobile),
              TextButton(
                onPressed: () => context.go('/channels'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: theme.typography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                        color: theme.colors.primary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 14 : 16,
                      color: theme.colors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 24 : 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth > 1200
                  ? (constraints.maxWidth - 72) / 4
                  : constraints.maxWidth > 800
                      ? (constraints.maxWidth - 48) / 3
                      : constraints.maxWidth > 600
                          ? (constraints.maxWidth - 24) / 2
                          : constraints.maxWidth;

              return Wrap(
                spacing: isMobile ? 16 : 24,
                runSpacing: isMobile ? 16 : 24,
                children: popularChannels
                    .map(
                      (channel) => SizedBox(
                        width: cardWidth,
                        child: HoverableChannelCard(
                          name: channel.name,
                          imageUrl: channel.imageUrl,
                          description: channel.description,
                          subscribers: channel.subscribers,
                          color: channel.color,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTopicsSection(
      BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      background: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Trending Topics', isMobile: isMobile),
              TextButton(
                onPressed: () => context.go('/topics'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: theme.typography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                        color: theme.colors.primary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 14 : 16,
                      color: theme.colors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 24 : 32),
          Wrap(
            spacing: isMobile ? 12 : 16,
            runSpacing: isMobile ? 12 : 16,
            children: trendingTopics
                .map(
                  (topic) => HoverableTopicChip(
                    name: topic.name,
                    articles: topic.articles,
                    icon: topic.icon,
                    color: topic.color,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final theme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection.withActions(
              title: 'Welcome to Blogify',
              subtitle: 'Share your stories with the world',
              description: 'Create beautiful blog posts with our modern editor',
              primaryActionLabel: 'Get Started',
              onPrimaryAction: () => {},
              secondaryActionLabel: 'Learn More',
              onSecondaryAction: () => {},
            ),
            _buildFeaturedStoriesSection(context, isMobile, isTablet),
            _buildWebStoriesSection(context, isMobile, isTablet),
            _buildBlogOfTheDaySection(context, isMobile, isTablet),
            _buildTopAuthorsSection(context, isMobile, isTablet),
            _buildCategoriesSection(context, isMobile, isTablet),
            _buildPopularChannelsSection(context, isMobile, isTablet),
            _buildTrendingTopicsSection(context, isMobile, isTablet),
            _buildNewsletterSection(context, isMobile, isTablet),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
