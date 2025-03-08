import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enums for type-safe settings
enum NotificationType {
  push('push_notifications'),
  email('email_notifications'),
  browser('browser_notifications'),
  newPost('new_post_notifications'),
  comment('comment_notifications'),
  mention('mention_notifications'),
  reaction('reaction_notifications'),
  follower('follower_notifications'),
  message('message_notifications'),
  community('community_notifications'),
  update('update_notifications'),
  newsletter('newsletter_notifications'),
  offer('offer_notifications');

  final String key;
  const NotificationType(this.key);
}

enum ContentType {
  autoPlayVideos('auto_play_videos'),
  showNSFWContent('show_nsfw_content'),
  showReadingTime('show_reading_time'),
  readerMode('reader_mode'),
  saveReadingProgress('save_reading_progress');

  final String key;
  const ContentType(this.key);
}

enum SecurityAction {
  securityCheckup,
  recoveryOptions,
  manageBlockedUsers,
  manageContentFilters
}

enum AccountAction {
  connectGoogle,
  connectFacebook,
  connectTwitter,
  verifyAccount,
  viewAnalytics,
  viewHistory,
  upgradePremium,
  manageBilling,
  viewSubscription
}

enum HelpAction {
  openFAQ,
  openUserGuide,
  openTutorials,
  contactSupport,
  openLiveChat,
  viewTickets,
  reportBug,
  requestFeature,
  rateApp
}

enum LegalAction {
  aboutBlogify,
  whatsNew,
  credits,
  termsOfService,
  privacyPolicy,
  cookiePolicy,
  openSourceLicenses,
  softwareLicenses,
  contentLicenses
}

enum CriticalAction { deleteAccount }

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

class SettingsState {
  final int selectedTabIndex;
  final Map<String, dynamic> settingValues;

  const SettingsState({
    this.selectedTabIndex = 0,
    this.settingValues = const {},
  });

  // General getters
  bool get isDarkMode => getValue('dark_mode', false);
  double get textSize => getValue('text_size', 1.0);
  bool get highContrast => getValue('high_contrast', false);
  bool get dataSaverEnabled => getValue('data_saver', false);
  bool get backgroundRefresh => getValue('background_refresh', true);
  bool get developerMode => getValue('developer_mode', false);
  bool get criticalActionsEnabled =>
      getValue('critical_actions_enabled', false);

  // Notifications getters
  bool get notificationsEnabled => getValue('notifications_enabled', true);
  bool get twoFactorEnabled => getValue('two_factor_enabled', false);

  // Privacy & Security getters
  bool get privateProfile => getValue('private_profile', false);
  bool get privatePostsEnabled => getValue('private_posts', false);
  bool get activityStatusEnabled => getValue('activity_status', true);
  bool get readReceiptsEnabled => getValue('read_receipts', true);
  bool get dataCollectionEnabled => getValue('data_collection', true);
  bool get thirdPartyAccessEnabled => getValue('third_party_access', false);
  bool get personalizedAdsEnabled => getValue('personalized_ads', true);
  bool get loginAlertsEnabled => getValue('login_alerts', true);
  bool get suspiciousActivityAlertsEnabled =>
      getValue('suspicious_activity_alerts', true);

  // Additional getters
  bool get backgroundEffects => getValue('background_effects', false);
  bool get neonEffectEnabled => getValue('neon_effect_enabled', false);
  double get neonEffectSpeed => getValue('neon_effect_speed', 1.0);
  double get neonEffectIntensity => getValue('neon_effect_intensity', 1.0);
  double get neonEffectWidth => getValue('neon_effect_width', 2.0);
  bool get neonEffectPulsing => getValue('neon_effect_pulsing', false);
  bool get backgroundRefreshEnabled =>
      getValue('background_refresh_enabled', true);
  bool get pushNotificationsEnabled =>
      getValue('push_notifications_enabled', true);
  bool get commentNotificationsEnabled =>
      getValue('comment_notifications_enabled', true);
  bool get mentionsNotificationsEnabled =>
      getValue('mentions_notifications_enabled', true);

  T getValue<T>(String key, T defaultValue) {
    return settingValues[key] as T? ?? defaultValue;
  }

  SettingsState copyWith({
    int? selectedTabIndex,
    Map<String, dynamic>? settingValues,
  }) {
    return SettingsState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      settingValues: settingValues ?? this.settingValues,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void setSelectedTabIndex(int index) {
    state = state.copyWith(selectedTabIndex: index);
  }

  void _updateSetting<T>(String key, T value) {
    state = state.copyWith(
      settingValues: {...state.settingValues, key: value},
    );
  }

  // General settings methods
  void setDarkMode(bool value) => _updateSetting('dark_mode', value);
  void setHighContrast(bool value) => _updateSetting('high_contrast', value);
  void setDataSaver(bool value) => _updateSetting('data_saver', value);
  void setBackgroundRefresh(bool value) =>
      _updateSetting('background_refresh', value);
  void setDeveloperMode(bool value) => _updateSetting('developer_mode', value);
  void setCriticalActionsEnabled(bool value) =>
      _updateSetting('critical_actions_enabled', value);

  // Text size methods
  void increaseTextSize() {
    final newSize = (state.textSize + 0.1).clamp(0.5, 2.0);
    _updateSetting('text_size', newSize);
  }

  void decreaseTextSize() {
    final newSize = (state.textSize - 0.1).clamp(0.5, 2.0);
    _updateSetting('text_size', newSize);
  }

  // Notification methods
  void setNotificationsEnabled(bool value) =>
      _updateSetting('notifications_enabled', value);
  void setNotification(NotificationType type, bool value) =>
      _updateSetting(type.key, value);

  // Privacy & Security methods
  void setTwoFactorAuth(bool value) =>
      _updateSetting('two_factor_enabled', value);
  void setPrivateProfile(bool value) =>
      _updateSetting('private_profile', value);
  void setPrivatePosts(bool value) => _updateSetting('private_posts', value);
  void setActivityStatus(bool value) =>
      _updateSetting('activity_status', value);
  void setReadReceipts(bool value) => _updateSetting('read_receipts', value);
  void setDataCollection(bool value) =>
      _updateSetting('data_collection', value);
  void setThirdPartyAccess(bool value) =>
      _updateSetting('third_party_access', value);
  void setPersonalizedAds(bool value) =>
      _updateSetting('personalized_ads', value);
  void setLoginAlerts(bool value) => _updateSetting('login_alerts', value);
  void setSuspiciousActivityAlerts(bool value) =>
      _updateSetting('suspicious_activity_alerts', value);

  // Content preferences methods
  void setContentPreference(ContentType type, bool value) =>
      _updateSetting(type.key, value);

  // Action methods
  Future<void> performSecurityAction(SecurityAction action) async {
    // Implement security actions
  }

  Future<void> performAccountAction(AccountAction action) async {
    // Implement account actions
  }

  Future<void> performHelpAction(HelpAction action) async {
    // Implement help actions
  }

  Future<void> performLegalAction(LegalAction action) async {
    // Implement legal actions
  }

  Future<void> performCriticalAction(CriticalAction action) async {
    // Implement critical actions
  }

  // Additional methods
  Future<void> clearCache() async {
    // Implement cache clearing
  }

  Future<void> exportSettings() async {
    // Implement settings export
  }

  static List<double> speedValues = List.generate(19, (i) => 0.5 + (i * 0.25));

  // Additional methods
  void setBackgroundEffects(bool value) =>
      _updateSetting('background_effects', value);
  void toggleNeonEffect() =>
      _updateSetting('neon_effect_enabled', !state.neonEffectEnabled);
  void setNeonEffectSpeed(double value) =>
      _updateSetting('neon_effect_speed', value);
  void setNeonEffectIntensity(double value) =>
      _updateSetting('neon_effect_intensity', value);
  void setNeonEffectWidth(double value) =>
      _updateSetting('neon_effect_width', value);
  void setNeonEffectPulsing(bool value) =>
      _updateSetting('neon_effect_pulsing', value);
  void setTwoFactorEnabled(bool value) =>
      _updateSetting('two_factor_enabled', value);
  void setCommentNotifications(bool value) =>
      _updateSetting('comment_notifications_enabled', value);
  void setMentionsNotifications(bool value) =>
      _updateSetting('mentions_notifications_enabled', value);
}
