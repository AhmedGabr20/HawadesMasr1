import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../di/providers.dart';

class AuthState {
  const AuthState({this.loading = false, this.user, this.error});
  final bool loading;
  final User? user;
  final String? error;

  AuthState copyWith({bool? loading, User? user, String? error}) =>
      AuthState(loading: loading ?? this.loading, user: user ?? this.user, error: error);
}

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this._loginUseCase) : super(const AuthState());
  final LoginUseCase _loginUseCase;

  Future<void> login(String email, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final user = await _loginUseCase(email, password);
      state = state.copyWith(loading: false, user: user);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.watch(loginUseCaseProvider)),
);
