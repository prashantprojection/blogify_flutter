import 'package:flutter/material.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/inputs/search_box.dart';
import 'package:blogify_flutter/widgets/common/chips/filter_chip.dart';

class FilterSection extends StatelessWidget {
  final String? title;
  final String searchHint;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final List<String> categories;
  final List<String> selectedCategories;
  final ValueChanged<String>? onCategorySelected;
  final List<String>? sortOptions;
  final String? selectedSortOption;
  final ValueChanged<String>? onSortOptionSelected;
  final EdgeInsetsGeometry? padding;
  final Widget? trailing;

  const FilterSection({
    Key? key,
    this.title,
    this.searchHint = 'Search...',
    this.searchController,
    this.onSearchChanged,
    required this.categories,
    required this.selectedCategories,
    this.onCategorySelected,
    this.sortOptions,
    this.selectedSortOption,
    this.onSortOptionSelected,
    this.padding,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                title!,
                style: AppTheme.headingSmall,
              ),
            ),
          SearchBox(
            hintText: searchHint,
            controller: searchController,
            onChanged: onSearchChanged,
          ),
          SizedBox(height: 24),
          Text(
            'Categories',
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              return CustomFilterChip.category(
                label: category,
                isSelected: selectedCategories.contains(category),
                onTap: () => onCategorySelected?.call(category),
              );
            }).toList(),
          ),
          if (sortOptions != null && sortOptions!.isNotEmpty) ...[
            SizedBox(height: 24),
            Text(
              'Sort By',
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: sortOptions!.map((option) {
                return CustomFilterChip.sort(
                  label: option,
                  isSelected: option == selectedSortOption,
                  onTap: () => onSortOptionSelected?.call(option),
                );
              }).toList(),
            ),
          ],
          if (trailing != null) ...[
            SizedBox(height: 24),
            trailing!,
          ],
        ],
      ),
    );
  }

  // Factory constructor for simple filter section
  factory FilterSection.simple({
    required String searchHint,
    required List<String> categories,
    required List<String> selectedCategories,
    ValueChanged<String>? onSearchChanged,
    ValueChanged<String>? onCategorySelected,
    EdgeInsetsGeometry? padding,
  }) {
    return FilterSection(
      searchHint: searchHint,
      onSearchChanged: onSearchChanged,
      categories: categories,
      selectedCategories: selectedCategories,
      onCategorySelected: onCategorySelected,
      padding: padding,
    );
  }
}
