import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';

class InfoCard extends StatefulWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isSelected;

  const InfoCard({
    Key? key,
    required this.title,
    this.description,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = widget.iconColor ?? AppTheme.primaryColor;
    final effectiveBackgroundColor = widget.backgroundColor ?? Colors.white;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          padding: widget.padding ?? EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? effectiveIconColor.withOpacity(0.1)
                : effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  widget.isSelected ? effectiveIconColor : Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: effectiveIconColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  size: 32,
                  color: effectiveIconColor,
                ),
              if (widget.icon != null) SizedBox(height: 16),
              Text(
                widget.title,
                style: AppTheme.headingSmall.copyWith(
                  color: widget.isSelected
                      ? effectiveIconColor
                      : Colors.grey.shade800,
                  fontWeight:
                      widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              if (widget.description != null) ...[
                SizedBox(height: 8),
                Text(
                  widget.description!,
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
