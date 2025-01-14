// Export all components for easy access
library hoverable_components;

import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/home/hover_state_controller.dart';
import 'package:blogify_flutter/widgets/common/neon_border_effect.dart';
import 'package:blogify_flutter/utils/navigation_helper.dart';
import 'package:blogify_flutter/models/article.dart';

class HoverableLatestPostCard extends ConsumerWidget {
  final Article article;
  final bool isHovered;
  final VoidCallback onHover;

  const HoverableLatestPostCard({
    required this.article,
    required this.isHovered,
    required this.onHover,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      onEnter: (_) => onHover(),
      onExit: (_) => onHover(),
      child: GestureDetector(
        onTap: () => NavigationHelper.navigateToArticle(context, article),
        child: Stack(
          children: [
            // ... rest of the implementation
          ],
        ),
      ),
    );
  }
}

class HoverableFeaturedPostCard extends ConsumerWidget {
  final Article article;
  final bool isHovered;
  final VoidCallback onHover;

  const HoverableFeaturedPostCard({
    required this.article,
    required this.isHovered,
    required this.onHover,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      onEnter: (_) => onHover(),
      onExit: (_) => onHover(),
      child: GestureDetector(
        onTap: () => NavigationHelper.navigateToArticle(context, article),
        child: Stack(
          children: [
            // ... rest of the implementation
          ],
        ),
      ),
    );
  }
}

class HoverableWebStoryCard extends ConsumerWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color badgeColor;
  final VoidCallback? onTap;

  const HoverableWebStoryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.badgeColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.webStoryHoverStates[title] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setWebStoryHover(title, true),
      onExit: (_) => hoverNotifier.setWebStoryHover(title, false),
      child: GestureDetector(
        onTap: onTap,
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
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
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
                        subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
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
                            size: 16,
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
                  margin: EdgeInsets.zero,
                ),
              ),
          ],
        ),
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

class HoverableAuthorCard extends ConsumerStatefulWidget {
  final String name;
  final String imageUrl;
  final String bio;
  final int followers;
  final int articles;
  final String category;

  const HoverableAuthorCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.bio,
    required this.followers,
    required this.articles,
    required this.category,
  }) : super(key: key);

  @override
  ConsumerState<HoverableAuthorCard> createState() =>
      _HoverableAuthorCardState();
}

class _HoverableAuthorCardState extends ConsumerState<HoverableAuthorCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? Colors.black.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isHovered ? 10 : 5,
              offset: Offset(0, isHovered ? 5 : 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.category,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                widget.bio,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(Icons.people_outline, '${widget.followers}'),
                  _buildStat(
                      Icons.article_outlined, '${widget.articles} articles'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class HoverableBlogOfDayCard extends ConsumerStatefulWidget {
  final String title;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final String excerpt;
  final String readTime;
  final String publishedDate;

  const HoverableBlogOfDayCard({
    Key? key,
    required this.title,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.excerpt,
    required this.readTime,
    required this.publishedDate,
  }) : super(key: key);

  @override
  ConsumerState<HoverableBlogOfDayCard> createState() =>
      _HoverableBlogOfDayCardState();
}

class _HoverableBlogOfDayCardState
    extends ConsumerState<HoverableBlogOfDayCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? Colors.black.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isHovered ? 20 : 10,
              offset: Offset(0, isHovered ? 10 : 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(),
                    _buildContent(),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildImage()),
                    Expanded(child: _buildContent()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContent() {
    final theme = ref.watch(themeProvider);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.category,
              style: TextStyle(
                color: theme.colors.primary,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 16),
          Text(
            widget.excerpt,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.authorImageUrl),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.author,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${widget.publishedDate} · ${widget.readTime}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HoverableChannelCard extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String description;
  final int subscribers;
  final Color color;

  const HoverableChannelCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.subscribers,
    required this.color,
  }) : super(key: key);

  @override
  State<HoverableChannelCard> createState() => _HoverableChannelCardState();
}

class _HoverableChannelCardState extends State<HoverableChannelCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? Colors.black.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isHovered ? 10 : 5,
              offset: Offset(0, isHovered ? 5 : 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                widget.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 16,
                        color: widget.color,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${widget.subscribers} subscribers',
                        style: TextStyle(
                          color: widget.color,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
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
  }
}

class HoverableTopicChip extends StatefulWidget {
  final String name;
  final int articles;
  final IconData icon;
  final Color color;

  const HoverableTopicChip({
    Key? key,
    required this.name,
    required this.articles,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  State<HoverableTopicChip> createState() => _HoverableTopicChipState();
}

class _HoverableTopicChipState extends State<HoverableTopicChip> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isHovered
              ? widget.color.withOpacity(0.1)
              : widget.color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: widget.color.withOpacity(isHovered ? 0.3 : 0.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 18,
              color: widget.color,
            ),
            SizedBox(width: 8),
            Text(
              widget.name,
              style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${widget.articles}',
                style: TextStyle(
                  color: widget.color,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
