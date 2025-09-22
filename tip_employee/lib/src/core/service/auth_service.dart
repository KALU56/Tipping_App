import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/auth_model.dart';

import '../service/http_service/http_service.dart';
import '../service/http_service/http_service_response_model.dart';

class AuthService {
  final HttpService _httpService;

  AuthService(this._httpService);

  final String baseUrl = 'https://9a6b2568ac0a.ngrok-free.app/api/employees';

  Future<LoginModel> login(String email, String password) async {
    final data = {'email': email, 'password': password};

    final response = await _httpService.post('$baseUrl/login', data);

    if (response.staticCode == 200 || response.staticCode == 201) {
      final loginModel = LoginModel.fromJson(response.data);

      // ⚡ Save token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', loginModel.token!);

      return loginModel;
    } else {
      throw Exception('Login failed: ${response.data}');
    }
  }

  Future<SignupModel> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String employeeCode,
  }) async {
    final data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'employee_code': employeeCode, 
    };

    final response = await _httpService.post('$baseUrl/register', data);

    if (response.staticCode == 200 || response.staticCode == 201) {
      return SignupModel.fromJson(response.data);
    } else {
      throw Exception('Signup failed: ${response.data}');
    }
  }
}
