import 'package:flutter/material.dart';

class HoverableCard extends StatefulWidget {
  final Widget child;
  final double elevation;
  final Duration duration;
  final BorderRadius? borderRadius;
  final Color? hoverColor;
  final Color? shadowColor;
  final double? hoverElevation;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final Color? backgroundColor;

  const HoverableCard({
    Key? key,
    required this.child,
    this.elevation = 1.0,
    this.duration = const Duration(milliseconds: 200),
    this.borderRadius,
    this.hoverColor,
    this.shadowColor,
    this.hoverElevation,
    this.onTap,
    this.padding,
    this.border,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<HoverableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: widget.duration,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
            border: widget.border,
            boxShadow: [
              BoxShadow(
                color: (widget.shadowColor ?? Colors.black)
                    .withOpacity(_isHovered ? 0.1 : 0.05),
                blurRadius: _isHovered
                    ? (widget.hoverElevation ?? 8)
                    : (widget.elevation * 4),
                offset: Offset(0, _isHovered ? 4 : 2),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
