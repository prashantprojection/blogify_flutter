import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blogify_flutter/widgets/common/menu_widget.dart';
import 'package:blogify_flutter/utils/menu_drawer.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final bool isLarge;
  final double? height;
  final List<Widget>? actions;
  final bool isAuthenticated;

  const AppHeader({
    Key? key,
    this.isLarge = false,
    this.height,
    this.actions,
    this.isAuthenticated = true,
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
      title: title,
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
}

class _AppHeaderState extends State<AppHeader> {
  List<Widget> _buildAuthActions(BuildContext context) {
    if (widget.isAuthenticated) {
      return [
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
      ];
    } else {
      return [
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
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: widget.isLarge ? 16 : 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade800,
    );

    return Material(
      color: Colors.white,
      elevation: 0,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isLarge ? 48 : 32,
            vertical: widget.isLarge ? 20 : 12,
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_note_rounded,
                    size: widget.isLarge ? 40 : 32,
                    color: Colors.blue.shade700,
                  ),
                  SizedBox(width: widget.isLarge ? 12 : 8),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.blue.shade700, Colors.purple.shade700],
                    ).createShader(bounds),
                    child: Text(
                      'Blogify',
                      style: TextStyle(
                        fontSize: widget.isLarge ? 32 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: widget.isLarge ? 64 : 48),
              TextButton(
                onPressed: () => context.go('/'),
                child: Text('Home', style: textStyle),
              ),
              SizedBox(width: widget.isLarge ? 40 : 32),
              TextButton(
                onPressed: () => context.go('/explore'),
                child: Text('Explore', style: textStyle),
              ),
              SizedBox(width: widget.isLarge ? 40 : 32),
              TextButton(
                onPressed: () => context.go('/categories'),
                child: Text('Categories', style: textStyle),
              ),
              SizedBox(width: widget.isLarge ? 40 : 32),
              TextButton(
                onPressed: () => context.go('/stories'),
                child: Text('Stories', style: textStyle),
              ),
              SizedBox(width: widget.isLarge ? 40 : 32),
              TextButton(
                onPressed: () => context.go('/community'),
                child: Text('Community', style: textStyle),
              ),
              const Spacer(),
              if (widget.actions != null)
                ...widget.actions!
              else
                ..._buildAuthActions(context),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomAppHeader extends AppHeader {
  final String? title;
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

  const _CustomAppHeader({
    Key? key,
    this.title,
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
  }) : super(key: key, actions: actions);

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
                      widget.title!,
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
