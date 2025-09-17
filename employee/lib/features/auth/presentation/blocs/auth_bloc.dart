import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/models/login_model.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignupRequested>(_onSignupRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onSignupRequested(SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authRepository.signup(event.signupModel);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure("Signup failed: ${e.toString()}"));
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.login(event.loginModel);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure("Login failed: ${e.toString()}"));
    }
  }
}
