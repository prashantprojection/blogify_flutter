import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:blogify_flutter/widgets/common/overlays/gradient_overlay.dart';
import 'package:blogify_flutter/widgets/common/images/network_image.dart';
import 'package:blogify_flutter/widgets/common/cards/badge.dart'
    as custom_badge;

class FeaturedStoryCard extends ConsumerStatefulWidget {
  final String title;
  final String imageUrl;
  final String? subtitle;
  final String? category;
  final Color? badgeColor;
  final VoidCallback? onTap;
  final bool isHoverable;
  final double? width;
  final double? height;

  const FeaturedStoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.subtitle,
    this.category,
    this.badgeColor,
    this.onTap,
    this.isHoverable = true,
    this.width,
    this.height,
  });

  @override
  ConsumerState<FeaturedStoryCard> createState() => _FeaturedStoryCardState();
}

class _FeaturedStoryCardState extends ConsumerState<FeaturedStoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: widget.width ?? 360,
          height: widget.height ?? 480,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (isHovered && widget.isHoverable)
                BoxShadow(
                  color: widget.badgeColor?.withOpacity(0.3) ??
                      Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                ),
                GradientOverlay.transparentToDark(),
                if (widget.category != null)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: custom_badge.Badge(
                      text: widget.category!,
                      color: widget.badgeColor ?? theme.colors.primary,
                    ),
                  ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: theme.typography.title.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.subtitle != null) ...[
                        SizedBox(height: 8),
                        Text(
                          widget.subtitle!,
                          style: theme.typography.body.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
