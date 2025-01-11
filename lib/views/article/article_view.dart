import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/widgets/common/app_footer.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/models/article.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/models/comment.dart';
import 'package:blogify_flutter/widgets/common/shimmer_image.dart';
import 'package:blogify_flutter/controllers/article_controller.dart';
import 'package:blogify_flutter/widgets/common/error_widgets.dart';

// Add these constants at the top of the file after the imports
const kMobileBreakpoint = 768.0;
const kTabletBreakpoint = 1024.0;
const kDesktopBreakpoint = 1440.0;
const double kDefaultSpacing = 16.0;
const double kDefaultRadius = 8.0;
const Duration kDefaultDuration = Duration(milliseconds: 300);

// State providers for article view
final fontSizeProvider = StateProvider<double>((ref) => 18.0);
final lineHeightProvider = StateProvider<double>((ref) => 1.8);
final themeProvider = StateProvider<ReadingTheme>((ref) => ReadingTheme.light);
final scrollProgressProvider = StateProvider<double>((ref) => 0.0);
final isExpandedProvider = StateProvider<bool>((ref) => false);
final showControlsProvider = StateProvider<bool>((ref) => true);
final isBookmarkedProvider = StateProvider<bool>((ref) => false);
final activeTableOfContentsItemProvider = StateProvider<String?>((ref) => null);

enum ReadingTheme { light, dark, sepia }

// Add sample comments
final List<Comment> sampleComments = [
  Comment(
    id: '1',
    authorName: 'Emily Chen',
    authorImageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    content:
        'This is a fantastic article! The insights about modern web development trends are spot-on. Looking forward to more content like this.',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    likesCount: 12,
    isLiked: true,
  ),
  Comment(
    id: '2',
    authorName: 'David Kim',
    authorImageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
    content:
        'Great points about JAMstack architecture. Would love to see a deep dive into serverless computing in your next article.',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    likesCount: 8,
    replies: [
      Comment(
        id: '2.1',
        authorName: 'Sarah Johnson',
        authorImageUrl:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
        content:
            'Thanks David! I\'ll definitely cover serverless computing in detail soon.',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        likesCount: 4,
      ),
    ],
  ),
];

class ArticleView extends ConsumerStatefulWidget {
  final Article article;

  const ArticleView({
    super.key,
    required this.article,
  });

  @override
  ConsumerState<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends ConsumerState<ArticleView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  bool _showControls = true;
  double _lastScrollPosition = 0;
  bool _isDarkMode = false;
  double _fontSize = 16.0;
  bool _isLoading = false;
  String? _error;
  GlobalKey _contentKey = GlobalKey();
  Map<String, GlobalKey> _sectionKeys = {};
  bool _isSettingsFabOpen = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _handleScroll();
      _updateActiveSection();
    });
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );

    // Initialize section keys
    for (var item in widget.article.tableOfContents) {
      _sectionKeys[item.id] = GlobalKey();
    }

    _loadArticleData();
  }

  Future<void> _loadArticleData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Simulate loading delay
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  void _handleScroll() {
    if (_scrollController.position.maxScrollExtent > 0) {
      final progress =
          _scrollController.offset / _scrollController.position.maxScrollExtent;
      ref.read(scrollProgressProvider.notifier).state =
          progress.clamp(0.0, 1.0);
    }

    if (_scrollController.offset > _lastScrollPosition && _showControls) {
      setState(() => _showControls = false);
    } else if (_scrollController.offset < _lastScrollPosition &&
        !_showControls) {
      setState(() => _showControls = true);
    }
    _lastScrollPosition = _scrollController.offset;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  Widget _buildCoverImage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < kMobileBreakpoint;

    return SizedBox(
      height: isMobile
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.article.coverImage,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 40, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.title,
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                      shadows: const [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Color(0x80000000),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.article.subtitle,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.4,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleHeader() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              widget.article.author.profileImage,
            ),
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person_outline, color: Colors.grey[400]),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article.author.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '@${widget.article.author.username}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  DateFormat('MMM d, yyyy').format(widget.article.publishedAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  ref.watch(isBookmarkedProvider)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
                onPressed: () {
                  ref.read(isBookmarkedProvider.notifier).state =
                      !ref.read(isBookmarkedProvider);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
                onPressed: () {
                  // Implement share functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTagColor(String tag) {
    // Generate a consistent color based on the tag name
    final colors = [
      const Color(0xFF1E88E5), // Blue
      const Color(0xFF43A047), // Green
      const Color(0xFFE53935), // Red
      const Color(0xFF8E24AA), // Purple
      const Color(0xFFFFB300), // Amber
      const Color(0xFF00ACC1), // Cyan
      const Color(0xFF3949AB), // Indigo
      const Color(0xFFD81B60), // Pink
    ];

    final index = tag.hashCode.abs() % colors.length;
    return colors[index];
  }

  Widget _buildArticleContent() {
    final theme = ref.watch(themeProvider);
    final fontSize = ref.watch(fontSizeProvider);
    final lineHeight = ref.watch(lineHeightProvider);
    final isDarkMode = theme == ReadingTheme.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentWithImages(
          widget.article.content,
          fontSize: fontSize,
          lineHeight: lineHeight,
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }

  List<Widget> _buildContentWithImages(
    String content, {
    required double fontSize,
    required double lineHeight,
    required bool isDarkMode,
  }) {
    final List<Widget> widgets = [];
    final paragraphs = content.split('\n\n');

    for (final paragraph in paragraphs) {
      final trimmedParagraph = paragraph.trim();

      // Check if it's a heading (starts with one or more #)
      if (trimmedParagraph.startsWith('#')) {
        // Count the number of # to determine heading level
        final level =
            RegExp('^#+').firstMatch(trimmedParagraph)?.group(0)?.length ?? 1;
        final headingText = trimmedParagraph.substring(level + 1).trim();

        // Find matching TOC item
        final tocItem = widget.article.tableOfContents.firstWhere(
          (item) => item.title.trim() == headingText.trim(),
          orElse: () => widget.article.tableOfContents.first,
        );

        widgets.add(
          Container(
            key: _sectionKeys[tocItem.id],
            padding: EdgeInsets.only(
              top: 48 - (level * 4),
              bottom: 24 - (level * 4),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color:
                    ref.watch(activeTableOfContentsItemProvider) == tocItem.id
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                headingText,
                style: TextStyle(
                  fontSize: fontSize * (2.5 - (level * 0.3)),
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      } else if (trimmedParagraph.startsWith('![')) {
        // Handle images
        final regex = RegExp(r'!\[(.*?)\]\((.*?)\)');
        final match = regex.firstMatch(trimmedParagraph);
        if (match != null) {
          final altText = match.group(1) ?? '';
          final imageUrl = match.group(2) ?? '';

          widgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 300,
                          color:
                              isDarkMode ? Colors.grey[850] : Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          color:
                              isDarkMode ? Colors.grey[850] : Colors.grey[200],
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 40,
                                  color: isDarkMode
                                      ? Colors.grey[600]
                                      : Colors.grey[400],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Failed to load image',
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (altText.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      altText,
                      style: TextStyle(
                        fontSize: fontSize * 0.9,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
      } else if (trimmedParagraph.startsWith('- ')) {
        // Handle unordered lists
        final items = trimmedParagraph
            .split('\n')
            .where((line) => line.startsWith('- '))
            .map((line) => line.substring(2).trim())
            .toList();
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: fontSize * 0.5),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black87,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  height: lineHeight,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      } else if (trimmedParagraph.startsWith(RegExp(r'\d+\.'))) {
        // Handle ordered lists
        final items = trimmedParagraph
            .split('\n')
            .where((line) => line.trim().startsWith(RegExp(r'\d+\.')))
            .map((line) => line.replaceFirst(RegExp(r'\d+\.\s*'), '').trim())
            .toList();

        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .asMap()
                  .entries
                  .map((entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                '${entry.key + 1}.',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  height: lineHeight,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      } else {
        // Handle regular paragraphs
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              trimmedParagraph,
              style: TextStyle(
                fontSize: fontSize,
                height: lineHeight,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  Widget _buildReadingProgressHeader() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;
    final progress = ref.watch(scrollProgressProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _showControls ? 60 : 0,
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.grey[900]!.withOpacity(0.95)
            : Colors.white.withOpacity(0.95),
        boxShadow: _showControls
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ]
            : [],
      ),
      child: _showControls
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.article.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                                minHeight: 2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${(progress * 100).round()}%',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _buildMiniControlButton(
                        icon: ref.watch(isBookmarkedProvider)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        onPressed: () {
                          ref.read(isBookmarkedProvider.notifier).state =
                              !ref.read(isBookmarkedProvider);
                        },
                      ),
                      _buildMiniControlButton(
                        icon: Icons.share_outlined,
                        onPressed: () {
                          // Implement share
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildMiniControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final isDarkMode = ref.watch(themeProvider) == ReadingTheme.dark;

    return IconButton(
      icon: Icon(
        icon,
        size: 20,
        color: isDarkMode ? Colors.white70 : Colors.grey[700],
      ),
      onPressed: onPressed,
      splashRadius: 20,
    );
  }

  Widget _buildModernTableOfContents() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;
    final activeItem = ref.watch(activeTableOfContentsItemProvider);

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        border: Border(
          right: BorderSide(
            color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: _getDefaultPadding(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Contents',
                  style: _getTextStyle(
                    isDarkMode: isDarkMode,
                    fontSize: 16,
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: widget.article.tableOfContents.length,
              itemBuilder: (context, index) {
                final item = widget.article.tableOfContents[index];
                return _buildTocItem(item, activeItem);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTocItem(TableOfContentsItem item, String? activeItem) {
    final isActive = activeItem == item.id;
    final isDarkMode = ref.watch(themeProvider) == ReadingTheme.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: InkWell(
        onTap: () => _scrollToSection(item.position),
        borderRadius: BorderRadius.circular(kDefaultRadius),
        child: AnimatedContainer(
          duration: kDefaultDuration,
          padding: EdgeInsets.only(
            left: 12 + (item.level - 1) * 16.0,
            right: 12,
            top: 8,
            bottom: 8,
          ),
          decoration: _getContainerDecoration(
            isDarkMode: isDarkMode,
            isActive: isActive,
          ),
          child: Row(
            children: [
              Container(
                width: 2,
                height: 16 - (item.level - 1) * 2,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? Theme.of(context).primaryColor
                      : (isDarkMode ? Colors.grey[700] : Colors.grey[300]),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              Expanded(
                child: Text(
                  item.title,
                  style: _getTextStyle(
                    isDarkMode: isDarkMode,
                    fontSize: 15 - (item.level - 1),
                    weight: isActive || item.level == 1
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (isActive)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernReadingControls() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;

    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: Offset(_showControls ? 0 : 1, 0),
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          right: 24,
        ),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildModernControlButton(
              icon: Icons.format_size,
              label: 'Text Size',
              onPressed: _showFontSizeDialog,
              showBorder: true,
            ),
            _buildModernControlButton(
              icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
              label: '${isDarkMode ? 'Light' : 'Dark'} Mode',
              onPressed: () => ref.read(themeProvider.notifier).state =
                  isDarkMode ? ReadingTheme.light : ReadingTheme.dark,
              showBorder: true,
            ),
            _buildModernControlButton(
              icon: ref.watch(isBookmarkedProvider)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              label: 'Save',
              onPressed: () => ref.read(isBookmarkedProvider.notifier).state =
                  !ref.read(isBookmarkedProvider),
              showBorder: true,
            ),
            _buildModernControlButton(
              icon: Icons.share_outlined,
              label: 'Share',
              onPressed: () {
                // Implement share
              },
              showBorder: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required bool showBorder,
  }) {
    final isDarkMode = ref.watch(themeProvider) == ReadingTheme.dark;

    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? Border(
                bottom: BorderSide(
                  color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                ),
              )
            : null,
      ),
      child: Tooltip(
        message: label,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Icon(
                icon,
                color: isDarkMode ? Colors.white70 : Colors.grey[700],
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFontSizeDialog() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final currentFontSize = ref.watch(fontSizeProvider);

          return AlertDialog(
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
            title: Text(
              'Adjust Font Size',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'A',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    Text(
                      'A',
                      style: TextStyle(
                        fontSize: 24,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: currentFontSize,
                  min: 14,
                  max: 24,
                  divisions: 10,
                  label: currentFontSize.round().toString(),
                  onChanged: (value) {
                    ref.read(fontSizeProvider.notifier).state = value;
                    setState(() {}); // Update the dialog UI
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Sample Text',
                    style: TextStyle(
                      fontSize: currentFontSize,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFloatingProgressBar() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;
    final progress = ref.watch(scrollProgressProvider);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _showControls ? 0 : -8,
      left: 0,
      right: 0,
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
            ],
            stops: [progress, progress],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentSection() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < kMobileBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Comments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                '${sampleComments.length} comments',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // New Comment Input Section
          Container(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[850] : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey[500],
                      ),
                      filled: true,
                      fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          // Handle send comment
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Comments List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sampleComments.length,
            itemBuilder: (context, index) {
              final comment = sampleComments[index];
              return Column(
                children: [
                  _buildCommentItem(comment),
                  if (comment.replies != null)
                    Padding(
                      padding: EdgeInsets.only(left: isMobile ? 32 : 48),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: comment.replies!.length,
                        itemBuilder: (context, replyIndex) {
                          return _buildCommentItem(
                            comment.replies![replyIndex],
                            isReply: true,
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Comment comment, {bool isReply = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(comment.authorImageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.authorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo(comment.createdAt),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  comment.content,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle like
                      },
                      child: Row(
                        children: [
                          Icon(
                            comment.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 16,
                            color:
                                comment.isLiked ? Colors.red : Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${comment.likesCount}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (!isReply)
                      TextButton(
                        onPressed: () {
                          // Handle reply
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                        ),
                        child: Text(
                          'Reply',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedAndMoreSection() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < kMobileBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Related Articles section
          Text(
            'Related Articles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: 300,
                  margin: EdgeInsets.only(
                    right: 16,
                    left: index == 0 ? 0 : 0,
                  ),
                  child: _buildArticleCard(
                    'The Evolution of JavaScript Frameworks',
                    'Exploring the past, present, and future of web development frameworks',
                    'https://images.unsplash.com/photo-1461749280684-dccba630e2f6',
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),

          // More from Author section
          Text(
            'More from Author',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: 300,
                  margin: EdgeInsets.only(
                    right: 16,
                    left: index == 0 ? 0 : 0,
                  ),
                  child: _buildArticleCard(
                    'Building Scalable Web Applications',
                    'Best practices for creating maintainable and scalable web apps',
                    'https://images.unsplash.com/photo-1498050108023-c5249f4df085',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(String title, String subtitle, String imageUrl) {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;

    return InkWell(
      onTap: () {
        // Navigate to article
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String timeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }

  void _scrollToSection(int position) {
    // Find the TOC item by position
    final tocItem = widget.article.tableOfContents.firstWhere(
      (item) => item.position == position,
      orElse: () => widget.article.tableOfContents.first,
    );

    if (_sectionKeys.containsKey(tocItem.id)) {
      final context = _sectionKeys[tocItem.id]?.currentContext;
      if (context != null) {
        // Disable scroll listener temporarily to prevent unwanted active section updates
        _scrollController.removeListener(_updateActiveSection);

        // Update active section immediately before scrolling
        ref.read(activeTableOfContentsItemProvider.notifier).state = tocItem.id;

        // Get the RenderBox of the section
        final RenderBox box = context.findRenderObject() as RenderBox;
        final sectionPosition = box.localToGlobal(Offset.zero);
        final scrollMetrics = _scrollController.position;

        // Calculate the target scroll offset
        final targetOffset = scrollMetrics.pixels +
            sectionPosition.dy -
            MediaQuery.of(context).padding.top -
            100; // 100px offset from top

        // Scroll to the section
        _scrollController
            .animateTo(
          targetOffset.clamp(
            scrollMetrics.minScrollExtent,
            scrollMetrics.maxScrollExtent,
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
            .then((_) {
          // Re-enable scroll listener after animation completes
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              _scrollController.addListener(_updateActiveSection);
            }
          });
        });
      }
    }
  }

  void _updateActiveSection() {
    if (widget.article.tableOfContents.isEmpty) return;

    // Get all section elements and their positions
    Map<String, double> sectionPositions = {};
    double viewportTop = _scrollController.offset + 120;
    double viewportBottom = viewportTop + MediaQuery.of(context).size.height;

    // Collect all visible sections
    for (var item in widget.article.tableOfContents) {
      final context = _sectionKeys[item.id]?.currentContext;
      if (context != null) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy -
            MediaQuery.of(context).padding.top;
        final sectionTop = position + _scrollController.offset;

        // Only consider sections that are in or near the viewport
        if (sectionTop >= viewportTop - 200 &&
            sectionTop <= viewportBottom + 200) {
          sectionPositions[item.id] = sectionTop;
        }
      }
    }

    if (sectionPositions.isEmpty) return;

    // Find the section closest to the viewport top
    String? activeId;
    double? smallestDistance = null;

    sectionPositions.forEach((id, position) {
      final distance = (position - viewportTop).abs();
      if (smallestDistance == null || distance < smallestDistance!) {
        smallestDistance = distance;
        activeId = id;
      }
    });

    // Only update if we have a new active section and not currently scrolling programmatically
    if (activeId != null &&
        activeId != ref.read(activeTableOfContentsItemProvider) &&
        !_scrollController.position.isScrollingNotifier.value) {
      ref.read(activeTableOfContentsItemProvider.notifier).state = activeId;
    }
  }

  Widget _buildArticleFooter() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < kMobileBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About the Author section
          Text(
            'About the Author',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[850] : Colors.white,
              border: Border.all(
                color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isMobile) ...[
                  // Mobile layout
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage:
                            NetworkImage(widget.article.author.profileImage),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          widget.article.author.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '@${widget.article.author.username}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildAuthorStat(
                              icon: Icons.article_outlined,
                              label: '125 Articles',
                              isDarkMode: isDarkMode,
                            ),
                            const SizedBox(width: 24),
                            _buildAuthorStat(
                              icon: Icons.favorite_outline,
                              label: '48.5K Likes',
                              isDarkMode: isDarkMode,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tech enthusiast and software engineer passionate about web development and modern technologies.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: isDarkMode ? Colors.white70 : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Handle follow action
                          },
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Follow'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context
                              .go('/profile/${widget.article.author.username}'),
                          icon: const Icon(Icons.person_outline, size: 18),
                          label: const Text('View Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  // Desktop layout
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(widget.article.author.profileImage),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.article.author.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '@${widget.article.author.username}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _buildAuthorStat(
                                  icon: Icons.article_outlined,
                                  label: '125 Articles',
                                  isDarkMode: isDarkMode,
                                ),
                                const SizedBox(width: 24),
                                _buildAuthorStat(
                                  icon: Icons.favorite_outline,
                                  label: '48.5K Likes',
                                  isDarkMode: isDarkMode,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDarkMode
                              ? Colors.grey[800]!
                              : Colors.grey[200]!,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tech enthusiast and software engineer passionate about web development and modern technologies.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color:
                                isDarkMode ? Colors.white70 : Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                // Handle follow action
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Follow'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(context).primaryColor,
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: () => context.go(
                                  '/profile/${widget.article.author.username}'),
                              icon: const Icon(Icons.person_outline),
                              label: const Text('View Profile'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Next Article section
          Text(
            'Next Article',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              // Navigate to next article
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1461749280684-dccba630e2f6',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '10 Must-Know JavaScript Features for 2025',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Coming up next in our series about modern web development...',
                    style: TextStyle(
                      fontSize: 15,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorStat({
    required IconData icon,
    required String label,
    required bool isDarkMode,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDarkMode ? Colors.white70 : Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.white70 : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper method for common text styles
  TextStyle _getTextStyle({
    required bool isDarkMode,
    double fontSize = 14,
    FontWeight weight = FontWeight.normal,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: weight,
      height: height,
      color: isDarkMode ? Colors.white70 : Colors.black87,
    );
  }

  // Helper method for common container decorations
  BoxDecoration _getContainerDecoration({
    required bool isDarkMode,
    bool isActive = false,
    double radius = kDefaultRadius,
  }) {
    return BoxDecoration(
      color: isActive
          ? Theme.of(context).primaryColor.withOpacity(0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: isActive
            ? Theme.of(context).primaryColor.withOpacity(0.2)
            : Colors.transparent,
      ),
    );
  }

  // Helper method for common padding
  EdgeInsets _getDefaultPadding(
      {double horizontal = kDefaultSpacing,
      double vertical = kDefaultSpacing}) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  Widget _buildExpandableSettingsFab() {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;
    final backgroundColor = isDarkMode
        ? Colors.grey[850]!.withOpacity(0.9)
        : Colors.white.withOpacity(0.9);
    final iconColor = isDarkMode ? Colors.white : Colors.black87;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Font Size Option
        AnimatedSizeAndFade(
          child: _isSettingsFabOpen
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FloatingActionButton.small(
                    heroTag: 'fontSize',
                    backgroundColor: backgroundColor,
                    elevation: 2,
                    onPressed: _showFontSizeDialog,
                    child: Icon(
                      Icons.format_size,
                      color: iconColor,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        // Dark Mode Option
        AnimatedSizeAndFade(
          child: _isSettingsFabOpen
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FloatingActionButton.small(
                    heroTag: 'darkMode',
                    backgroundColor: backgroundColor,
                    elevation: 2,
                    onPressed: () {
                      ref.read(themeProvider.notifier).state =
                          isDarkMode ? ReadingTheme.light : ReadingTheme.dark;
                    },
                    child: Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: iconColor,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        // Main Settings FAB
        FloatingActionButton.small(
          heroTag: 'settings',
          backgroundColor: backgroundColor,
          elevation: 2,
          onPressed: () {
            setState(() {
              _isSettingsFabOpen = !_isSettingsFabOpen;
            });
          },
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 300),
            turns: _isSettingsFabOpen ? 0.125 : 0,
            child: Icon(
              Icons.settings,
              color: iconColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppHeader(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Loading article...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppHeader(),
        body: ErrorView(
          message: _error,
          onRetry: _loadArticleData,
        ),
      );
    }

    final theme = ref.watch(themeProvider);
    final isDarkMode = theme == ReadingTheme.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < kMobileBreakpoint;
    final isTablet =
        screenWidth >= kMobileBreakpoint && screenWidth < kTabletBreakpoint;
    final isDesktop = screenWidth >= kTabletBreakpoint;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) _buildModernTableOfContents(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      _buildCoverImage(),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: isMobile
                              ? double.infinity
                              : isTablet
                                  ? 700
                                  : 800,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: isMobile
                              ? 16
                              : isTablet
                                  ? 32
                                  : 48,
                        ),
                        child: Column(
                          children: [
                            _buildArticleHeader(),
                            _buildArticleContent(),
                            _buildArticleFooter(),
                            _buildCommentSection(),
                            _buildRelatedAndMoreSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (!isMobile)
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height * 0.3,
              child: _buildModernReadingControls(),
            ),
          _buildFloatingProgressBar(),
          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: FloatingActionButton.small(
              heroTag: 'back',
              backgroundColor: isDarkMode
                  ? Colors.grey[850]!.withOpacity(0.9)
                  : Colors.white.withOpacity(0.9),
              elevation: 2,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
              child: Icon(
                Icons.arrow_back,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),
          // Mobile controls
          if (isMobile)
            Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.small(
                    heroTag: 'toc',
                    backgroundColor: isDarkMode
                        ? Colors.grey[850]!.withOpacity(0.9)
                        : Colors.white.withOpacity(0.9),
                    elevation: 2,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[900] : Colors.white,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Table of Contents',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: isDarkMode
                                            ? Colors.white70
                                            : Colors.black54,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  itemCount:
                                      widget.article.tableOfContents.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        widget.article.tableOfContents[index];
                                    final isActive = ref.watch(
                                            activeTableOfContentsItemProvider) ==
                                        item.id;

                                    return InkWell(
                                      onTap: () {
                                        _scrollToSection(item.position);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 16.0 + (item.level - 1) * 20.0,
                                          right: 16.0,
                                          top: 12.0,
                                          bottom: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.1)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 3,
                                              height: 16,
                                              margin: const EdgeInsets.only(
                                                  right: 12),
                                              decoration: BoxDecoration(
                                                color: isActive
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                item.title,
                                                style: TextStyle(
                                                  fontSize:
                                                      16 - (item.level - 1),
                                                  color: isActive
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : (isDarkMode
                                                          ? Colors.white70
                                                          : Colors.black87),
                                                  fontWeight: isActive ||
                                                          item.level == 1
                                                      ? FontWeight.w600
                                                      : FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.list,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableSettingsFab(),
                ],
              ),
            ),
          if (_error != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ErrorBanner(
                message: _error,
                onDismiss: () => setState(() => _error = null),
              ),
            ),
        ],
      ),
    );
  }
}

class AnimatedSizeAndFade extends StatelessWidget {
  final Widget child;

  const AnimatedSizeAndFade({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}
