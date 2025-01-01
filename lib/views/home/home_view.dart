import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/app_footer.dart';
import 'package:blogify_flutter/widgets/common/hoverable_cards.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth =
        screenWidth > 1200 ? screenWidth * 0.85 : screenWidth * 0.95;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 120,
                horizontal: 45,
              ),
              decoration: AppTheme.heroBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unleash Your Voice with\nBlogify',
                    style: AppTheme.headingLarge.copyWith(
                      color: Colors.white,
                      fontSize: 64,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Share your stories with the world',
                    style: AppTheme.bodyLarge.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Connect. Create. Share.',
                    style: AppTheme.bodyLarge.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go('/create-blog'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Start Blogging'),
                      ),
                      SizedBox(width: 24),
                      OutlinedButton(
                        onPressed: () => context.go('/blog'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white, width: 2),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Explore Blogs'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Featured Stories Section
            Container(
              width: double.infinity,
              color: Color(0xFFF8F9FA),
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Featured Stories',
                        style: AppTheme.headingMedium.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            3,
                            (index) => Container(
                              width: 360,
                              margin: EdgeInsets.only(right: 24),
                              child: HoverableFeaturedCard(
                                title: 'The Art of Storytelling ${index + 1}',
                                imageUrl:
                                    'https://picsum.photos/seed/${index + 1}/800/600',
                                badgeColor: Color(0xFF6366F1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Web Stories Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Web Stories', style: AppTheme.headingMedium),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Container(
                        height: 479,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            HoverableWebStoryCard(
                              title: 'Tech Trends 2024',
                              subtitle: 'Technology',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
                              badgeColor: Color(0xFF3B82F6),
                            ),
                            HoverableWebStoryCard(
                              title: 'Sustainable Living',
                              subtitle: 'Lifestyle',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09',
                              badgeColor: Color(0xFF17B26A),
                            ),
                            HoverableWebStoryCard(
                              title: 'Future of AI',
                              subtitle: 'Technology',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1677442136019-21780ecad995',
                              badgeColor: Color(0xFF3B82F6),
                            ),
                            HoverableWebStoryCard(
                              title: 'Mental Health',
                              subtitle: 'Health',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1505455184862-554165e5f6ba',
                              badgeColor: Color(0xFFEF4444),
                            ),
                            HoverableWebStoryCard(
                              title: 'Financial Tips',
                              subtitle: 'Finance',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1579621970795-87facc2f976d',
                              badgeColor: Color(0xFFF59E0B),
                            ),
                            HoverableWebStoryCard(
                              title: 'Travel Stories',
                              subtitle: 'Travel',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800',
                              badgeColor: Color(0xFF8B5CF6),
                            ),
                            HoverableWebStoryCard(
                              title: 'Food Culture',
                              subtitle: 'Food',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
                              badgeColor: Color(0xFFEF4444),
                            ),
                            HoverableWebStoryCard(
                              title: 'Art & Design',
                              subtitle: 'Art',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1513364776144-60967b0f800f',
                              badgeColor: Color(0xFFEC4899),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Categories Section
            Container(
              width: double.infinity,
              color: Color(0xFFF8F9FA),
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Explore Categories',
                                style: AppTheme.headingMedium.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Discover content that matters to you',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: Colors.grey.shade600,
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
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
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
                      SizedBox(height: 32),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final cardWidth = constraints.maxWidth > 1200
                              ? (constraints.maxWidth - 72) /
                                  4 // 4 cards per row
                              : constraints.maxWidth > 800
                                  ? (constraints.maxWidth - 48) /
                                      3 // 3 cards per row
                                  : constraints.maxWidth > 600
                                      ? (constraints.maxWidth - 24) /
                                          2 // 2 cards per row
                                      : constraints.maxWidth; // 1 card per row

                          return Wrap(
                            spacing: 24,
                            runSpacing: 24,
                            children: [
                              _buildCategoryCard(
                                cardWidth,
                                Icons.flight,
                                'Travel',
                                'Discover amazing destinations and travel tips',
                                Color(0xFF3B82F6),
                              ),
                              _buildCategoryCard(
                                cardWidth,
                                Icons.memory,
                                'Technology',
                                'Stay ahead with the latest in tech',
                                Color(0xFF8B5CF6),
                              ),
                              _buildCategoryCard(
                                cardWidth,
                                Icons.favorite,
                                'Lifestyle',
                                'Tips for living your best life',
                                Color(0xFFEC4899),
                              ),
                              _buildCategoryCard(
                                cardWidth,
                                Icons.restaurant_menu,
                                'Food',
                                'Explore culinary adventures and recipes',
                                Color(0xFF10B981),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Blog of the Day Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Blog of the Day',
                        style: AppTheme.headingMedium.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        height: 500,
                        child: HoverableBlogOfDay(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Trending Topics Section
            Container(
              width: double.infinity,
              color: Color(0xFFF8F9FA),
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Trending Topics',
                          style: AppTheme.headingMedium.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          )),
                      SizedBox(height: 24),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          HoverableTrendingTopic(topic: 'AI in 2025'),
                          HoverableTrendingTopic(topic: 'Travel Hacks'),
                          HoverableTrendingTopic(topic: 'Healthy Living'),
                          HoverableTrendingTopic(topic: 'Digital Nomads'),
                          HoverableTrendingTopic(topic: 'Future Tech'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Authors Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Top Authors',
                          style: AppTheme.headingMedium.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          )),
                      SizedBox(height: 24),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: [
                          HoverableAuthorCard(
                            name: 'David Kim',
                            category: 'Tech Journalist',
                            bio:
                                'Exploring the intersection of technology and human experience.',
                            followers: '45.2K Followers',
                            imageUrl:
                                'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80',
                          ),
                          HoverableAuthorCard(
                            name: 'Lisa Chen',
                            category: 'Food & Travel',
                            bio:
                                'Sharing culinary adventures and travel stories from around the world.',
                            followers: '32.8K Followers',
                            imageUrl:
                                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                          ),
                          HoverableAuthorCard(
                            name: 'Mark Thompson',
                            category: 'Business & Finance',
                            bio:
                                'Breaking down complex financial concepts for everyday readers.',
                            followers: '28.5K Followers',
                            imageUrl:
                                'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                          ),
                          HoverableAuthorCard(
                            name: 'Sophie Williams',
                            category: 'Lifestyle & Wellness',
                            bio:
                                'Inspiring healthy living through mindfulness and self-care.',
                            followers: '21.3K Followers',
                            imageUrl:
                                'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1976&q=80',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Channels Section
            Container(
              width: double.infinity,
              color: Color(0xFFF8F9FA),
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Popular Channels',
                          style: AppTheme.headingMedium.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          )),
                      SizedBox(height: 24),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: [
                          SizedBox(
                            width: 380,
                            child: HoverableChannelCard(
                              icon: Icons.computer,
                              title: 'Tech Enthusiasts',
                              description:
                                  'Join discussions about the latest in technology, programming, and digital innovation.',
                            ),
                          ),
                          SizedBox(
                            width: 380,
                            child: HoverableChannelCard(
                              icon: Icons.restaurant_menu,
                              title: 'Foodies',
                              description:
                                  'Share recipes, restaurant reviews, and culinary tips with fellow food lovers.',
                            ),
                          ),
                          SizedBox(
                            width: 380,
                            child: HoverableChannelCard(
                              icon: Icons.fitness_center,
                              title: 'Fitness Gurus',
                              description:
                                  'Connect with fitness enthusiasts and share workout tips and success stories.',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Newsletter Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 48),
                    padding: EdgeInsets.all(48),
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
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Subscribe to our newsletter and get the best stories delivered to your inbox.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Your name',
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
                              ),
                            ),
                            SizedBox(width: 16),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Your email',
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
                              ),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xFF6366F1),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 0,
                                ),
                                minimumSize: Size(120, 44),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Text('Subscribe'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Explore Blogs Section
            Container(
              width: double.infinity,
              color: Color(0xFFF8F9FA),
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Explore Blogs',
                            style: AppTheme.headingMedium.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 300,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE5E7EB),
                                    width: 1,
                                  ),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search blogs...',
                                    prefixIcon: Icon(Icons.search,
                                        color: Color(0xFF6B7280)),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE5E7EB),
                                    width: 1,
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  value: 'All Categories',
                                  items: [
                                    'All Categories',
                                    'Technology',
                                    'Travel',
                                    'Lifestyle',
                                    'Food'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: Color(0xFF111827),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(double width, IconData icon, String title,
      String description, Color color) {
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
}
