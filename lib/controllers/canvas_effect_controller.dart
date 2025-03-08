import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CanvasEffectState {
  final double animationSpeed;
  final List<double> opacities;
  final List<List<double>> colors;
  final double dotSize;
  final bool showGradient;
  final double totalSize;
  final List<String> center;
  final String customShader;

  const CanvasEffectState({
    this.animationSpeed = 0.4,
    this.opacities = const [0.3, 0.3, 0.3, 0.5, 0.5, 0.5, 0.8, 0.8, 0.8, 1.0],
    this.colors = const [
      [0, 255, 255]
    ],
    this.dotSize = 3.0,
    this.showGradient = true,
    this.totalSize = 4.0,
    this.center = const ["x", "y"],
    this.customShader = "",
  });

  CanvasEffectState copyWith({
    double? animationSpeed,
    List<double>? opacities,
    List<List<double>>? colors,
    double? dotSize,
    bool? showGradient,
    double? totalSize,
    List<String>? center,
    String? customShader,
  }) {
    return CanvasEffectState(
      animationSpeed: animationSpeed ?? this.animationSpeed,
      opacities: opacities ?? this.opacities,
      colors: colors ?? this.colors,
      dotSize: dotSize ?? this.dotSize,
      showGradient: showGradient ?? this.showGradient,
      totalSize: totalSize ?? this.totalSize,
      center: center ?? this.center,
      customShader: customShader ?? this.customShader,
    );
  }
}

class CanvasEffectController extends StateNotifier<CanvasEffectState> {
  CanvasEffectController() : super(const CanvasEffectState());

  void updateAnimationSpeed(double speed) {
    state = state.copyWith(animationSpeed: speed);
  }

  void updateOpacities(List<double> opacities) {
    state = state.copyWith(opacities: opacities);
  }

  void updateColors(List<List<double>> colors) {
    state = state.copyWith(colors: colors);
  }

  void updateDotSize(double size) {
    state = state.copyWith(dotSize: size);
  }

  void toggleGradient() {
    state = state.copyWith(showGradient: !state.showGradient);
  }

  void updateTotalSize(double size) {
    state = state.copyWith(totalSize: size);
  }

  void updateCenter(List<String> center) {
    state = state.copyWith(center: center);
  }

  void updateCustomShader(String shader) {
    state = state.copyWith(customShader: shader);
  }
}

final canvasEffectProvider =
    StateNotifierProvider<CanvasEffectController, CanvasEffectState>((ref) {
  return CanvasEffectController();
});
