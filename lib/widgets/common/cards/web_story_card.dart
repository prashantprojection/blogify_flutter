import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/overlays/gradient_overlay.dart';
import 'package:blogify_flutter/widgets/common/images/network_image.dart';
import 'package:blogify_flutter/widgets/common/cards/badge.dart'
    as custom_badge;

class WebStoryCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String? author;
  final String? authorImageUrl;
  final String? category;
  final Color? badgeColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const WebStoryCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.author,
    this.authorImageUrl,
    this.category,
    this.badgeColor,
    this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<WebStoryCard> createState() => _WebStoryCardState();
}

class _WebStoryCardState extends State<WebStoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: widget.width ?? 280,
          height: widget.height ?? 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (isHovered)
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
                      color: widget.badgeColor ?? AppTheme.primaryColor,
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
                        style: AppTheme.headingSmall.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.author != null) ...[
                        SizedBox(height: 12),
                        Row(
                          children: [
                            if (widget.authorImageUrl != null) ...[
                              CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage(widget.authorImageUrl!),
                              ),
                              SizedBox(width: 8),
                            ],
                            Text(
                              widget.author!,
                              style: AppTheme.bodySmall.copyWith(
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
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
