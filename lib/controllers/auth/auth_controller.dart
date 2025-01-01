import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final String? userId;
  final String? email;
  final bool isLoading;
  final String? error;

  AuthState({
    this.userId,
    this.email,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    String? userId,
    String? email,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(AuthState());

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // TODO: Implement actual sign in logic
      state = state.copyWith(
        userId: 'dummy-user-id',
        email: email,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // TODO: Implement actual sign out logic
      state = AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final authStateProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController();
});
