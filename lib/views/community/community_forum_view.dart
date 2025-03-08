import 'dart:ui';
import 'package:blogify_flutter/models/theme_palette.dart';
import 'package:flutter/material.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/inputs/search_box.dart';
import 'package:blogify_flutter/widgets/common/cards/hoverable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/utils/menu_drawer.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:flutter/rendering.dart';

class CommunityForumView extends ConsumerWidget {
  CommunityForumView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: Column(
        children: [
          // Header Section - Fixed
          Container(
            decoration: BoxDecoration(
              color: theme.colors.surface.withOpacity(0.8),
              border: Border(
                bottom: BorderSide(
                  color: theme.colors.outlineVariant.withOpacity(0.1),
                  width: theme.borders.small,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colors.shadow.withOpacity(0.05),
                  offset: Offset(0, 1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppHeader.custom(
                title: 'Community Forum',
                centerTitle: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.extraLarge,
                  vertical: theme.spacing.medium,
                ),
                titleStyle: theme.typography.title.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: theme.corners.roundedMedium,
                      border: Border.all(
                        color: theme.colors.outlineVariant.withOpacity(0.2),
                        width: theme.borders.small,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colors.shadow.withOpacity(0.05),
                          offset: Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.medium,
                        vertical: theme.spacing.small,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 240,
                            child: SearchBox(
                              hintText: 'Search discussions...',
                              backgroundColor: Colors.transparent,
                              onChanged: (value) {},
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: theme.spacing.small),
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.small,
                              vertical: theme.spacing.extraSmall,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  theme.colors.surfaceVariant.withOpacity(0.5),
                              borderRadius: theme.corners.roundedMedium,
                            ),
                            child: Text(
                              '⌘K',
                              style: theme.typography.caption.copyWith(
                                color: theme.colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.medium),
                  _buildHeaderIconButton(
                    icon: Icons.filter_list,
                    tooltip: 'Sort & Filter',
                    onPressed: () {},
                    theme: theme,
                  ),
                  SizedBox(width: theme.spacing.medium),
                  _buildHeaderIconButton(
                    icon: Icons.notifications_outlined,
                    onPressed: () {},
                    theme: theme,
                    badge: '3',
                  ),
                  SizedBox(width: theme.spacing.medium),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withOpacity(0.1),
                      borderRadius: theme.corners.roundedLarge,
                    ),
                    child: _buildHeaderIconButton(
                      icon: Icons.person_outline,
                      onPressed: () => MenuDrawer.open(context),
                      theme: theme,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: Container(
              margin: EdgeInsets.all(theme.spacing.large),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Sidebar
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: theme.corners.roundedLarge,
                      border: Border.all(
                        color: theme.colors.outlineVariant.withOpacity(0.1),
                        width: theme.borders.small,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colors.shadow.withOpacity(0.05),
                          offset: Offset(0, 4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: theme.corners.roundedLarge,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colors.surfaceVariant.withOpacity(0.3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Categories Section
                              Padding(
                                padding: EdgeInsets.all(theme.spacing.large),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Categories',
                                      style: theme.typography.title.copyWith(
                                        color: theme.colors.onSurface,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: theme.colors.primary
                                            .withOpacity(0.1),
                                        borderRadius:
                                            theme.corners.roundedLarge,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          size: 20,
                                          color: theme.colors.primary,
                                        ),
                                        onPressed: () {},
                                        tooltip: 'Create Category',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: theme.spacing.medium,
                                  ),
                                  children: [
                                    _buildCategoryTile(
                                      icon: Icons.edit,
                                      title: 'Writing Tips',
                                      count: 156,
                                      color: Colors.blue.shade700,
                                      theme: theme,
                                      hasNewPosts: true,
                                    ),
                                    _buildCategoryTile(
                                      icon: Icons.feedback,
                                      title: 'Feedback Requests',
                                      count: 89,
                                      color: Colors.purple.shade700,
                                      theme: theme,
                                      hasNewPosts: true,
                                    ),
                                    _buildCategoryTile(
                                      hasNewPosts: false,
                                      icon: Icons.lightbulb,
                                      title: 'Ideas & Inspiration',
                                      count: 234,
                                      color: Colors.green.shade700,
                                      theme: theme,
                                    ),
                                    _buildCategoryTile(
                                      icon: Icons.group,
                                      title: 'Collaborations',
                                      count: 67,
                                      color: Colors.orange.shade700,
                                      theme: theme,
                                      hasNewPosts: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Main Content Area
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: theme.spacing.large),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: theme.corners.roundedLarge,
                        border: Border.all(
                          color: theme.colors.outlineVariant.withOpacity(0.1),
                          width: theme.borders.small,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colors.shadow.withOpacity(0.05),
                            offset: Offset(0, 4),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: theme.corners.roundedLarge,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  theme.colors.surfaceVariant.withOpacity(0.3),
                            ),
                            child: CustomScrollView(
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsets.all(theme.spacing.large),
                                  sliver: SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Recent Discussions',
                                                  style: theme.typography.title
                                                      .copyWith(
                                                    color:
                                                        theme.colors.onSurface,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        theme.spacing.small),
                                                Text(
                                                  'Join the conversation or start a new discussion',
                                                  style: theme.typography.body
                                                      .copyWith(
                                                    color: theme.colors
                                                        .onSurfaceVariant,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: theme.colors.primary,
                                                borderRadius:
                                                    theme.corners.roundedMedium,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: theme.colors.primary
                                                        .withOpacity(0.25),
                                                    offset: Offset(0, 4),
                                                    blurRadius: 12,
                                                    spreadRadius: -2,
                                                  ),
                                                ],
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {},
                                                  borderRadius: theme
                                                      .corners.roundedMedium,
                                                  hoverColor: Colors.white
                                                      .withOpacity(0.1),
                                                  splashColor: Colors.white
                                                      .withOpacity(0.2),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          theme.spacing.large,
                                                      vertical:
                                                          theme.spacing.medium,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius: theme
                                                                .corners
                                                                .roundedMedium,
                                                          ),
                                                          child: Icon(
                                                            Icons.add_rounded,
                                                            size: 18,
                                                            color: theme.colors
                                                                .onPrimary,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: theme.spacing
                                                                .medium),
                                                        Text(
                                                          'Start Discussion',
                                                          style: theme
                                                              .typography.button
                                                              .copyWith(
                                                            color: theme.colors
                                                                .onPrimary,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: theme.spacing.large),
                                        // Filter Chips with modern styling
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              _buildFilterChip(
                                                label: 'All Topics',
                                                isSelected: true,
                                                theme: theme,
                                              ),
                                              SizedBox(
                                                  width: theme.spacing.small),
                                              _buildFilterChip(
                                                label: 'Most Recent',
                                                theme: theme,
                                              ),
                                              SizedBox(
                                                  width: theme.spacing.small),
                                              _buildFilterChip(
                                                label: 'Most Popular',
                                                theme: theme,
                                              ),
                                              SizedBox(
                                                  width: theme.spacing.small),
                                              _buildFilterChip(
                                                label: 'Unanswered',
                                                theme: theme,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: theme.spacing.large,
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        final thread = _threads[index];
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: theme.spacing.medium),
                                          child: _buildThreadCard(
                                            avatar: thread['avatar'] as String,
                                            author: thread['author'] as String,
                                            title: thread['title'] as String,
                                            time: thread['time'] as String,
                                            category:
                                                thread['category'] as String,
                                            replies: thread['replies'] as int,
                                            views: thread['views'] as int,
                                            isHot: index == 0,
                                            isPinned: index == 1,
                                          ),
                                        );
                                      },
                                      childCount: _threads.length,
                                    ),
                                  ),
                                ),
                                SliverPadding(
                                  padding:
                                      EdgeInsets.all(theme.spacing.extraLarge),
                                  sliver: SliverToBoxAdapter(
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: theme.colors.primary
                                              .withOpacity(0.1),
                                          borderRadius:
                                              theme.corners.roundedMedium,
                                        ),
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor:
                                                theme.colors.primary,
                                            side: BorderSide(
                                              color: theme.colors.primary
                                                  .withOpacity(0.2),
                                              width: theme.borders.small,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  theme.spacing.extraLarge,
                                              vertical: theme.spacing.medium,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  theme.corners.roundedMedium,
                                            ),
                                          ),
                                          child: Text(
                                            'Load More',
                                            style: theme.typography.button
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colors.primary,
                theme.colors.primary.withOpacity(0.8),
              ],
            ),
            borderRadius: theme.corners.roundedMedium,
            boxShadow: [
              BoxShadow(
                color: theme.colors.primary.withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: theme.corners.roundedMedium,
              hoverColor: Colors.white.withOpacity(0.1),
              splashColor: Colors.white.withOpacity(0.2),
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_rounded,
                  color: theme.colors.onPrimary,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 28,
        decoration: BoxDecoration(
          color: theme.colors.surface,
          border: Border(
            top: BorderSide(
              color: theme.colors.outlineVariant.withOpacity(0.1),
              width: theme.borders.small,
            ),
          ),
        ),
        child: Row(
          children: [
            // Forum Stats
            _buildStatusItem(
              icon: Icons.forum_outlined,
              label: '1,234 Discussions',
              theme: theme,
            ),
            _buildStatusDivider(theme),
            _buildStatusItem(
              icon: Icons.people_outline,
              label: '546 Active Members',
              theme: theme,
            ),
            _buildStatusDivider(theme),
            _buildStatusItem(
              icon: Icons.message_outlined,
              label: '8,901 Replies',
              theme: theme,
            ),
            const Spacer(),
            // Right side items
            _buildStatusItem(
              icon: Icons.notifications_none_rounded,
              label: '3 New',
              theme: theme,
              color: theme.colors.primary,
            ),
            _buildStatusDivider(theme),
            _buildStatusItem(
              icon: Icons.circle,
              label: 'Online',
              theme: theme,
              color: Colors.green,
              iconSize: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required ThemePalette theme,
    String? tooltip,
    String? badge,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: theme.corners.roundedMedium,
          child: InkWell(
            borderRadius: theme.corners.roundedMedium,
            hoverColor: theme.colors.surfaceVariant.withOpacity(0.5),
            splashColor: theme.colors.primary.withOpacity(0.1),
            onTap: onPressed,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 24,
                color: theme.colors.onSurface,
              ),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              padding: EdgeInsets.all(theme.spacing.extraSmall),
              decoration: BoxDecoration(
                color: theme.colors.error,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: theme.colors.error.withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  badge,
                  style: theme.typography.label.copyWith(
                    color: theme.colors.onError,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryTile({
    required IconData icon,
    required String title,
    required int count,
    required Color color,
    required ThemePalette theme,
    required bool hasNewPosts,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: theme.spacing.small),
      child: Material(
        color: theme.colors.surface,
        borderRadius: theme.corners.roundedLarge,
        child: InkWell(
          borderRadius: theme.corners.roundedLarge,
          hoverColor: color.withOpacity(0.05),
          splashColor: color.withOpacity(0.1),
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colors.outlineVariant.withOpacity(0.1),
                width: theme.borders.small,
              ),
              borderRadius: theme.corners.roundedLarge,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.medium,
                vertical: theme.spacing.medium,
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.all(theme.spacing.medium),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: theme.corners.roundedLarge,
                        ),
                        child: Icon(icon, size: 20, color: color),
                      ),
                      if (hasNewPosts)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: theme.colors.error,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colors.surface,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colors.error.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: theme.spacing.medium),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.typography.title.copyWith(
                        color: theme.colors.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.spacing.medium,
                      vertical: theme.spacing.small,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: theme.corners.roundedMedium,
                    ),
                    child: Text(
                      count.toString(),
                      style: theme.typography.label.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _threads = [
    {
      'avatar': 'assets/avatars/sarah.jpg',
      'author': 'Sarah Mitchell',
      'title': 'How to create engaging blog introductions?',
      'time': '2 hours ago',
      'category': 'Writing Tips',
      'replies': 24,
      'views': 142,
    },
    {
      'avatar': 'assets/avatars/john.jpg',
      'author': 'John Cooper',
      'title': 'Looking for feedback on my latest tech article',
      'time': '5 hours ago',
      'category': 'Feedback',
      'replies': 18,
      'views': 89,
    },
    // ... Add the rest of your thread data here
  ];

  Widget _buildThreadCard({
    required String avatar,
    required String author,
    required String title,
    required String time,
    required String category,
    required int replies,
    required int views,
    bool isHot = false,
    bool isPinned = false,
  }) {
    final badgeColor = _getCategoryColor(category);

    return Consumer(
      builder: (context, ref, _) {
        final theme = ref.watch(themeProvider);
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.surface,
              borderRadius: theme.corners.roundedLarge,
              border: Border.all(
                color: theme.colors.outlineVariant.withOpacity(0.1),
                width: theme.borders.small,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colors.shadow.withOpacity(0.05),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: theme.corners.roundedLarge,
                hoverColor: badgeColor.withOpacity(0.02),
                splashColor: badgeColor.withOpacity(0.05),
                child: Padding(
                  padding: EdgeInsets.all(theme.spacing.large),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Vote Column with modern styling
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.extraSmall,
                            vertical: theme.spacing.small,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colors.surfaceVariant.withOpacity(0.3),
                            borderRadius: theme.corners.roundedLarge,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildVoteButton(
                                icon: Icons.keyboard_arrow_up_rounded,
                                theme: theme,
                                onTap: () {},
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: theme.spacing.small,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: theme.spacing.medium,
                                  vertical: theme.spacing.extraSmall,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colors.surface,
                                  borderRadius: theme.corners.roundedMedium,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          theme.colors.shadow.withOpacity(0.05),
                                      offset: Offset(0, 2),
                                      blurRadius: 6,
                                      spreadRadius: -2,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '${replies + 12}',
                                  style: theme.typography.code.copyWith(
                                    color: theme.colors.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _buildVoteButton(
                                icon: Icons.keyboard_arrow_down_rounded,
                                theme: theme,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: theme.spacing.medium),
                        // Main Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title & Badges Row
                              Row(
                                children: [
                                  if (isPinned)
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: theme.spacing.small),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: theme.spacing.small,
                                        vertical: theme.spacing.extraSmall,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.colors.primary
                                            .withOpacity(0.1),
                                        borderRadius:
                                            theme.corners.roundedMedium,
                                        border: Border.all(
                                          color: theme.colors.primary
                                              .withOpacity(0.2),
                                          width: theme.borders.small,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.push_pin_rounded,
                                            size: 12,
                                            color: theme.colors.primary,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Pinned',
                                            style:
                                                theme.typography.label.copyWith(
                                              color: theme.colors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (isHot)
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: theme.spacing.small),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: theme.spacing.small,
                                        vertical: theme.spacing.extraSmall,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            theme.colors.error,
                                            theme.colors.error.withOpacity(0.8),
                                          ],
                                        ),
                                        borderRadius:
                                            theme.corners.roundedMedium,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.local_fire_department_rounded,
                                            size: 12,
                                            color: theme.colors.onError,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Hot',
                                            style:
                                                theme.typography.label.copyWith(
                                              color: theme.colors.onError,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: theme.spacing.medium,
                                      vertical: theme.spacing.extraSmall,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeColor.withOpacity(0.1),
                                      borderRadius: theme.corners.roundedMedium,
                                      border: Border.all(
                                        color: badgeColor.withOpacity(0.2),
                                        width: theme.borders.small,
                                      ),
                                    ),
                                    child: Text(
                                      category,
                                      style: theme.typography.label.copyWith(
                                        color: badgeColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: theme.spacing.small),
                              // Title
                              Text(
                                title,
                                style: theme.typography.title.copyWith(
                                  color: theme.colors.onSurface,
                                  height: 1.3,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: theme.spacing.medium),
                              // Author & Stats Row
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: theme.colors.primary
                                            .withOpacity(0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(avatar),
                                      radius: 14,
                                    ),
                                  ),
                                  SizedBox(width: theme.spacing.small),
                                  Text(
                                    author,
                                    style: theme.typography.label.copyWith(
                                      color: theme.colors.onSurface,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: theme.spacing.small),
                                  Container(
                                    width: 3,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: theme.colors.onSurfaceVariant,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: theme.spacing.small),
                                  Text(
                                    time,
                                    style: theme.typography.label.copyWith(
                                      color: theme.colors.onSurfaceVariant,
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
            ),
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Writing Tips':
        return const Color(0xFF2563EB); // Blue
      case 'Feedback':
        return const Color(0xFF7C3AED); // Purple
      case 'Ideas & Inspiration':
        return const Color(0xFF059669); // Green
      case 'Collaborations':
        return const Color(0xFFD97706); // Orange
      default:
        return const Color(0xFF2563EB); // Default blue
    }
  }

  Widget _buildFilterChip({
    required String label,
    bool isSelected = false,
    required ThemePalette theme,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: theme.corners.roundedMedium,
        onTap: () {},
        hoverColor: theme.colors.primary.withOpacity(0.05),
        splashColor: theme.colors.primary.withOpacity(0.1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.large,
            vertical: theme.spacing.medium,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colors.primary.withOpacity(0.1)
                : theme.colors.surfaceVariant.withOpacity(0.5),
            borderRadius: theme.corners.roundedMedium,
            border: Border.all(
              color: isSelected
                  ? theme.colors.primary
                  : theme.colors.outlineVariant.withOpacity(0.2),
              width: theme.borders.small,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: theme.colors.primary,
                ),
                SizedBox(width: theme.spacing.small),
              ],
              Text(
                label,
                style: theme.typography.button.copyWith(
                  color: isSelected
                      ? theme.colors.primary
                      : theme.colors.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoteButton({
    required IconData icon,
    required ThemePalette theme,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: theme.corners.roundedMedium,
      child: InkWell(
        borderRadius: theme.corners.roundedMedium,
        onTap: onTap,
        hoverColor: theme.colors.primary.withOpacity(0.1),
        splashColor: theme.colors.primary.withOpacity(0.15),
        child: Container(
          width: 36,
          height: 36,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: theme.corners.roundedMedium,
            border: Border.all(
              color: theme.colors.outlineVariant.withOpacity(0.2),
              width: theme.borders.small,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colors.shadow.withOpacity(0.05),
                offset: Offset(0, 2),
                blurRadius: 6,
                spreadRadius: -2,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              size: 20,
              color: theme.colors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required ThemePalette theme,
    Color? color,
    double? iconSize,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        hoverColor: theme.colors.surfaceVariant.withOpacity(0.5),
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.medium),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: iconSize ?? 14,
                color: color ?? theme.colors.onSurfaceVariant,
              ),
              SizedBox(width: theme.spacing.small),
              Text(
                label,
                style: theme.typography.caption.copyWith(
                  color: color ?? theme.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDivider(ThemePalette theme) {
    return Container(
      height: 14,
      width: 1,
      margin: EdgeInsets.symmetric(horizontal: theme.spacing.small),
      color: theme.colors.outlineVariant.withOpacity(0.2),
    );
  }
}
