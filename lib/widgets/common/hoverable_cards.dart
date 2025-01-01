// Export all components for easy access
library hoverable_components;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/controllers/home/hover_state_controller.dart';
import 'package:blogify_flutter/widgets/common/neon_border_effect.dart';

class HoverableFeaturedCard extends ConsumerWidget {
  final String title;
  final String imageUrl;
  final Color badgeColor;

  const HoverableFeaturedCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.featuredStoryHoverStates[title] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setFeaturedStoryHover(title, true),
      onExit: (_) => hoverNotifier.setFeaturedStoryHover(title, false),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: hoverState
                      ? badgeColor.withOpacity(0.4)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: hoverState ? 20 : 20,
                  spreadRadius: hoverState ? 2 : 0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(Icons.error_outline, size: 48),
                        ),
                      );
                    },
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
                        'Learn how to craft compelling stories that captivate your readers.',
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
                                'John Doe',
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
                            opacity: hoverState ? 1.0 : 0.0,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
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
          if (hoverState)
            Positioned.fill(
              child: NeonBorderEffect(
                borderRadius: 24,
                margin: EdgeInsets.all(0),
              ),
            ),
        ],
      ),
    );
  }
}

class HoverableWebStoryCard extends ConsumerWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color badgeColor;

  const HoverableWebStoryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.webStoryHoverStates[title] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setWebStoryHover(title, true),
      onExit: (_) => hoverNotifier.setWebStoryHover(title, false),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 270,
            height: 479,
            margin: EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: hoverState
                      ? badgeColor.withOpacity(0.4)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: hoverState ? 20 : 20,
                  spreadRadius: hoverState ? 2 : 0,
                  offset: Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(hoverState ? 0.2 : 0.3),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1780&q=80',
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Read Story',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (hoverState)
            Positioned.fill(
              child: NeonBorderEffect(
                borderRadius: 24,
                margin: EdgeInsets.only(right: 24),
              ),
            ),
        ],
      ),
    );
  }
}

class HoverableCategoryCard extends ConsumerStatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color? badgeColor;

  const HoverableCategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.badgeColor,
  }) : super(key: key);

  @override
  ConsumerState<HoverableCategoryCard> createState() =>
      _HoverableCategoryCardState();
}

class _HoverableCategoryCardState extends ConsumerState<HoverableCategoryCard> {
  late final Color color;
  BoxDecoration? _cachedDecoration;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    color = widget.badgeColor ?? Color(0xFF6366F1);
  }

  BoxDecoration _buildDecoration(bool hoverState) {
    if (_cachedDecoration != null && _isHovered == hoverState) {
      return _cachedDecoration!;
    }

    _isHovered = hoverState;
    _cachedDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: hoverState ? color : Color(0xFFE5E7EB),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: hoverState
              ? color.withOpacity(0.4)
              : Colors.black.withOpacity(0.05),
          blurRadius: 20,
          spreadRadius: hoverState ? 2 : 0,
          offset: Offset(0, 4),
        ),
      ],
    );

    return _cachedDecoration!;
  }

  @override
  Widget build(BuildContext context) {
    final hoverState = ref.watch(
      hoverStateProvider
          .select((state) => state.categoryHoverStates[widget.title] ?? false),
    );
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setCategoryHover(widget.title, true),
      onExit: (_) => hoverNotifier.setCategoryHover(widget.title, false),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Container(
                  width: constraints.maxWidth,
                  padding: EdgeInsets.all(24),
                  decoration: _buildDecoration(hoverState),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          widget.icon,
                          color: color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hoverState)
                  Positioned.fill(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                      ),
                      child: NeonBorderEffect(
                        borderRadius: 16,
                        margin: EdgeInsets.zero,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _cachedDecoration = null;
    super.dispose();
  }
}

class HoverableTrendingTopic extends ConsumerWidget {
  final String topic;

  const HoverableTrendingTopic({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.trendingTopicHoverStates[topic] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setTrendingTopicHover(topic, true),
      onExit: (_) => hoverNotifier.setTrendingTopicHover(topic, false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: hoverState
                  ? Color(0xFF6366F1).withOpacity(0.4)
                  : Colors.black.withOpacity(0.05),
              blurRadius: hoverState ? 20 : 20,
              spreadRadius: hoverState ? 2 : 0,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: hoverState ? Color(0xFF6366F1) : Color(0xFFEEF2FF),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#',
              style: TextStyle(
                color: Color(0xFF6366F1),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4),
            Text(
              topic,
              style: TextStyle(
                color: hoverState ? Color(0xFF6366F1) : Color(0xFF1F2937),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoverableAuthorCard extends ConsumerWidget {
  final String name;
  final String category;
  final String bio;
  final String followers;
  final String imageUrl;

  const HoverableAuthorCard({
    Key? key,
    required this.name,
    required this.category,
    required this.bio,
    required this.followers,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.authorHoverStates[name] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setAuthorHover(name, true),
      onExit: (_) => hoverNotifier.setAuthorHover(name, false),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 280,
            height: 220,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hoverState ? Color(0xFF6366F1) : Color(0xFFE5E7EB),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: hoverState
                      ? Color(0xFF6366F1).withOpacity(0.4)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: hoverState ? 20 : 20,
                  spreadRadius: hoverState ? 2 : 0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  bio,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      followers,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hoverState
                            ? Color(0xFF6366F1)
                            : Color(0xFF6366F1).withOpacity(0.1),
                        foregroundColor:
                            hoverState ? Colors.white : Color(0xFF6366F1),
                        elevation: 0,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text('Follow'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (hoverState)
            Positioned.fill(
              child: NeonBorderEffect(
                borderRadius: 16,
                margin: EdgeInsets.all(0),
              ),
            ),
        ],
      ),
    );
  }
}

class HoverableChannelCard extends ConsumerWidget {
  final IconData icon;
  final String title;
  final String description;

  const HoverableChannelCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.channelHoverStates[title] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setChannelHover(title, true),
      onExit: (_) => hoverNotifier.setChannelHover(title, false),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hoverState ? Color(0xFF6366F1) : Color(0xFFE5E7EB),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: hoverState
                      ? Color(0xFF6366F1).withOpacity(0.4)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: hoverState ? 20 : 20,
                  spreadRadius: hoverState ? 2 : 0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Color(0xFF6366F1),
                    size: 24,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          if (hoverState)
            Positioned.fill(
              child: NeonBorderEffect(
                borderRadius: 16,
                margin: EdgeInsets.all(0),
              ),
            ),
        ],
      ),
    );
  }
}

class HoverableBlogOfDay extends ConsumerWidget {
  final Color badgeColor;

  const HoverableBlogOfDay({
    Key? key,
    this.badgeColor = const Color(0xFF17B26A),
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverState = ref
        .watch(hoverStateProvider.select((state) => state.isBlogOfDayHovered));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setBlogOfDayHover(true),
      onExit: (_) => hoverNotifier.setBlogOfDayHover(false),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: hoverState
                      ? badgeColor.withOpacity(0.4)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: hoverState ? 30 : 20,
                  spreadRadius: hoverState ? 5 : 0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1542435503-956c469947f6',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
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
                  Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Blog of the Day',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'The Future of Remote Work and Digital Nomads',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde'),
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alex Thompson',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Digital Nomad & Tech Writer',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
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
          if (hoverState)
            Positioned.fill(
              child: NeonBorderEffect(
                borderRadius: 24,
                margin: EdgeInsets.all(0),
              ),
            ),
        ],
      ),
    );
  }
}
