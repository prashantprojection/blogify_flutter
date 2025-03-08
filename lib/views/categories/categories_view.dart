import 'package:blogify_flutter/views/categories/categories_temp_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/widgets/common/app_header.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';

final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final hoveredCategoryProvider = StateProvider<String?>((ref) => null);

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  final searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth > 600 ? screenWidth * 0.85 : screenWidth;
    final cardWidth = (contentWidth - 128) / 4;
    final theme = ref.watch(themeProvider);

    return Scaffold(
        backgroundColor: theme.colors.background,
        appBar: AppHeader(),
        body: SingleChildScrollView(
            child: Column(children: [
          // Header Section with white background
          Container(
              width: double.infinity,
              color: theme.colors.surface,
              child: Center(
                  child: Container(
                      width: contentWidth,
                      padding: EdgeInsets.all(32),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Explore Categories',
                                style: theme.typography.headline.copyWith(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            Text(
                                'Discover topics that inspire you to share and learn',
                                style: theme.typography.body.copyWith(
                                    color: theme.colors.onSurfaceVariant))
                          ])))),
          // Search and Filter Section with white background
          Container(
              width: double.infinity,
              color: theme.colors.surface,
              child: Center(
                  child: Container(
                      width: contentWidth,
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: theme.colors.surface,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: theme.colors.outline, width: 0.3),
                                ),
                                child: TextField(
                                    controller: searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        searchQuery = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Search for categories...',
                                        fillColor: theme.colors.surface,
                                        focusColor: theme.colors.surface,
                                        filled: true,
                                        hoverColor: theme.colors.surface,
                                        prefixIcon: Icon(Icons.search,
                                            color:
                                                theme.colors.onSurfaceVariant),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16))))),
                        SizedBox(width: 16),
                        _buildFilterChip('🔥 Trending', Colors.blue),
                        SizedBox(width: 8),
                        _buildFilterChip('🆕 New', Colors.green),
                        SizedBox(width: 8),
                        _buildFilterChip('⭐ Editor\'s Choice', Colors.purple)
                      ])))),
          // Main Content
          Center(
              child: Container(
                  width: contentWidth,
                  padding: EdgeInsets.all(32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Featured Categories Section
                        Text('Featured Categories',
                            style: theme.typography.headline.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: featuredCategories.map((category) {
                              return SizedBox(
                                  width: cardWidth,
                                  child: _buildCategoryCard(
                                      title: category['title'] as String,
                                      icon: category['icon'] as IconData,
                                      color: category['color'] as Color,
                                      blogs: category['blogs'] as String,
                                      description:
                                          category['description'] as String));
                            }).toList()),
                        SizedBox(height: 48),

                        // All Categories Section
                        Text('All Categories',
                            style: theme.typography.headline.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: allCategories.map((category) {
                              if (searchQuery.isNotEmpty &&
                                  !category['title']
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase())) {
                                return SizedBox.shrink();
                              }
                              return SizedBox(
                                  width: cardWidth,
                                  child: _buildCategoryCard(
                                      title: category['title'] as String,
                                      icon: category['icon'] as IconData,
                                      color: category['color'] as Color,
                                      blogs: category['blogs'] as String,
                                      description:
                                          category['description'] as String));
                            }).toList()),
                        SizedBox(height: 48),

                        // CTA Section
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 48, horizontal: 24),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      theme.colors.primary,
                                      theme.colors.secondary
                                    ]),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t see your favorite topic?',
                                      style: theme.typography.headline.copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colors.onPrimary)),
                                  SizedBox(height: 8),
                                  Text('Create a new category!',
                                      style: theme.typography.body.copyWith(
                                          fontSize: 16,
                                          color: theme.colors.onPrimary
                                              .withOpacity(0.9))),
                                  SizedBox(height: 24),
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: theme.colors.surface,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: theme.colors.shadow
                                                        .withOpacity(0.1),
                                                    blurRadius: 10,
                                                    spreadRadius: 0,
                                                    offset: Offset(0, 4))
                                              ]),
                                          child: TextButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.add,
                                                  color: theme.colors.primary),
                                              label: Text('Suggest a Category',
                                                  style: theme.typography.button
                                                      .copyWith(
                                                          color: theme
                                                              .colors.primary,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 16,
                                                  ),
                                                  backgroundColor:
                                                      theme.colors.surface))))
                                ]))
                      ]))),
          // Footer Section
          Container(
              width: double.infinity,
              color: theme.colors.surface,
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(
                  child: Column(children: [
                Text('Find Your Passion with Blogify',
                    style: theme.typography.headline.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colors.onSurface)),
                SizedBox(height: 16),
                Wrap(
                    spacing: 24,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      'Technology',
                      'Design',
                      'Business',
                      'Lifestyle',
                      'Health'
                    ]
                        .map((category) => TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            child: Text(category,
                                style: theme.typography.body.copyWith(
                                    color: theme.colors.onSurfaceVariant))))
                        .toList())
              ])))
        ])));
  }

  Widget _buildFilterChip(String label, Color color) {
    final theme = ref.watch(themeProvider);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Text(label,
            style: theme.typography.body.copyWith(
                fontSize: 14, color: color, fontWeight: FontWeight.w500)));
  }

  Widget _buildCategoryCard(
      {required String title,
      required IconData icon,
      required Color color,
      required String blogs,
      required String description}) {
    return Consumer(
      builder: (context, ref, child) {
        final theme = ref.watch(themeProvider);
        final isHovered = ref.watch(hoveredCategoryProvider) == title;
        return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 200),
                tween: Tween<double>(begin: 1, end: isHovered ? 1.02 : 1),
                builder: (context, double scale, child) {
                  return Transform.scale(
                      scale: scale,
                      child: Transform.translate(
                          offset: Offset(0, isHovered ? -4 : 0),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              decoration: BoxDecoration(
                                  color: theme.colors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: theme.colors.shadow,
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                        offset: Offset(0, 4)),
                                    BoxShadow(
                                        color: theme.colors.shadow,
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                        offset: Offset(0, 2)),
                                    if (isHovered)
                                      BoxShadow(
                                          color: color.withOpacity(0.3),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                          offset: Offset(0, -4))
                                  ]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            boxShadow: isHovered
                                                ? [
                                                    BoxShadow(
                                                        color: color
                                                            .withOpacity(0.3),
                                                        blurRadius: 12,
                                                        spreadRadius: 2)
                                                  ]
                                                : []),
                                        child:
                                            Icon(icon, color: color, size: 42)),
                                    SizedBox(height: 12),
                                    Text(title,
                                        style: theme.typography.headline
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: isHovered
                                                    ? color
                                                    : theme.colors.onSurface)),
                                    SizedBox(height: 6),
                                    Text(description,
                                        style: theme.typography.body.copyWith(
                                            fontSize: 13,
                                            color:
                                                theme.colors.onSurfaceVariant),
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(height: 12),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 3),
                                              decoration: BoxDecoration(
                                                  color: color.withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: isHovered
                                                      ? [
                                                          BoxShadow(
                                                              color: color
                                                                  .withOpacity(
                                                                      0.2),
                                                              blurRadius: 8,
                                                              spreadRadius: 1)
                                                        ]
                                                      : []),
                                              child: Text(blogs,
                                                  style: theme.typography.body
                                                      .copyWith(
                                                          color: color,
                                                          fontSize: 11,
                                                          fontWeight: FontWeight
                                                              .w500))),
                                          TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize: Size(50, 30),
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap),
                                              child: Text('Explore →',
                                                  style: theme.typography.label
                                                      .copyWith(
                                                          color: color,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500)))
                                        ])
                                  ]))));
                }),
            onEnter: (_) =>
                ref.read(hoveredCategoryProvider.notifier).state = title,
            onExit: (_) =>
                ref.read(hoveredCategoryProvider.notifier).state = null);
      },
    );
  }
}
