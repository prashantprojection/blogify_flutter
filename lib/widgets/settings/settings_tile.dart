import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/widgets/painters/tile_reveal_painter.dart';

class SettingsTile extends ConsumerStatefulWidget {
  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? subtitleWidget;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isExpandable;
  final Widget? expandedContent;
  final bool isToggle;
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const SettingsTile({
    super.key,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.leading,
    this.trailing,
    this.onTap,
    this.isExpandable = false,
    this.expandedContent,
    this.isToggle = false,
    this.value,
    this.onChanged,
  }) : assert(title != null || titleWidget != null,
            'Either title or titleWidget must be provided');

  factory SettingsTile.toggle({
    String? title,
    Widget? titleWidget,
    String? subtitle,
    Widget? subtitleWidget,
    Widget? leading,
    bool? value,
    ValueChanged<bool>? onChanged,
  }) {
    return SettingsTile(
      title: title,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      leading: leading,
      isToggle: true,
      value: value,
      onChanged: onChanged,
      trailing: Switch(
        value: value ?? false,
        onChanged: onChanged,
      ),
    );
  }

  factory SettingsTile.expandable({
    String? title,
    Widget? titleWidget,
    String? subtitle,
    Widget? subtitleWidget,
    Widget? leading,
    Widget? expandedContent,
    bool? value,
    ValueChanged<bool>? onChanged,
  }) {
    return SettingsTile(
      title: title,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      leading: leading,
      isExpandable: true,
      expandedContent: expandedContent,
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  ConsumerState<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends ConsumerState<SettingsTile> {
  bool _isExpanded = false;
  bool _isHovered = false;
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          onHover: (event) =>
              setState(() => _mousePosition = event.localPosition),
          child: Stack(
            children: [
              if (_isHovered)
                Positioned.fill(
                  child: CustomPaint(
                    painter: TileRevealPainter(
                      mouseX: _mousePosition.dx,
                      mouseY: _mousePosition.dy,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ListTile(
                leading: widget.leading,
                title: widget.titleWidget ??
                    Text(
                      widget.title!,
                      style: theme.textTheme.titleMedium,
                    ),
                subtitle: widget.subtitleWidget ??
                    (widget.subtitle != null
                        ? Text(
                            widget.subtitle!,
                            style: theme.textTheme.bodyMedium,
                          )
                        : null),
                trailing: widget.isExpandable
                    ? Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: theme.iconTheme.color,
                      )
                    : widget.trailing,
                onTap: widget.isExpandable
                    ? () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      }
                    : widget.onTap,
              ),
            ],
          ),
        ),
        if (widget.isExpandable &&
            _isExpanded &&
            widget.expandedContent != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: widget.expandedContent!,
          ),
      ],
    );
  }
}
