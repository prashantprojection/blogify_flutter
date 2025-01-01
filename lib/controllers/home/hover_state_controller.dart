import 'package:flutter_riverpod/flutter_riverpod.dart';

// State class for hover states
class HoverStates {
  final Map<String, bool> featuredStoryHoverStates;
  final Map<String, bool> webStoryHoverStates;
  final Map<String, bool> categoryHoverStates;
  final Map<String, bool> authorHoverStates;
  final Map<String, bool> channelHoverStates;
  final Map<String, bool> trendingTopicHoverStates;
  final bool isBlogOfDayHovered;

  HoverStates({
    required this.featuredStoryHoverStates,
    required this.webStoryHoverStates,
    required this.categoryHoverStates,
    required this.authorHoverStates,
    required this.channelHoverStates,
    required this.trendingTopicHoverStates,
    required this.isBlogOfDayHovered,
  });

  HoverStates copyWith({
    Map<String, bool>? featuredStoryHoverStates,
    Map<String, bool>? webStoryHoverStates,
    Map<String, bool>? categoryHoverStates,
    Map<String, bool>? authorHoverStates,
    Map<String, bool>? channelHoverStates,
    Map<String, bool>? trendingTopicHoverStates,
    bool? isBlogOfDayHovered,
  }) {
    return HoverStates(
      featuredStoryHoverStates:
          featuredStoryHoverStates ?? this.featuredStoryHoverStates,
      webStoryHoverStates: webStoryHoverStates ?? this.webStoryHoverStates,
      categoryHoverStates: categoryHoverStates ?? this.categoryHoverStates,
      authorHoverStates: authorHoverStates ?? this.authorHoverStates,
      channelHoverStates: channelHoverStates ?? this.channelHoverStates,
      trendingTopicHoverStates:
          trendingTopicHoverStates ?? this.trendingTopicHoverStates,
      isBlogOfDayHovered: isBlogOfDayHovered ?? this.isBlogOfDayHovered,
    );
  }
}

// State notifier to manage hover states
class HoverStateController extends StateNotifier<HoverStates> {
  HoverStateController()
      : super(HoverStates(
          featuredStoryHoverStates:
              _initializeMap(['story1', 'story2', 'story3']),
          webStoryHoverStates: _initializeMap([
            'Tokyo',
            'AI',
            'Sustainable',
            'Coffee',
            'Yoga',
            'Architecture',
            'Photography',
            'Electric'
          ]),
          categoryHoverStates:
              _initializeMap(['Travel', 'Technology', 'Lifestyle', 'Food']),
          authorHoverStates: _initializeMap(
              ['David Kim', 'Lisa Chen', 'Mark Thompson', 'Sophie Williams']),
          channelHoverStates: _initializeMap(['Tech', 'Food', 'Fitness']),
          trendingTopicHoverStates: _initializeMap([
            'AI in 2025',
            'Travel Hacks',
            'Healthy Living',
            'Digital Nomads',
            'Future Tech'
          ]),
          isBlogOfDayHovered: false,
        ));

  static Map<String, bool> _initializeMap(List<String> keys) {
    return Map.fromIterable(keys, key: (k) => k, value: (_) => false);
  }

  void setFeaturedStoryHover(String key, bool value) {
    state = state.copyWith(
      featuredStoryHoverStates: {...state.featuredStoryHoverStates}..[key] =
          value,
    );
  }

  void setWebStoryHover(String key, bool value) {
    state = state.copyWith(
      webStoryHoverStates: {...state.webStoryHoverStates}..[key] = value,
    );
  }

  void setCategoryHover(String key, bool value) {
    state = state.copyWith(
      categoryHoverStates: {...state.categoryHoverStates}..[key] = value,
    );
  }

  void setAuthorHover(String key, bool value) {
    state = state.copyWith(
      authorHoverStates: {...state.authorHoverStates}..[key] = value,
    );
  }

  void setChannelHover(String key, bool value) {
    state = state.copyWith(
      channelHoverStates: {...state.channelHoverStates}..[key] = value,
    );
  }

  void setTrendingTopicHover(String key, bool value) {
    state = state.copyWith(
      trendingTopicHoverStates: {...state.trendingTopicHoverStates}..[key] =
          value,
    );
  }

  void setBlogOfDayHover(bool value) {
    state = state.copyWith(isBlogOfDayHovered: value);
  }
}

// Provider for hover states
final hoverStateProvider =
    StateNotifierProvider<HoverStateController, HoverStates>((ref) {
  return HoverStateController();
});
