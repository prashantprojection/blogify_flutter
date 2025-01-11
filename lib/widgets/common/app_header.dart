import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blogify_flutter/utils/menu_drawer.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
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
  State<AppHeader> createState() => _AppHeaderState();

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

  Widget _buildLogo({required bool isMobile}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.edit_note_rounded,
          size: isMobile ? 28 : (isLarge ? 40 : 32),
          color: Colors.blue.shade700,
        ),
        SizedBox(width: isMobile ? 8 : (isLarge ? 12 : 8)),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.blue.shade700, Colors.purple.shade700],
          ).createShader(bounds),
          child: Text(
            'Blogify',
            style: TextStyle(
              fontSize: isMobile ? 20 : (isLarge ? 32 : 24),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _AppHeaderState extends State<AppHeader> {
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

    return Material(
      color: Colors.white,
      elevation: widget.elevation ?? 0,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (widget.isLarge ? 48 : 32),
            vertical: isMobile ? 8 : (widget.isLarge ? 20 : 12),
          ),
          child: Row(
            children: [
              if (isMobile && widget.leading != null) widget.leading!,
              widget._buildLogo(isMobile: isMobile),
              if (!isMobile) ...[
                SizedBox(width: widget.isLarge ? 64 : 48),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () => context.go('/'),
                          child: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: widget.isLarge ? 16 : 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        SizedBox(width: widget.isLarge ? 40 : 32),
                        TextButton(
                          onPressed: () => context.go('/explore'),
                          child: Text(
                            'Explore',
                            style: TextStyle(
                              fontSize: widget.isLarge ? 16 : 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        SizedBox(width: widget.isLarge ? 40 : 32),
                        TextButton(
                          onPressed: () => context.go('/categories'),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: widget.isLarge ? 16 : 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
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
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.person_outline),
                        onPressed: () => MenuDrawer.open(context),
                      ),
                    ],
                  )
                else
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade700,
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
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(width: widget.isLarge ? 24 : 16),
                      IconButton(
                        icon: Icon(
                          Icons.person_outline,
                          size: widget.isLarge ? 28 : 24,
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
                          style: TextStyle(
                            fontSize: widget.isLarge ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                      SizedBox(width: widget.isLarge ? 16 : 12),
                      ElevatedButton(
                        onPressed: () => context.go('/register'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.isLarge ? 24 : 20,
                            vertical: widget.isLarge ? 12 : 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: widget.isLarge ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
              color: Colors.blue.shade700,
            ),
            SizedBox(width: isMobile ? 8 : (widget.isLarge ? 12 : 8)),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.blue.shade700, Colors.purple.shade700],
              ).createShader(bounds),
              child: Text(
                'Blogify',
                style: TextStyle(
                  fontSize: isMobile ? 20 : (widget.isLarge ? 32 : 24),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, String route) {
    final isCurrentRoute = GoRouterState.of(context).uri.path == route;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isCurrentRoute ? Colors.blue.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: TextStyle(
              color:
                  isCurrentRoute ? Colors.blue.shade700 : Colors.grey.shade700,
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
  State<AppHeader> createState() => _CustomAppHeaderState();
}

class _CustomAppHeaderState extends State<_CustomAppHeader> {
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
