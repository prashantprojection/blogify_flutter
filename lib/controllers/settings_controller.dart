import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsModel {
  final bool neonEffectEnabled;
  final double neonEffectSpeed;

  const SettingsModel({
    this.neonEffectEnabled = false,
    this.neonEffectSpeed = 1.0,
  });

  SettingsModel copyWith({
    bool? neonEffectEnabled,
    double? neonEffectSpeed,
  }) {
    return SettingsModel(
      neonEffectEnabled: neonEffectEnabled ?? this.neonEffectEnabled,
      neonEffectSpeed: neonEffectSpeed ?? this.neonEffectSpeed,
    );
  }
}

class SettingsController extends StateNotifier<SettingsModel> {
  static const List<double> speedValues = [
    0.25,
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    1.75,
    2.0,
    2.5,
    3.0,
    3.5,
    4.0,
    4.5,
    5.0
  ];

  SettingsController() : super(SettingsModel());

  void toggleNeonEffect() {
    state = state.copyWith(neonEffectEnabled: !state.neonEffectEnabled);
  }

  void setNeonEffectSpeed(double speed) {
    // Find the closest speed value from our predefined list
    double closestSpeed = speedValues.reduce((a, b) {
      return (a - speed).abs() < (b - speed).abs() ? a : b;
    });
    state = state.copyWith(neonEffectSpeed: closestSpeed);
  }

  bool get isNeonEffectEnabled => state.neonEffectEnabled;
  double get neonEffectSpeed => state.neonEffectSpeed;
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsModel>((ref) {
  return SettingsController();
});
