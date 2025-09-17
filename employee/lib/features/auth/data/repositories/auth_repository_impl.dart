import 'package:tip_employee/core/service/auth_service.dart';


import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';
import '../models/login_model.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<LoginModel> login(LoginModel model) {
    return _authService.login(model.email, model.password);
  }

  @override
  Future<SignupModel> signup(SignupModel model) {
    return _authService.signup(
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      password: model.password,
      employeeCode: model.employeeCode,
    );
  }
}
