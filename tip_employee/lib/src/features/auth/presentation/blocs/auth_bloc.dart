import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:tip_employee/src/features/auth/data/models/login_model.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository; // ✅ depend on abstraction, not impl

  // Dummy service provider employ code for validation
  final String correctEmployCode = "SP001";

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignupRequested>(_onSignupRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onSignupRequested(
      SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // Check employ code
    if (event.signupModel.employCode != correctEmployCode) {
      emit(SignupFailure("Invalid employ code"));
      return;
    }

    try {
      await authRepository.signup(event.signupModel);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure("Signup failed: ${e.toString()}"));
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.login(LoginModel(
        email: event.loginModel.email,
        password: event.loginModel.password,
      ));

      if (user.email == event.loginModel.email &&
          user.password == event.loginModel.password) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Incorrect email or password"));
      }
    } catch (e) {
      emit(LoginFailure("Login failed: ${e.toString()}"));
    }
  }
}
