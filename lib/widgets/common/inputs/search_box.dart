import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final bool autofocus;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final BorderRadius? borderRadius;
  final Border? border;

  const SearchBox({
    Key? key,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.autofocus = false,
    this.width = 300,
    this.height = 44,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.hintColor,
    this.contentPadding,
    this.prefix,
    this.suffix,
    this.textStyle,
    this.hintStyle,
    this.readOnly = false,
    this.onTap,
    this.textInputAction,
    this.keyboardType,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox>
    with SingleTickerProviderStateMixin {
  bool _isFocused = false;
  bool _hasText = false;
  bool _isHovered = false;
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChange);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      if (_isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _handleTextChange() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.grey.shade50,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              if (widget.prefix != null)
                widget.prefix!
              else
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: widget.iconColor ??
                        (_isFocused || _hasText
                            ? primaryColor
                            : Colors.grey.shade400),
                  ),
                ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: widget.autofocus,
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  textInputAction:
                      widget.textInputAction ?? TextInputAction.search,
                  keyboardType: widget.keyboardType ?? TextInputType.text,
                  style: widget.textStyle?.copyWith(
                        color: widget.textColor ?? Colors.grey.shade800,
                      ) ??
                      TextStyle(
                        color: widget.textColor ?? Colors.grey.shade800,
                        fontSize: 15,
                      ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: widget.hintStyle ??
                        TextStyle(
                          color: widget.hintColor ?? Colors.grey.shade400,
                          fontSize: 15,
                        ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: widget.contentPadding ??
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                    isDense: true,
                  ),
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                ),
              ),
              if (_hasText)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        _controller.clear();
                        widget.onChanged?.call('');
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              if (widget.suffix != null) widget.suffix!,
            ],
          ),
        ),
      ),
    );
  }
}
