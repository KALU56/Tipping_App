import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class SignupSuccess extends AuthState {}
class SignupFailure extends AuthState {
  final String message;
  SignupFailure(this.message);

  @override
  List<Object?> get props => [message];
}
class LoginSuccess extends AuthState {}
class LoginFailure extends AuthState {
  final String message;
  LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}
