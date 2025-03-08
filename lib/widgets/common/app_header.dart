import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:blogify_flutter/utils/menu_drawer.dart';

class AppHeader extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final bool isLarge;
  final double? height;
  final List<Widget>? actions;
  final bool isAuthenticated;
  final bool isSliver;
  final Widget? flexibleSpace;
  final double? expandedHeight;
  final bool floating;
  final bool pinned;
  final bool snap;
  final double? collapsedHeight;
  final Widget? background;
  final ScrollController? scrollController;
  final Color? expandedBackgroundColor;
  final Color? collapsedBackgroundColor;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final bool centerTitle;
  final double? titleSpacing;
  final double? leadingWidth;
  final TextStyle? expandedTitleStyle;
  final TextStyle? collapsedTitleStyle;
  final List<Widget>? expandedActions;
  final List<Widget>? collapsedActions;
  final double? toolbarHeight;
  final double? elevation;
  final Color? shadowColor;
  final bool forceElevated;
  final Widget? bottom;
  final double? bottomHeight;
  final BorderRadius? borderRadius;
  final Curve expandedTitleScale;
  final bool stretch;
  final double stretchTriggerOffset;
  final AsyncCallback? onStretchTrigger;
  final double breakpoint;
  final Widget? mobileLeading;
  final Widget? mobileTitle;
  final List<Widget>? mobileActions;

  const AppHeader({
    Key? key,
    this.isLarge = false,
    this.height,
    this.actions,
    this.isAuthenticated = true,
    this.isSliver = false,
    this.flexibleSpace,
    this.expandedHeight,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.collapsedHeight,
    this.background,
    this.scrollController,
    this.expandedBackgroundColor,
    this.collapsedBackgroundColor,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.centerTitle = false,
    this.titleSpacing,
    this.leadingWidth,
    this.expandedTitleStyle,
    this.collapsedTitleStyle,
    this.expandedActions,
    this.collapsedActions,
    this.toolbarHeight,
    this.elevation,
    this.shadowColor,
    this.forceElevated = false,
    this.bottom,
    this.bottomHeight,
    this.borderRadius,
    this.expandedTitleScale = const Interval(0.0, 1.0, curve: Curves.easeOut),
    this.stretch = false,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.breakpoint = 768,
    this.mobileLeading,
    this.mobileTitle,
    this.mobileActions,
  }) : super(key: key);

  @override
  ConsumerState<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? (isLarge ? 100 : kToolbarHeight + 16));

  // Factory constructor for custom header
  factory AppHeader.custom({
    String? title,
    List<Widget>? actions,
    bool showBackButton = false,
    VoidCallback? onBackPressed,
    Color? backgroundColor,
    Color? shadowColor,
    EdgeInsetsGeometry? padding,
    TextStyle? titleStyle,
    Widget? leading,
    double? elevation,
    bool centerTitle = false,
    Widget? titleWidget,
    PreferredSizeWidget? bottom,
    double? toolbarHeight,
    bool automaticallyImplyLeading = true,
  }) {
    return _CustomAppHeader(
      titleText: title,
      actions: actions,
      showBackButton: showBackButton,
      onBackPressed: onBackPressed,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      padding: padding,
      titleStyle: titleStyle,
      leading: leading,
      elevation: elevation,
      centerTitle: centerTitle,
      titleWidget: titleWidget,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  // Factory constructor for sliver header
  factory AppHeader.sliver({
    bool isLarge = false,
    List<Widget>? actions,
    bool isAuthenticated = true,
    double? expandedHeight,
    bool floating = false,
    bool pinned = true,
    bool snap = false,
    Widget? flexibleSpace,
    Widget? background,
    ScrollController? scrollController,
    Color? expandedBackgroundColor,
    Color? collapsedBackgroundColor,
    TextStyle? expandedTitleStyle,
    TextStyle? collapsedTitleStyle,
    List<Widget>? expandedActions,
    List<Widget>? collapsedActions,
    Widget? leading,
    bool stretch = false,
    double stretchTriggerOffset = 100.0,
    AsyncCallback? onStretchTrigger,
    BorderRadius? borderRadius,
  }) {
    return AppHeader(
      isLarge: isLarge,
      actions: actions,
      isAuthenticated: isAuthenticated,
      isSliver: true,
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      snap: snap,
      flexibleSpace: flexibleSpace,
      background: background,
      scrollController: scrollController,
      expandedBackgroundColor: expandedBackgroundColor,
      collapsedBackgroundColor: collapsedBackgroundColor,
      expandedTitleStyle: expandedTitleStyle,
      collapsedTitleStyle: collapsedTitleStyle,
      expandedActions: expandedActions,
      collapsedActions: collapsedActions,
      leading: leading,
      stretch: stretch,
      stretchTriggerOffset: stretchTriggerOffset,
      onStretchTrigger: onStretchTrigger,
      borderRadius: borderRadius,
    );
  }
}

class _AppHeaderState extends ConsumerState<AppHeader> {
  late ScrollController _scrollController;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (widget.isSliver) {
      final isCollapsed = _scrollController.hasClients &&
          _scrollController.offset >
              (widget.expandedHeight ?? 200) - kToolbarHeight;
      if (isCollapsed != _isCollapsed) {
        setState(() {
          _isCollapsed = isCollapsed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < widget.breakpoint;
    final theme = ref.watch(themeProvider);

    return Material(
      color: theme.colors.surface,
      elevation: widget.elevation ?? 0,
      shadowColor: theme.colors.shadow,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? theme.spacing.medium
                : (widget.isLarge
                    ? theme.spacing.extraLarge
                    : theme.spacing.large),
            vertical: isMobile
                ? theme.spacing.small
                : (widget.isLarge ? theme.spacing.large : theme.spacing.medium),
          ),
          child: Row(
            children: [
              if (isMobile && widget.leading != null) widget.leading!,
              _buildLogo(isMobile: isMobile),
              if (!isMobile) ...[
                SizedBox(
                    width: widget.isLarge
                        ? theme.spacing.extraLarge
                        : theme.spacing.large),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildNavItem(
                          title: 'Home',
                          route: '/',
                          theme: theme,
                        ),
                        SizedBox(
                            width: widget.isLarge
                                ? theme.spacing.large
                                : theme.spacing.medium),
                        _buildNavItem(
                          title: 'Explore',
                          route: '/explore',
                          theme: theme,
                        ),
                        SizedBox(
                            width: widget.isLarge
                                ? theme.spacing.large
                                : theme.spacing.medium),
                        _buildNavItem(
                          title: 'Categories',
                          route: '/categories',
                          theme: theme,
                        ),
                        SizedBox(
                            width: widget.isLarge
                                ? theme.spacing.large
                                : theme.spacing.medium),
                        _buildNavItem(
                          title: 'Stories',
                          route: '/stories',
                          theme: theme,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const Spacer(),
              if (isMobile) ...[
                if (widget.mobileActions != null)
                  ...widget.mobileActions!
                else if (widget.isAuthenticated)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications_outlined,
                            color: theme.colors.onSurface),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.person_outline,
                            color: theme.colors.onSurface),
                        onPressed: () => MenuDrawer.open(context),
                      ),
                    ],
                  )
                else
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      'Sign In',
                      style: theme.typography.button.copyWith(
                        color: theme.colors.primary,
                      ),
                    ),
                  ),
              ] else ...[
                if (widget.actions != null)
                  ...widget.actions!
                else if (widget.isAuthenticated)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications_outlined,
                          size: widget.isLarge ? 28 : 24,
                          color: theme.colors.onSurface,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                          width: widget.isLarge
                              ? theme.spacing.large
                              : theme.spacing.medium),
                      IconButton(
                        icon: Icon(
                          Icons.person_outline,
                          size: widget.isLarge ? 28 : 24,
                          color: theme.colors.onSurface,
                        ),
                        onPressed: () => MenuDrawer.open(context),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: Text(
                          'Sign In',
                          style: theme.typography.button.copyWith(
                            color: theme.colors.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: widget.isLarge
                              ? theme.spacing.medium
                              : theme.spacing.small),
                      ElevatedButton(
                        onPressed: () => context.go('/register'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.isLarge
                                ? theme.spacing.large
                                : theme.spacing.medium,
                            vertical: widget.isLarge
                                ? theme.spacing.medium
                                : theme.spacing.small,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: theme.corners.roundedSmall,
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: theme.typography.button.copyWith(
                            color: theme.colors.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo({required bool isMobile}) {
    final theme = ref.watch(themeProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit_note_rounded,
              size: isMobile ? 28 : (widget.isLarge ? 40 : 32),
              color: theme.colors.primary,
            ),
            SizedBox(
                width: isMobile
                    ? theme.spacing.small
                    : (widget.isLarge
                        ? theme.spacing.medium
                        : theme.spacing.small)),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [theme.colors.primary, theme.colors.secondary],
              ).createShader(bounds),
              child: Text(
                'Blogify',
                style: (isMobile
                        ? theme.typography.title
                        : (widget.isLarge
                            ? theme.typography.display
                            : theme.typography.headline))
                    .copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colors.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String title,
    required String route,
    required theme,
  }) {
    final isCurrentRoute = GoRouterState.of(context).uri.path == route;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.medium,
            vertical: theme.spacing.small,
          ),
          decoration: BoxDecoration(
            color: isCurrentRoute
                ? theme.colors.primaryContainer
                : Colors.transparent,
            borderRadius: theme.corners.roundedLarge,
          ),
          child: Text(
            title,
            style: theme.typography.button.copyWith(
              color: isCurrentRoute
                  ? theme.colors.primary
                  : theme.colors.onSurfaceVariant,
              fontWeight: isCurrentRoute ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomAppHeader extends AppHeader {
  final String? titleText;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final Widget? leading;
  final double? elevation;
  final bool centerTitle;
  final Widget? titleWidget;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final bool automaticallyImplyLeading;

  _CustomAppHeader({
    Key? key,
    this.titleText,
    List<Widget>? actions,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.shadowColor,
    this.padding,
    this.titleStyle,
    this.leading,
    this.elevation,
    this.centerTitle = false,
    this.titleWidget,
    this.bottom,
    this.toolbarHeight,
    this.automaticallyImplyLeading = true,
  }) : super(
          key: key,
          actions: actions,
          isLarge: false,
          isAuthenticated: true,
        );

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  @override
  ConsumerState<AppHeader> createState() => _CustomAppHeaderState();
}

class _CustomAppHeaderState extends ConsumerState<_CustomAppHeader> {
  @override
  Widget build(BuildContext context) {
    final effectivePadding = widget.padding ?? const EdgeInsets.all(16.0);
    final effectiveBackgroundColor =
        widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    final effectiveShadowColor = widget.shadowColor ?? Colors.black;
    final effectiveElevation = widget.elevation ?? 0.0;

    Widget? leadingWidget = widget.leading;
    if (leadingWidget == null &&
        widget.showBackButton &&
        widget.automaticallyImplyLeading) {
      leadingWidget = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: widget.onBackPressed ?? () => Navigator.of(context).pop(),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            boxShadow: [
              if (effectiveElevation > 0)
                BoxShadow(
                  color: effectiveShadowColor.withOpacity(0.05),
                  blurRadius: effectiveElevation * 2,
                  offset: Offset(0, effectiveElevation),
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: widget.centerTitle
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (leadingWidget != null) ...[
                leadingWidget,
                SizedBox(width: 12),
              ],
              if (widget.centerTitle) const Spacer(),
              if (widget.title != null || widget.titleWidget != null)
                widget.titleWidget ??
                    Text(
                      widget.titleText!,
                      style: widget.titleStyle ??
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
              if (widget.centerTitle) const Spacer(),
              if (widget.actions != null) ...[
                const Spacer(),
                ...widget.actions!,
              ],
            ],
          ),
        ),
        if (widget.bottom != null) widget.bottom!,
      ],
    );
  }
}
