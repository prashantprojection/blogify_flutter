import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/navigation/carousel_navigation.dart';

class ScrollableSection extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final List<Widget> children;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool showNavigation;
  final double scrollAmount;
  final Axis scrollDirection;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget? trailing;

  const ScrollableSection({
    Key? key,
    this.title,
    this.subtitle,
    required this.children,
    this.spacing = 24,
    this.padding,
    this.controller,
    this.showNavigation = true,
    this.scrollAmount = 300,
    this.scrollDirection = Axis.horizontal,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.trailing,
  }) : super(key: key);

  @override
  State<ScrollableSection> createState() => _ScrollableSectionState();
}

class _ScrollableSectionState extends State<ScrollableSection> {
  late ScrollController _scrollController;
  bool _showPrevious = false;
  bool _showNext = true;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_updateNavigationState);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _updateNavigationState() {
    setState(() {
      _showPrevious = _scrollController.position.pixels > 0;
      _showNext = _scrollController.position.pixels <
          _scrollController.position.maxScrollExtent;
    });
  }

  void _scrollPrevious() {
    _scrollController.animateTo(
      _scrollController.offset - widget.scrollAmount,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollNext() {
    _scrollController.animateTo(
      _scrollController.offset + widget.scrollAmount,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        if (widget.title != null || widget.trailing != null)
          Padding(
            padding: EdgeInsets.only(
              left: (widget.padding as EdgeInsets?)?.left ?? 0,
              right: (widget.padding as EdgeInsets?)?.right ?? 0,
              bottom: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.title != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title!,
                          style: AppTheme.headingMedium.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (widget.subtitle != null) ...[
                          SizedBox(height: 8),
                          Text(
                            widget.subtitle!,
                            style: AppTheme.bodyLarge.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                if (widget.showNavigation)
                  CarouselNavigation(
                    onPrevious: _scrollPrevious,
                    onNext: _scrollNext,
                    showPrevious: _showPrevious,
                    showNext: _showNext,
                  ),
                if (widget.trailing != null) widget.trailing!,
              ],
            ),
          ),
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: widget.scrollDirection,
          padding: widget.padding,
          child: widget.scrollDirection == Axis.horizontal
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildChildren(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildChildren(),
                ),
        ),
      ],
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> result = [];
    for (int i = 0; i < widget.children.length; i++) {
      result.add(widget.children[i]);
      if (i < widget.children.length - 1) {
        if (widget.scrollDirection == Axis.horizontal) {
          result.add(SizedBox(width: widget.spacing));
        } else {
          result.add(SizedBox(height: widget.spacing));
        }
      }
    }
    return result;
  }
}
