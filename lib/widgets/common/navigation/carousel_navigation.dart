import 'package:flutter/material.dart';

class CarouselNavigation extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool showPrevious;
  final bool showNext;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  const CarouselNavigation({
    Key? key,
    required this.onPrevious,
    required this.onNext,
    this.showPrevious = true,
    this.showNext = true,
    this.iconColor,
    this.iconSize,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showPrevious)
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: onPrevious,
            color: iconColor,
            iconSize: iconSize,
            padding: padding,
            splashRadius: 20,
          ),
        if (showNext)
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: onNext,
            color: iconColor,
            iconSize: iconSize,
            padding: padding,
            splashRadius: 20,
          ),
      ],
    );
  }

  // Factory constructor for common navigation with hover effects
  factory CarouselNavigation.withHover({
    required VoidCallback onPrevious,
    required VoidCallback onNext,
    bool showPrevious = true,
    bool showNext = true,
    Color? iconColor,
    double? iconSize,
    EdgeInsetsGeometry? padding,
  }) {
    return CarouselNavigation(
      onPrevious: onPrevious,
      onNext: onNext,
      showPrevious: showPrevious,
      showNext: showNext,
      iconColor: iconColor,
      iconSize: iconSize,
      padding: padding,
    );
  }
}
