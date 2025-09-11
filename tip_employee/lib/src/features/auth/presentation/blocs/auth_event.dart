import 'package:equatable/equatable.dart';

import '../../data/models/auth_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupRequested extends AuthEvent {
  final SignupModel signupModel;

  SignupRequested(this.signupModel);

  @override
  List<Object?> get props => [signupModel];
}

class LoginRequested extends AuthEvent {
  final LoginModel loginModel;

  LoginRequested(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}
