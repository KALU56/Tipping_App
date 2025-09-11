import '../../features/auth/data/models/auth_model.dart';

import '../service/http_service/http_service.dart';
import '../service/http_service/http_service_response_model.dart';

class AuthService {
  final HttpService _httpService;

  AuthService(this._httpService);

  final String baseUrl = 'http://127.0.0.1:8000/api/employees';

  // LOGIN
  Future<LoginModel> login(String email, String password) async {
    final data = {'email': email, 'password': password};

    final response = await _httpService.post('$baseUrl/login', data);

    if (response.staticCode == 200 || response.staticCode == 201) {
      return LoginModel.fromJson(response.data);
    } else {
      throw Exception('Login failed: ${response.data}');
    }
  }

  // SIGNUP
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
      'employee_code': employeeCode, // ⚡ important
    };

    final response = await _httpService.post('$baseUrl/register', data);

    if (response.staticCode == 200 || response.staticCode == 201) {
      return SignupModel.fromJson(response.data);
    } else {
      throw Exception('Signup failed: ${response.data}');
    }
  }
}
