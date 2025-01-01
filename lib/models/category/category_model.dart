import 'package:flutter/material.dart';

class CategoryData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String blogCount;

  CategoryData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.blogCount,
  });
}

final List<CategoryData> featuredCategories = [
  CategoryData(
    title: 'Programming',
    description: 'Explore coding tutorials and tech insights',
    icon: Icons.code,
    color: Colors.blue,
    blogCount: '2.5k blogs',
  ),
  CategoryData(
    title: 'Design',
    description: 'Creative insights and design resources',
    icon: Icons.palette,
    color: Colors.purple,
    blogCount: '1.9k blogs',
  ),
  CategoryData(
    title: 'Business',
    description: 'Business strategies and success stories',
    icon: Icons.trending_up,
    color: Colors.green,
    blogCount: '3.2k blogs',
  ),
];

final List<CategoryData> allCategories = [
  CategoryData(
    title: 'Photography',
    description: 'Tips and techniques for photographers',
    icon: Icons.camera_alt,
    color: Colors.orange,
    blogCount: '1.2k blogs',
  ),
  CategoryData(
    title: 'Writing',
    description: 'Improve your writing skills and storytelling',
    icon: Icons.edit_note,
    color: Colors.blue,
    blogCount: '2.1k blogs',
  ),
  CategoryData(
    title: 'Marketing',
    description: 'Digital marketing strategies and trends',
    icon: Icons.trending_up,
    color: Colors.green,
    blogCount: '1.8k blogs',
  ),
];

final List<Map<String, dynamic>> relatedCategories = [
  {
    'label': 'Web Development',
    'icon': Icons.web,
  },
  {
    'label': 'Mobile Apps',
    'icon': Icons.phone_android,
  },
  {
    'label': 'Artificial Intelligence',
    'icon': Icons.psychology,
  },
];

final List<String> footerCategories = [
  'Technology',
  'Design',
  'Business',
  'Lifestyle',
  'Health',
];
