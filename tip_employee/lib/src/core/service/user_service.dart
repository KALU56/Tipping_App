// lib/src/core/service/user_service.dart
import 'package:tip_employee/src/core/service/http_service/http_service.dart';

class UserService {
  final HttpService httpService;

  UserService(this.httpService);

  Future<Map<String, dynamic>> getProfile() async {
    final response = await httpService.get('/employee/profile');

    if (response.staticCode == 200) {
      return response.data['data']; // just return the raw data
    } else {
      throw Exception('Failed to load profile: ${response.data}');
    }
  }
}
