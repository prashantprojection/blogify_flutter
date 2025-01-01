import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/images/network_image.dart';

class AuthorAvatar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double? avatarRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool showName;
  final Widget? trailing;

  const AuthorAvatar({
    Key? key,
    required this.name,
    this.imageUrl,
    this.avatarRadius = 16,
    this.textStyle,
    this.backgroundColor,
    this.onTap,
    this.showName = true,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageUrl != null)
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: backgroundColor ?? Colors.grey[200],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(avatarRadius!),
                child: CustomNetworkImage(
                  imageUrl: imageUrl!,
                  width: avatarRadius! * 2,
                  height: avatarRadius! * 2,
                  fit: BoxFit.cover,
                  errorWidget: Icon(
                    Icons.person,
                    size: avatarRadius! * 1.2,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            )
          else
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: backgroundColor ?? Colors.grey[200],
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: avatarRadius! * 0.8,
                ),
              ),
            ),
          if (showName) ...[
            SizedBox(width: 8),
            Text(
              name,
              style: textStyle ??
                  AppTheme.bodySmall.copyWith(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
          if (trailing != null) ...[
            SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );
  }
}
