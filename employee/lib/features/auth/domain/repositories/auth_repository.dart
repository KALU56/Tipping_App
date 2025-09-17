import 'package:tip_employee/features/auth/data/models/siginup_model.dart';


import '../../data/models/login_model.dart';


abstract class AuthRepository {
  Future<LoginModel> login(LoginModel model);
  Future<SignupModel> signup(SignupModel model);
}
