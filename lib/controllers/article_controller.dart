import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/models/article.dart';

// State providers for article view
final fontSizeProvider = StateProvider<double>((ref) => 18.0);
final lineHeightProvider = StateProvider<double>((ref) => 1.8);
final themeProvider = StateProvider<ReadingTheme>((ref) => ReadingTheme.light);
final scrollProgressProvider = StateProvider<double>((ref) => 0.0);
final isExpandedProvider = StateProvider<bool>((ref) => false);
final showControlsProvider = StateProvider<bool>((ref) => true);
final isBookmarkedProvider = StateProvider<bool>((ref) => false);

enum ReadingTheme { light, dark, sepia }

final sampleArticlesProvider = Provider<List<Article>>((ref) {
  return [
    Article(
      id: '1',
      title: 'The Future of Web Development',
      subtitle: 'Exploring trends and technologies shaping the web',
      content: '''
# The Future of Web Development

The landscape of web development is constantly evolving, bringing new challenges and opportunities for developers. In this article, we'll explore the latest trends and technologies that are shaping the future of web development.

## Modern JavaScript Frameworks

Modern JavaScript frameworks have revolutionized how we build web applications. React, Vue, and Angular continue to dominate the frontend landscape, each bringing its own unique advantages to the table.

### React's Continued Evolution

React has maintained its position as the most popular frontend framework, with new features like Server Components and Suspense changing how we think about component architecture.

## The Rise of Edge Computing

Edge computing is becoming increasingly important in web development, offering new ways to optimize performance and user experience.

### Benefits of Edge Computing

1. Reduced latency
2. Improved performance
3. Better user experience
4. Cost efficiency

## Web Assembly and the Future

WebAssembly is opening new possibilities for web applications, allowing developers to write high-performance code in languages like Rust and C++.

## Conclusion

The future of web development is exciting, with new technologies and approaches emerging regularly. Staying updated with these trends is crucial for modern web developers.
''',
      coverImage:
          'https://images.unsplash.com/photo-1461749280684-dccba630e2f6',
      author: Author(
        id: '1',
        name: 'Sarah Johnson',
        username: 'sarahj',
        profileImage:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
        bio: 'Senior Web Developer | Tech Writer | Speaker',
      ),
      publishedAt: DateTime.now().subtract(const Duration(days: 2)),
      tags: ['Web Development', 'JavaScript', 'Technology'],
      tableOfContents: [
        TableOfContentsItem(
          id: 'intro',
          title: 'The Future of Web Development',
          level: 1,
          position: 0,
        ),
        TableOfContentsItem(
          id: 'frameworks',
          title: 'Modern JavaScript Frameworks',
          level: 2,
          position: 300,
        ),
        TableOfContentsItem(
          id: 'react',
          title: 'React\'s Continued Evolution',
          level: 3,
          position: 500,
        ),
        TableOfContentsItem(
          id: 'edge',
          title: 'The Rise of Edge Computing',
          level: 2,
          position: 800,
        ),
        TableOfContentsItem(
          id: 'edge-benefits',
          title: 'Benefits of Edge Computing',
          level: 3,
          position: 1000,
        ),
        TableOfContentsItem(
          id: 'wasm',
          title: 'Web Assembly and the Future',
          level: 2,
          position: 1300,
        ),
        TableOfContentsItem(
          id: 'conclusion',
          title: 'Conclusion',
          level: 2,
          position: 1600,
        ),
      ],
    ),
    Article(
      id: '2',
      title: 'Building Scalable Applications',
      subtitle:
          'Best practices for creating maintainable and scalable applications',
      content: '''
# Building Scalable Applications

Creating scalable applications requires careful planning and implementation. Let's explore the key principles and practices that help ensure your applications can grow effectively.

## Architecture Patterns

Understanding and implementing the right architecture patterns is crucial for scalability. We'll explore some popular patterns and their use cases.

### Microservices Architecture

Microservices have become increasingly popular for building scalable applications. Let's look at why and how to implement them effectively.

## Database Optimization

Proper database design and optimization are critical for application scalability.

### Indexing Strategies

Learn about effective indexing strategies to improve database performance.

## Caching Mechanisms

Implementing effective caching strategies can significantly improve application performance.

## Conclusion

Building scalable applications is an ongoing process that requires attention to various aspects of software development.
''',
      coverImage:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085',
      author: Author(
        id: '2',
        name: 'David Chen',
        username: 'davidc',
        profileImage:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
        bio: 'Software Architect | Cloud Expert',
      ),
      publishedAt: DateTime.now().subtract(const Duration(days: 5)),
      tags: ['Architecture', 'Scalability', 'Best Practices'],
      tableOfContents: [
        TableOfContentsItem(
          id: 'intro',
          title: 'Building Scalable Applications',
          level: 1,
          position: 0,
        ),
        TableOfContentsItem(
          id: 'architecture',
          title: 'Architecture Patterns',
          level: 2,
          position: 300,
        ),
        TableOfContentsItem(
          id: 'microservices',
          title: 'Microservices Architecture',
          level: 3,
          position: 500,
        ),
        TableOfContentsItem(
          id: 'database',
          title: 'Database Optimization',
          level: 2,
          position: 800,
        ),
        TableOfContentsItem(
          id: 'indexing',
          title: 'Indexing Strategies',
          level: 3,
          position: 1000,
        ),
        TableOfContentsItem(
          id: 'caching',
          title: 'Caching Mechanisms',
          level: 2,
          position: 1300,
        ),
        TableOfContentsItem(
          id: 'conclusion',
          title: 'Conclusion',
          level: 2,
          position: 1600,
        ),
      ],
    ),
  ];
});
