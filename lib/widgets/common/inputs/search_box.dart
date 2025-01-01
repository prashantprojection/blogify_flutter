import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final Color? backgroundColor;
  final Color? borderColor;
  final double height;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final Widget? suffix;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const SearchBox({
    Key? key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.backgroundColor,
    this.borderColor,
    this.height = 44,
    this.contentPadding,
    this.prefix,
    this.suffix,
    this.autofocus = false,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor ?? Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (prefix != null)
            prefix!
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.search,
                color: Colors.grey.shade600,
                size: 20,
              ),
            ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              autofocus: autofocus,
              focusNode: focusNode,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              style: AppTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTheme.bodyMedium.copyWith(
                  color: Colors.grey.shade600,
                ),
                border: InputBorder.none,
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }

  // Factory constructor for search box with filter button
  factory SearchBox.withFilter({
    String hintText = 'Search...',
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onFilterTap,
    Color? backgroundColor,
    Color? borderColor,
    double height = 44,
  }) {
    return SearchBox(
      hintText: hintText,
      controller: controller,
      onChanged: onChanged,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      height: height,
      suffix: IconButton(
        icon: Icon(Icons.tune, color: Colors.grey.shade600),
        onPressed: onFilterTap,
      ),
    );
  }
}
