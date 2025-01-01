import 'package:flutter/material.dart';

class LoadingShimmer extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final Widget? child;
  final bool isCircle;

  const LoadingShimmer({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.baseColor = const Color(0xFFEEEEEE),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
    this.child,
    this.isCircle = false,
  }) : super(key: key);

  // Factory constructor for story card shimmer
  factory LoadingShimmer.storyCard() {
    return const LoadingShimmer(
      width: 280,
      height: 400,
      borderRadius: 16,
    );
  }

  // Factory constructor for avatar shimmer
  factory LoadingShimmer.avatar({double radius = 20}) {
    return LoadingShimmer(
      width: radius * 2,
      height: radius * 2,
      isCircle: true,
    );
  }

  // Factory constructor for text shimmer
  factory LoadingShimmer.text({
    double width = 200,
    double height = 16,
  }) {
    return LoadingShimmer(
      width: width,
      height: height,
      borderRadius: 4,
    );
  }

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.isCircle
                ? null
                : BorderRadius.circular(widget.borderRadius),
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(-_animation.value, 0),
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
