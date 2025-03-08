import 'package:flutter/material.dart';

class WebStory {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color badgeColor;

  const WebStory({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.badgeColor,
  });
}

class Category {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const Category({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class Author {
  final String name;
  final String imageUrl;
  final String bio;
  final int followers;
  final int articles;
  final String specialty;

  const Author({
    required this.name,
    required this.imageUrl,
    required this.bio,
    required this.followers,
    required this.articles,
    required this.specialty,
  });
}

class Channel {
  final String name;
  final String imageUrl;
  final String description;
  final int subscribers;
  final Color color;

  const Channel({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.subscribers,
    required this.color,
  });
}

class TrendingTopic {
  final String name;
  final int articles;
  final IconData icon;
  final Color color;

  const TrendingTopic({
    required this.name,
    required this.articles,
    required this.icon,
    required this.color,
  });
}

final List<WebStory> webStories = [
  WebStory(
    title: 'Tech Trends 2024',
    subtitle: 'Technology',
    imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
    badgeColor: Color(0xFF3B82F6),
  ),
  WebStory(
    title: 'Sustainable Living',
    subtitle: 'Lifestyle',
    imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09',
    badgeColor: Color(0xFF17B26A),
  ),
  WebStory(
    title: 'Future of AI',
    subtitle: 'Technology',
    imageUrl: 'https://images.unsplash.com/photo-1677442136019-21780ecad995',
    badgeColor: Color(0xFF3B82F6),
  ),
  WebStory(
    title: 'Mental Health',
    subtitle: 'Health',
    imageUrl: 'https://images.unsplash.com/photo-1505455184862-554165e5f6ba',
    badgeColor: Color(0xFFEF4444),
  ),
  WebStory(
    title: 'Financial Tips',
    subtitle: 'Finance',
    imageUrl: 'https://images.unsplash.com/photo-1579621970795-87facc2f976d',
    badgeColor: Color(0xFFF59E0B),
  ),
  WebStory(
    title: 'Travel Stories',
    subtitle: 'Travel',
    imageUrl: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800',
    badgeColor: Color(0xFF8B5CF6),
  ),
  WebStory(
    title: 'Food Culture',
    subtitle: 'Food',
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
    badgeColor: Color(0xFFEF4444),
  ),
  WebStory(
    title: 'Art & Design',
    subtitle: 'Art',
    imageUrl: 'https://images.unsplash.com/photo-1513364776144-60967b0f800f',
    badgeColor: Color(0xFFEC4899),
  ),
];

final List<Category> categories = [
  Category(
    icon: Icons.flight,
    title: 'Travel',
    description: 'Discover amazing destinations and travel tips',
    color: Color(0xFF3B82F6),
  ),
  Category(
    icon: Icons.memory,
    title: 'Technology',
    description: 'Stay ahead with the latest in tech',
    color: Color(0xFF8B5CF6),
  ),
  Category(
    icon: Icons.favorite,
    title: 'Lifestyle',
    description: 'Tips for living your best life',
    color: Color(0xFFEC4899),
  ),
  Category(
    icon: Icons.restaurant_menu,
    title: 'Food',
    description: 'Explore culinary adventures and recipes',
    color: Color(0xFF10B981),
  ),
];

final List<Author> topAuthors = [
  Author(
    name: 'Sarah Johnson',
    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    bio: 'Tech enthusiast & AI researcher',
    followers: 15200,
    articles: 48,
    specialty: 'Technology',
  ),
  Author(
    name: 'David Chen',
    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
    bio: 'Travel photographer & writer',
    followers: 12800,
    articles: 36,
    specialty: 'Travel',
  ),
  Author(
    name: 'Emma Wilson',
    imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
    bio: 'Food critic & recipe developer',
    followers: 9500,
    articles: 42,
    specialty: 'Food',
  ),
  Author(
    name: 'Michael Brown',
    imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
    bio: 'Finance expert & investor',
    followers: 8900,
    articles: 31,
    specialty: 'Finance',
  ),
];

final List<Channel> popularChannels = [
  Channel(
    name: 'Tech Insider',
    imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475',
    description: 'Latest in technology and innovation',
    subscribers: 25600,
    color: Color(0xFF3B82F6),
  ),
  Channel(
    name: 'Wanderlust',
    imageUrl: 'https://images.unsplash.com/photo-1488646953014-85cb44e25828',
    description: 'Travel stories and adventures',
    subscribers: 18900,
    color: Color(0xFF8B5CF6),
  ),
  Channel(
    name: 'Food & Culture',
    imageUrl: 'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f',
    description: 'Exploring food from around the world',
    subscribers: 15400,
    color: Color(0xFFEF4444),
  ),
  Channel(
    name: 'Mindful Living',
    imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
    description: 'Wellness and lifestyle tips',
    subscribers: 12700,
    color: Color(0xFF10B981),
  ),
];

final List<TrendingTopic> trendingTopics = [
  TrendingTopic(
    name: 'Artificial Intelligence',
    articles: 156,
    icon: Icons.psychology,
    color: Color(0xFF3B82F6),
  ),
  TrendingTopic(
    name: 'Sustainable Living',
    articles: 98,
    icon: Icons.eco,
    color: Color(0xFF10B981),
  ),
  TrendingTopic(
    name: 'Digital Marketing',
    articles: 87,
    icon: Icons.trending_up,
    color: Color(0xFFF59E0B),
  ),
  TrendingTopic(
    name: 'Mental Health',
    articles: 76,
    icon: Icons.favorite_border,
    color: Color(0xFFEC4899),
  ),
];
