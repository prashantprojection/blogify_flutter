import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/routes/app_router.dart';
import 'package:blogify_flutter/controllers/theme_controller.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'Blogify',
      theme: theme.toThemeData(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
