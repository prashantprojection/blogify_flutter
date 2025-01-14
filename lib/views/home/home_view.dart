import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/app_footer.dart';
import 'package:blogify_flutter/widgets/common/hoverable_cards.dart';
import 'package:blogify_flutter/controllers/article_controller.dart';
import 'package:blogify_flutter/utils/navigation_helper.dart';
import 'package:blogify_flutter/constants/ui_constants.dart';

class WebStory {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color badgeColor;

  const WebStory({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.badgeColor,
  });
}

class Category {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const Category({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class Author {
  final String name;
  final String imageUrl;
  final String bio;
  final int followers;
  final int articles;
  final String specialty;

  const Author({
    required this.name,
    required this.imageUrl,
    required this.bio,
    required this.followers,
    required this.articles,
    required this.specialty,
  });
}

class Channel {
  final String name;
  final String imageUrl;
  final String description;
  final int subscribers;
  final Color color;

  const Channel({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.subscribers,
    required this.color,
  });
}

class TrendingTopic {
  final String name;
  final int articles;
  final IconData icon;
  final Color color;

  const TrendingTopic({
    required this.name,
    required this.articles,
    required this.icon,
    required this.color,
  });
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool isHovered = false;
  final ScrollController _webStoriesController = ScrollController();
  final ScrollController _featuredStoriesController = ScrollController();

  final List<WebStory> webStories = [
    WebStory(
      title: 'Tech Trends 2024',
      subtitle: 'Technology',
      imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
      badgeColor: Color(0xFF3B82F6),
    ),
    WebStory(
      title: 'Sustainable Living',
      subtitle: 'Lifestyle',
      imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09',
      badgeColor: Color(0xFF17B26A),
    ),
    WebStory(
      title: 'Future of AI',
      subtitle: 'Technology',
      imageUrl: 'https://images.unsplash.com/photo-1677442136019-21780ecad995',
      badgeColor: Color(0xFF3B82F6),
    ),
    WebStory(
      title: 'Mental Health',
      subtitle: 'Health',
      imageUrl: 'https://images.unsplash.com/photo-1505455184862-554165e5f6ba',
      badgeColor: Color(0xFFEF4444),
    ),
    WebStory(
      title: 'Financial Tips',
      subtitle: 'Finance',
      imageUrl: 'https://images.unsplash.com/photo-1579621970795-87facc2f976d',
      badgeColor: Color(0xFFF59E0B),
    ),
    WebStory(
      title: 'Travel Stories',
      subtitle: 'Travel',
      imageUrl: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800',
      badgeColor: Color(0xFF8B5CF6),
    ),
    WebStory(
      title: 'Food Culture',
      subtitle: 'Food',
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      badgeColor: Color(0xFFEF4444),
    ),
    WebStory(
      title: 'Art & Design',
      subtitle: 'Art',
      imageUrl: 'https://images.unsplash.com/photo-1513364776144-60967b0f800f',
      badgeColor: Color(0xFFEC4899),
    ),
  ];

  final List<Category> categories = [
    Category(
      icon: Icons.flight,
      title: 'Travel',
      description: 'Discover amazing destinations and travel tips',
      color: Color(0xFF3B82F6),
    ),
    Category(
      icon: Icons.memory,
      title: 'Technology',
      description: 'Stay ahead with the latest in tech',
      color: Color(0xFF8B5CF6),
    ),
    Category(
      icon: Icons.favorite,
      title: 'Lifestyle',
      description: 'Tips for living your best life',
      color: Color(0xFFEC4899),
    ),
    Category(
      icon: Icons.restaurant_menu,
      title: 'Food',
      description: 'Explore culinary adventures and recipes',
      color: Color(0xFF10B981),
    ),
  ];

  final List<Author> topAuthors = [
    Author(
      name: 'Sarah Johnson',
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      bio: 'Tech enthusiast & AI researcher',
      followers: 15200,
      articles: 48,
      specialty: 'Technology',
    ),
    Author(
      name: 'David Chen',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
      bio: 'Travel photographer & writer',
      followers: 12800,
      articles: 36,
      specialty: 'Travel',
    ),
    Author(
      name: 'Emma Wilson',
      imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
      bio: 'Food critic & recipe developer',
      followers: 9500,
      articles: 42,
      specialty: 'Food',
    ),
    Author(
      name: 'Michael Brown',
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
      bio: 'Finance expert & investor',
      followers: 8900,
      articles: 31,
      specialty: 'Finance',
    ),
  ];

  final List<Channel> popularChannels = [
    Channel(
      name: 'Tech Insider',
      imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475',
      description: 'Latest in technology and innovation',
      subscribers: 25600,
      color: Color(0xFF3B82F6),
    ),
    Channel(
      name: 'Wanderlust',
      imageUrl: 'https://images.unsplash.com/photo-1488646953014-85cb44e25828',
      description: 'Travel stories and adventures',
      subscribers: 18900,
      color: Color(0xFF8B5CF6),
    ),
    Channel(
      name: 'Food & Culture',
      imageUrl: 'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f',
      description: 'Exploring food from around the world',
      subscribers: 15400,
      color: Color(0xFFEF4444),
    ),
    Channel(
      name: 'Mindful Living',
      imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
      description: 'Wellness and lifestyle tips',
      subscribers: 12700,
      color: Color(0xFF10B981),
    ),
  ];

  final List<TrendingTopic> trendingTopics = [
    TrendingTopic(
      name: 'Artificial Intelligence',
      articles: 156,
      icon: Icons.psychology,
      color: Color(0xFF3B82F6),
    ),
    TrendingTopic(
      name: 'Sustainable Living',
      articles: 98,
      icon: Icons.eco,
      color: Color(0xFF10B981),
    ),
    TrendingTopic(
      name: 'Digital Marketing',
      articles: 87,
      icon: Icons.trending_up,
      color: Color(0xFFF59E0B),
    ),
    TrendingTopic(
      name: 'Mental Health',
      articles: 76,
      icon: Icons.favorite_border,
      color: Color(0xFFEC4899),
    ),
  ];

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
    return MediaQuery.of(context).size.width < UIConstants.tabletBreakpoint;
  }

  bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= UIConstants.tabletBreakpoint &&
        MediaQuery.of(context).size.width < UIConstants.desktopBreakpoint;
  }

  Widget _buildResponsiveSection({
    required Widget child,
    required bool isMobile,
    required bool isTablet,
    Color? backgroundColor,
    EdgeInsets? padding,
  }) {
    return Container(
      width: double.infinity,
      color: backgroundColor ?? Colors.white,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: isMobile
                ? UIConstants.spacingXL
                : (isTablet ? UIConstants.spacingXXL : 64),
            horizontal: isMobile
                ? UIConstants.spacingM
                : (isTablet ? UIConstants.spacingL : UIConstants.spacingXL),
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
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile, bool isTablet) {
    final theme = ref.watch(themeProvider);
    final titleFontSize = isMobile ? 36.0 : (isTablet ? 48.0 : 64.0);
    final subtitleFontSize = isMobile ? 18.0 : (isTablet ? 20.0 : 24.0);
    final taglineFontSize = isMobile ? 16.0 : (isTablet ? 18.0 : 20.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : (isTablet ? 80 : 120),
        horizontal: isMobile ? 16 : (isTablet ? 32 : 45),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/effects/hero_section.png'),
          opacity: 0.05,
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          colors: [
            theme.colors.primary,
            theme.colors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unleash Your Voice with\nBlogify',
            style: theme.typography.headline.copyWith(
              color: Colors.white,
              fontSize: titleFontSize,
              height: 1.1,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          Text(
            'Share your stories with the world',
            style: theme.typography.body.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontSize: subtitleFontSize,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Connect. Create. Share.',
            style: theme.typography.body.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontSize: taglineFontSize,
            ),
          ),
          SizedBox(height: isMobile ? 32 : 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildHeroButton(
                'Start Blogging',
                onPressed: () => context.go('/create-blog'),
                isMobile: isMobile,
                isPrimary: true,
              ),
              _buildHeroButton(
                'Explore Blogs',
                onPressed: () => context.go('/blog'),
                isMobile: isMobile,
                isPrimary: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroButton(
    String text, {
    required VoidCallback onPressed,
    required bool isMobile,
    required bool isPrimary,
  }) {
    final theme = ref.watch(themeProvider);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isPrimary ? theme.colors.primary : theme.colors.onPrimary,
        foregroundColor:
            isPrimary ? theme.colors.onPrimary : theme.colors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: UIConstants.spacingL,
          vertical: UIConstants.spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
          side: isPrimary ? BorderSide.none : BorderSide(),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isMobile ? 14 : 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFeaturedStoriesSection(
      BuildContext context, bool isMobile, bool isTablet) {
    final articles = ref.watch(sampleArticlesProvider);
    final cardWidth = isMobile
        ? MediaQuery.of(context).size.width * 0.85
        : isTablet
            ? MediaQuery.of(context).size.width * 0.6
            : 360.0;

    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      backgroundColor: Color(0xFFF8F9FA),
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
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () =>
                          _scrollStories(false, _featuredStoriesController),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
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
                  child: HoverableFeaturedPostCard(
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
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () =>
                      _scrollStories(false, _featuredStoriesController),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
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
    final storyHeight = isMobile ? 400.0 : (isTablet ? 440.0 : 479.0);
    final cardWidth = isMobile
        ? MediaQuery.of(context).size.width * 0.7
        : isTablet
            ? MediaQuery.of(context).size.width * 0.5
            : 360.0;

    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
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
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () =>
                          _scrollStories(false, _webStoriesController),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () =>
                          _scrollStories(true, _webStoriesController),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 24),
          SizedBox(
            height: storyHeight,
            child: ListView(
              controller: _webStoriesController,
              scrollDirection: Axis.horizontal,
              children: [
                // Your existing web story cards with adjusted width
                ...webStories
                    .map((story) => Container(
                          width: cardWidth,
                          margin: EdgeInsets.only(right: isMobile ? 16 : 24),
                          child: HoverableWebStoryCard(
                            title: story.title,
                            subtitle: story.subtitle,
                            imageUrl: story.imageUrl,
                            badgeColor: story.badgeColor,
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
          if (isMobile) ...[
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => _scrollStories(false, _webStoriesController),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
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
      backgroundColor: Color(0xFFF8F9FA),
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
                      color: Colors.grey.shade600,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 14 : 16,
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
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: isMobile ? 32 : 48),
        padding: EdgeInsets.all(isMobile ? 24 : 48),
        decoration: BoxDecoration(
          color: Color(0xFF6366F1),
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
              style: TextStyle(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              'Subscribe to our newsletter and get the best stories delivered to your inbox.',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: Colors.white.withOpacity(0.9),
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
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildNewsletterButton(bool isMobile) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF6366F1),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 32,
          vertical: isMobile ? 12 : 16,
        ),
        minimumSize: Size(isMobile ? double.infinity : 120, 44),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          fontSize: isMobile ? 14 : 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text('Subscribe'),
    );
  }

  Widget _buildTopAuthorsSection(
      BuildContext context, bool isMobile, bool isTablet) {
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 14 : 16,
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
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      backgroundColor: Color(0xFFF8F9FA),
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
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 14 : 16,
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
    return _buildResponsiveSection(
      isMobile: isMobile,
      isTablet: isTablet,
      backgroundColor: Color(0xFFF8F9FA),
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 14 : 16,
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

    return Scaffold(
      appBar: AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context, isMobile, isTablet),
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
