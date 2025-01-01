import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final double minChildWidth;
  final int? maxCrossAxisCount;
  final bool shouldCenter;
  final EdgeInsetsGeometry? padding;

  const ResponsiveGrid({
    Key? key,
    required this.children,
    this.spacing = 24,
    this.runSpacing = 24,
    this.minChildWidth = 280,
    this.maxCrossAxisCount,
    this.shouldCenter = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = (width / (minChildWidth + spacing)).floor();

        // Apply maxCrossAxisCount if specified
        if (maxCrossAxisCount != null) {
          crossAxisCount = crossAxisCount.clamp(1, maxCrossAxisCount!);
        }

        // Ensure at least one item per row
        crossAxisCount = crossAxisCount > 0 ? crossAxisCount : 1;

        // Calculate the actual child width
        final double childWidth =
            ((width - (spacing * (crossAxisCount - 1))) / crossAxisCount)
                .floorToDouble();

        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Wrap(
            spacing: spacing,
            runSpacing: runSpacing,
            alignment:
                shouldCenter ? WrapAlignment.center : WrapAlignment.start,
            children: children.map((child) {
              return SizedBox(
                width: childWidth,
                child: child,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Factory constructor for common grid layouts
  factory ResponsiveGrid.builder({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    double spacing = 24,
    double runSpacing = 24,
    double minChildWidth = 280,
    int? maxCrossAxisCount,
    bool shouldCenter = true,
    EdgeInsetsGeometry? padding,
  }) {
    return ResponsiveGrid(
      spacing: spacing,
      runSpacing: runSpacing,
      minChildWidth: minChildWidth,
      maxCrossAxisCount: maxCrossAxisCount,
      shouldCenter: shouldCenter,
      padding: padding,
      children: List.generate(
        itemCount,
        (index) => Builder(
          builder: (context) => itemBuilder(context, index),
        ),
      ),
    );
  }
}
