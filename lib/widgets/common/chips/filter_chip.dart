import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? labelColor;
  final IconData? icon;
  final double height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;

  const CustomFilterChip({
    Key? key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.selectedColor,
    this.backgroundColor,
    this.labelColor,
    this.icon,
    this.height = 32,
    this.padding,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveSelectedColor = selectedColor ?? AppTheme.primaryColor;
    final effectiveBackgroundColor = backgroundColor ?? Colors.white;
    final effectiveLabelColor = labelColor ?? Colors.grey.shade800;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: height,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? effectiveSelectedColor.withOpacity(0.1)
              : effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(height / 2),
          border: Border.all(
            color: isSelected ? effectiveSelectedColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color:
                    isSelected ? effectiveSelectedColor : effectiveLabelColor,
              ),
              SizedBox(width: 8),
            ],
            Text(
              label,
              style: labelStyle ??
                  AppTheme.bodySmall.copyWith(
                    color: isSelected
                        ? effectiveSelectedColor
                        : effectiveLabelColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // Factory constructor for category filter chip
  factory CustomFilterChip.category({
    required String label,
    required bool isSelected,
    VoidCallback? onTap,
    Color? selectedColor,
  }) {
    return CustomFilterChip(
      label: label,
      isSelected: isSelected,
      onTap: onTap,
      selectedColor: selectedColor,
      height: 36,
      icon: Icons.local_offer_outlined,
    );
  }

  // Factory constructor for sort filter chip
  factory CustomFilterChip.sort({
    required String label,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    return CustomFilterChip(
      label: label,
      isSelected: isSelected,
      onTap: onTap,
      selectedColor: Colors.grey.shade800,
      icon: Icons.sort,
    );
  }
}
