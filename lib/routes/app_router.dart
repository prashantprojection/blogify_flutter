import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/views/home/home_view.dart';
import 'package:blogify_flutter/views/categories/categories_view.dart';
import 'package:blogify_flutter/views/explore/explore_view.dart';
import 'package:blogify_flutter/views/stories/stories_view.dart';
import 'package:blogify_flutter/views/community/community_forum_view.dart';
import 'package:blogify_flutter/views/settings/settings_view.dart';
import 'package:blogify_flutter/views/article/article_view.dart';
import 'package:blogify_flutter/views/profile/profile_view.dart';
import 'package:blogify_flutter/controllers/article_controller.dart';
import 'package:blogify_flutter/views/profile/public_profile_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesView(),
      ),
      GoRoute(
        path: '/explore',
        builder: (context, state) => const ExploreView(),
      ),
      GoRoute(
        path: '/stories',
        builder: (context, state) => const StoriesView(),
      ),
      GoRoute(
        path: '/community',
        builder: (context, state) => const CommunityForumView(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/article/:id',
        builder: (context, state) {
          final articleId = state.pathParameters['id'];
          final articles = ref.read(sampleArticlesProvider);
          final article = articles.firstWhere(
            (article) => article.id == articleId,
            orElse: () => articles.first,
          );
          return ArticleView(article: article);
        },
      ),
      GoRoute(
        path: '/profile/:username',
        builder: (context, state) => PublicProfileView(
          username: state.pathParameters['username']!,
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
});

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
