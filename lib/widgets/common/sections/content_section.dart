import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final bool centerContent;

  const ContentSection({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.width,
    this.centerContent = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth =
        width ?? (screenWidth > 1200 ? screenWidth * 0.85 : screenWidth * 0.95);

    return Container(
      width: double.infinity,
      color: backgroundColor ?? Colors.white,
      padding: padding ?? EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: SizedBox(
          width: contentWidth,
          child: centerContent ? Center(child: child) : child,
        ),
      ),
    );
  }
}
