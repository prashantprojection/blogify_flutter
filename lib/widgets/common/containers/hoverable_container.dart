import 'package:flutter/material.dart';

class HoverableContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final BoxDecoration? decoration;
  final BoxDecoration? hoverDecoration;
  final Duration? duration;
  final bool isEnabled;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Curve curve;

  const HoverableContainer({
    Key? key,
    required this.child,
    this.onTap,
    this.decoration,
    this.hoverDecoration,
    this.duration,
    this.isEnabled = true,
    this.padding,
    this.width,
    this.height,
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<HoverableContainer> createState() => _HoverableContainerState();
}

class _HoverableContainerState extends State<HoverableContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isEnabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter:
          widget.isEnabled ? (_) => setState(() => isHovered = true) : null,
      onExit:
          widget.isEnabled ? (_) => setState(() => isHovered = false) : null,
      child: GestureDetector(
        onTap: widget.isEnabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: widget.duration ?? Duration(milliseconds: 200),
          curve: widget.curve,
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: isHovered ? widget.hoverDecoration : widget.decoration,
          child: widget.child,
        ),
      ),
    );
  }
}
