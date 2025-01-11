import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const ShimmerImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  State<ShimmerImage> createState() => _ShimmerImageState();
}

class _ShimmerImageState extends State<ShimmerImage> {
  late ImageProvider _imageProvider;
  bool _isLoading = true;
  bool _hasError = false;
  ImageStream? _imageStream;
  ImageStreamListener? _imageListener;

  @override
  void initState() {
    super.initState();
    _imageProvider = NetworkImage(widget.imageUrl);
    _loadImage();
  }

  void _loadImage() {
    final ImageStream newStream =
        _imageProvider.resolve(ImageConfiguration.empty);
    final ImageStreamListener newListener = ImageStreamListener(
      (ImageInfo imageInfo, bool synchronousCall) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      onError: (dynamic exception, StackTrace? stackTrace) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        }
      },
    );

    _imageStream = newStream;
    _imageListener = newListener;
    newStream.addListener(newListener);
  }

  @override
  void dispose() {
    _imageStream?.removeListener(_imageListener!);
    super.dispose();
  }

  @override
  void didUpdateWidget(ShimmerImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageUrl != oldWidget.imageUrl) {
      _imageStream?.removeListener(_imageListener!);
      _isLoading = true;
      _hasError = false;
      _imageProvider = NetworkImage(widget.imageUrl);
      _loadImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: _hasError
          ? Container(
              width: widget.width,
              height: widget.height,
              color: Colors.grey[200],
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey[400],
                  size: 32,
                ),
              ),
            )
          : _isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: widget.width,
                    height: widget.height,
                    color: Colors.white,
                  ),
                )
              : Image(
                  image: _imageProvider,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: frame != null ? child : const SizedBox(),
                    );
                  },
                ),
    );
  }
}
