import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/models/article.dart';

class NavigationHelper {
  static void navigateToArticle(BuildContext context, Article article) {
    context.go('/article/${article.id}');
  }

  static void navigateToProfile(BuildContext context, String username) {
    context.go('/profile/$username');
  }

  static void navigateToPublicProfile(BuildContext context, String username) {
    context.go('/profile/$username');
  }

  static void navigateToHome(BuildContext context) {
    context.go('/');
  }

  static void navigateToExplore(BuildContext context) {
    context.go('/explore');
  }

  static void navigateToCategories(BuildContext context) {
    context.go('/categories');
  }

  static void navigateToStories(BuildContext context) {
    context.go('/stories');
  }

  static void navigateToCommunity(BuildContext context) {
    context.go('/community');
  }

  static void navigateToSettings(BuildContext context) {
    context.go('/settings');
  }
}
