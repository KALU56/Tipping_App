// auth_repository.dart

import '../../data/models/auth_model.dart';


abstract class AuthRepository {
  /// Login with email and password
  Future<LoginModel> login(LoginModel model);

  /// Signup a new user
  Future<SignupModel> signup(SignupModel model);
}
