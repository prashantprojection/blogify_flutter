// Export all components for easy access
library hoverable_components;

import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/home/hover_state_controller.dart';
import 'package:blogify_flutter/widgets/common/neon_border_effect.dart';
import 'package:blogify_flutter/utils/navigation_helper.dart';
import 'package:blogify_flutter/models/article.dart';
import 'package:blogify_flutter/models/theme_palette.dart';

class HoverablePostCard extends ConsumerWidget {
  final Article article;
  final bool isHovered;
  final VoidCallback onHover;

  const HoverablePostCard({
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
    final bool hoverState = ref.watch(hoverStateProvider
        .select((state) => state.webStoryHoverStates[title] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);
    final ThemePalette theme = ref.watch(themeProvider);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setWebStoryHover(title, true),
      onExit: (_) => hoverNotifier.setWebStoryHover(title, false),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 270,
              height: 479,
              margin: EdgeInsets.only(right: theme.spacing.large),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: theme.corners.roundedLarge,
                boxShadow: [
                  BoxShadow(
                    color: hoverState
                        ? badgeColor.withOpacity(0.4)
                        : theme.colors.shadow.withOpacity(0.05),
                    blurRadius: 20,
                    spreadRadius: hoverState ? 2 : 0,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    theme.colors.shadow.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(theme.spacing.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.medium,
                        vertical: theme.spacing.small,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: theme.corners.roundedMaximum,
                      ),
                      child: Text(
                        subtitle,
                        style: theme.typography.button.copyWith(
                          color: theme.colors.onPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: theme.spacing.medium),
                    Text(
                      title,
                      style: theme.typography.headline.copyWith(
                        color: theme.colors.onPrimary,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: theme.spacing.medium),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1780&q=80',
                          ),
                        ),
                        SizedBox(width: theme.spacing.medium),
                        Text(
                          'Read Story',
                          style: theme.typography.button.copyWith(
                            color: theme.colors.onPrimary,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(theme.spacing.small),
                          decoration: BoxDecoration(
                            color: theme.colors.onPrimary.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: theme.colors.onPrimary,
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
                  borderRadius: theme.corners.roundedLarge.topLeft.x,
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
  final double? width;
  final EdgeInsetsGeometry? padding;

  const HoverableCategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.badgeColor,
    this.width,
    this.padding,
  }) : super(key: key);

  @override
  ConsumerState<HoverableCategoryCard> createState() =>
      _HoverableCategoryCardState();
}

class _HoverableCategoryCardState extends ConsumerState<HoverableCategoryCard> {
  late final Color color;

  @override
  void initState() {
    super.initState();
    color = widget.badgeColor ?? const Color(0xFF6366F1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
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
            width: widget.width ?? constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: theme.corners.roundedMedium,
            ),
            child: Stack(
              children: [
                Container(
                  width: widget.width ?? constraints.maxWidth,
                  padding:
                      widget.padding ?? EdgeInsets.all(theme.spacing.large),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: theme.corners.roundedMedium,
                    border: Border.all(
                      color: hoverState ? color : theme.colors.outlineVariant,
                      width: theme.borders.small,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: hoverState
                            ? color.withOpacity(0.4)
                            : theme.colors.shadow.withOpacity(0.05),
                        blurRadius: 20,
                        spreadRadius: hoverState ? 2 : 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(theme.spacing.medium),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: theme.corners.roundedMedium,
                        ),
                        child: Icon(
                          widget.icon,
                          color: color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: theme.spacing.medium),
                      Text(
                        widget.title,
                        style: theme.typography.title.copyWith(
                          color: theme.colors.onSurface,
                        ),
                      ),
                      SizedBox(height: theme.spacing.small),
                      Text(
                        widget.description,
                        style: theme.typography.body.copyWith(
                          color: theme.colors.onSurfaceVariant,
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
                        maxWidth: widget.width ?? constraints.maxWidth,
                      ),
                      child: NeonBorderEffect(
                        borderRadius: theme.corners.roundedMedium.topLeft.x,
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
}

class HoverableTrendingTopic extends ConsumerWidget {
  final String topic;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const HoverableTrendingTopic({
    super.key,
    required this.topic,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.trendingTopicHoverStates[topic] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);
    final effectiveColor = color ?? theme.colors.primary;

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setTrendingTopicHover(topic, true),
      onExit: (_) => hoverNotifier.setTrendingTopicHover(topic, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: theme.spacing.large,
              vertical: theme.spacing.medium,
            ),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: theme.corners.roundedMaximum,
          boxShadow: [
            BoxShadow(
              color: hoverState
                  ? effectiveColor.withOpacity(0.4)
                  : theme.colors.shadow.withOpacity(0.05),
              blurRadius: 20,
              spreadRadius: hoverState ? 2 : 0,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: hoverState ? effectiveColor : theme.colors.outlineVariant,
            width: theme.borders.small,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#',
              style: theme.typography.button.copyWith(
                color: effectiveColor,
              ),
            ),
            SizedBox(width: theme.spacing.extraSmall),
            Text(
              topic,
              style: theme.typography.button.copyWith(
                color: hoverState ? effectiveColor : theme.colors.onSurface,
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
  final String imageUrl;
  final String bio;
  final int followers;
  final int articles;
  final String category;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const HoverableAuthorCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.bio,
    required this.followers,
    required this.articles,
    required this.category,
    this.padding,
    this.width,
  }) : super(key: key);

  Widget _buildStat(IconData icon, String value, ThemePalette theme) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colors.onSurfaceVariant,
        ),
        SizedBox(width: theme.spacing.extraSmall),
        Text(
          value,
          style: theme.typography.caption.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.authorHoverStates[name] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setAuthorHover(name, true),
      onExit: (_) => hoverNotifier.setAuthorHover(name, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: theme.corners.roundedMedium,
          boxShadow: [
            BoxShadow(
              color: hoverState
                  ? theme.colors.shadow.withOpacity(0.1)
                  : theme.colors.shadow.withOpacity(0.05),
              blurRadius: hoverState ? 10 : 5,
              offset: Offset(0, hoverState ? 5 : 2),
            ),
          ],
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.all(theme.spacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  SizedBox(width: theme.spacing.medium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: theme.typography.title.copyWith(
                            color: theme.colors.onSurface,
                          ),
                        ),
                        SizedBox(height: theme.spacing.extraSmall),
                        Text(
                          category,
                          style: theme.typography.caption.copyWith(
                            color: theme.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.medium),
              Text(
                bio,
                style: theme.typography.body.copyWith(
                  color: theme.colors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              SizedBox(height: theme.spacing.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(Icons.people_outline, '$followers', theme),
                  _buildStat(
                      Icons.article_outlined, '$articles articles', theme),
                ],
              ),
            ],
          ),
        ),
      ),
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
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double breakpoint;
  final VoidCallback? onTap;

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
    this.padding,
    this.width,
    this.breakpoint = 600,
    this.onTap,
  }) : super(key: key);

  @override
  ConsumerState<HoverableBlogOfDayCard> createState() =>
      _HoverableBlogOfDayCardState();
}

class _HoverableBlogOfDayCardState
    extends ConsumerState<HoverableBlogOfDayCard> {
  bool isHovered = false;

  Widget _buildImage(double imageHeight) {
    return Container(
      height: imageHeight,
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200],
            child: Icon(Icons.error_outline, color: Colors.grey[400]),
          );
        },
      ),
    );
  }

  Widget _buildContent(ThemePalette theme, bool isMobile) {
    return Padding(
      padding: widget.padding ??
          EdgeInsets.all(
              isMobile ? theme.spacing.large : theme.spacing.extraLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.medium,
              vertical: theme.spacing.small,
            ),
            decoration: BoxDecoration(
              color: theme.colors.primary.withOpacity(0.1),
              borderRadius: theme.corners.roundedLarge,
            ),
            child: Text(
              widget.category,
              style: theme.typography.button.copyWith(
                color: theme.colors.primary,
              ),
            ),
          ),
          SizedBox(height: theme.spacing.medium),
          Text(
            widget.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.typography.headline.copyWith(
              color: theme.colors.onSurface,
              height: 1.3,
              fontSize: isMobile ? 20 : 24,
            ),
          ),
          SizedBox(height: theme.spacing.medium),
          Text(
            widget.excerpt,
            maxLines: isMobile ? 3 : 4,
            overflow: TextOverflow.ellipsis,
            style: theme.typography.body.copyWith(
              color: theme.colors.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          SizedBox(height: theme.spacing.large),
          Row(
            children: [
              CircleAvatar(
                radius: isMobile ? 16 : 20,
                backgroundImage: NetworkImage(widget.authorImageUrl),
                onBackgroundImageError: (e, s) => Icon(Icons.person),
              ),
              SizedBox(width: theme.spacing.medium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.author,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.title.copyWith(
                        color: theme.colors.onSurface,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(height: theme.spacing.extraSmall),
                    Text(
                      '${widget.publishedDate} · ${widget.readTime}',
                      style: theme.typography.caption.copyWith(
                        color: theme.colors.onSurfaceVariant,
                        fontSize: isMobile ? 12 : 14,
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

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < widget.breakpoint;
    final imageHeight = isMobile ? size.width * 0.6 : size.height * 0.4;

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width ?? (isMobile ? size.width : null),
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: theme.corners.roundedLarge,
            boxShadow: [
              BoxShadow(
                color: theme.colors.shadow.withOpacity(isHovered ? 0.1 : 0.05),
                blurRadius: isHovered ? 20 : 10,
                offset: Offset(0, isHovered ? 10 : 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: theme.corners.roundedLarge,
            child: isMobile
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImage(imageHeight),
                        _buildContent(theme, isMobile),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(child: _buildImage(imageHeight)),
                      Expanded(child: _buildContent(theme, isMobile)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class HoverableChannelCard extends ConsumerWidget {
  final String name;
  final String imageUrl;
  final String description;
  final int subscribers;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? imageHeight;

  const HoverableChannelCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.subscribers,
    required this.color,
    this.padding,
    this.width,
    this.imageHeight = 160,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final hoverState = ref.watch(hoverStateProvider
        .select((state) => state.channelHoverStates[name] ?? false));
    final hoverNotifier = ref.read(hoverStateProvider.notifier);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.setChannelHover(name, true),
      onExit: (_) => hoverNotifier.setChannelHover(name, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: theme.corners.roundedMedium,
          boxShadow: [
            BoxShadow(
              color: hoverState
                  ? theme.colors.shadow.withOpacity(0.1)
                  : theme.colors.shadow.withOpacity(0.05),
              blurRadius: hoverState ? 10 : 5,
              offset: Offset(0, hoverState ? 5 : 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: theme.corners.roundedMedium.topLeft,
              ),
              child: Image.network(
                imageUrl,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: padding ?? EdgeInsets.all(theme.spacing.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.typography.title.copyWith(
                      color: theme.colors.onSurface,
                    ),
                  ),
                  SizedBox(height: theme.spacing.small),
                  Text(
                    description,
                    style: theme.typography.body.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: theme.spacing.medium),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 16,
                        color: color,
                      ),
                      SizedBox(width: theme.spacing.extraSmall),
                      Text(
                        '$subscribers subscribers',
                        style: theme.typography.button.copyWith(
                          color: color,
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
