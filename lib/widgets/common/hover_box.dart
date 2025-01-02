import 'package:flutter/material.dart';

class HoverBox extends StatefulWidget {
  final Widget Function(BuildContext context, bool isHovered) builder;

  const HoverBox({Key? key, required this.builder}) : super(key: key);

  @override
  State<HoverBox> createState() => _HoverBoxState();
}

class _HoverBoxState extends State<HoverBox> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: widget.builder(context, isHovered),
    );
  }
}
