// auth_repository_impl.dart

import 'dart:async';
import 'package:tip_employee/src/features/auth/domain/repositories/auth_repository.dart';

import '../models/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<LoginModel> login(LoginModel model) async {
    await Future.delayed(const Duration(seconds: 1));
    return LoginModel(email: model.email, password: model.password);
  }

  @override
  Future<SignupModel> signup(SignupModel model) async {
    await Future.delayed(const Duration(seconds: 1));
    return SignupModel(
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      password: model.password,
      employCode: model.employCode,
    );
  }
}
