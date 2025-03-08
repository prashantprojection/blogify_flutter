import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blogify_flutter/constants/app_strings.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final bool showRetry;
  final IconData? icon;

  const ErrorView({
    Key? key,
    this.message,
    this.onRetry,
    this.showRetry = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 8),
            Text(
              message ?? AppStrings.generalError,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (showRetry && onRetry != null) ...[
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(AppStrings.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyStateView extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyStateView({
    Key? key,
    this.message,
    this.icon,
    this.onAction,
    this.actionLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(height: 8),
            Text(
              message ?? AppStrings.noContent,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onAction != null && actionLabel != null) ...[
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorBanner extends StatelessWidget {
  final String? message;
  final VoidCallback? onDismiss;

  const ErrorBanner({
    Key? key,
    this.message,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.error,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  message ?? AppStrings.generalError,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              if (onDismiss != null)
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: onDismiss,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object, StackTrace?)? error;
  final Widget Function()? loading;

  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
    this.error,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () =>
          loading?.call() ??
          const Center(
            child: CircularProgressIndicator(),
          ),
      error: (e, st) =>
          error?.call(e, st) ??
          ErrorView(
            message: e.toString(),
          ),
    );
  }
}
