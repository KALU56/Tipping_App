// auth_state.dart
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class AuthInitial extends AuthState {}

// Loading state
class AuthLoading extends AuthState {}

// Signup success
class SignupSuccess extends AuthState {}

// Signup failure (wrong employ code)
class SignupFailure extends AuthState {
  final String message;
  SignupFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Login success
class LoginSuccess extends AuthState {}

// Login failure (wrong email/password)
class LoginFailure extends AuthState {
  final String message;
  LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}
