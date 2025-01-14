import 'package:blogify_flutter/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CustomButtonType { filled, outlined }

class CustomButton extends ConsumerWidget {
  final String label;
  final VoidCallback onPressed;
  final CustomButtonType type;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = CustomButtonType.filled,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.padding,
    this.fontSize,
    this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final defaultPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 20);
    final defaultStyle = TextStyle(
      fontSize: fontSize ?? 18,
      fontWeight: FontWeight.w600,
    );

    if (type == CustomButtonType.outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor ?? Colors.white,
          side: BorderSide(
            color: foregroundColor ?? Colors.white,
            width: 2,
          ),
          padding: padding ?? defaultPadding,
          textStyle: defaultStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(width ?? 0, height ?? 0),
        ),
        child: _buildButtonContent(),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        foregroundColor: foregroundColor ?? theme.colors.primary,
        padding: padding ?? defaultPadding,
        textStyle: defaultStyle,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(width ?? 0, height ?? 0),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    if (icon == null) {
      return Text(label);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
