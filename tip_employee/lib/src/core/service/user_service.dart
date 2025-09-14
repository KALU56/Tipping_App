import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/core/service/http_service/http_service_response_model.dart';

class UserService {
  final HttpService httpService;

  UserService(this.httpService);

  /// Get profile
  Future<Map<String, dynamic>> getProfile() async {
    final response = await httpService.get('/api/employee/profile');
    if (response.staticCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to load profile: ${response.data}');
    }
  }

  /// Update profile
  Future<Map<String, dynamic>> updateProfile({
    String? firstName,
    String? lastName,
    String? imageUrl,
  }) async {
    final body = {
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (imageUrl != null) 'image_url': imageUrl,
    };

    final response = await httpService.put('/api/employee/profile', body);
    if (response.staticCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to update profile: ${response.data}');
    }
  }

  /// Update password
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final body = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
    final response = await httpService.put('/api/employee/password', body);
    if (response.staticCode != 200) {
      throw Exception('Failed to update password: ${response.data}');
    }
  }

  /// Get bank account
  Future<Map<String, dynamic>> getBankAccount() async {
    final response = await httpService.get('/api/employee/bank-account');
    if (response.staticCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to load bank account: ${response.data}');
    }
  }

  /// Update bank account
  Future<Map<String, dynamic>> updateBankAccount({
    required String businessName,
    required String accountName,
    required int bankCode,
    required String accountNumber,
  }) async {
    final body = {
      'business_name': businessName,
      'account_name': accountName,
      'bank_code': bankCode,
      'account_number': accountNumber,
    };
    final response = await httpService.put('/api/employee/bank-account', body);
    if (response.staticCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to update bank account: ${response.data}');
    }
  }

  /// Deactivate account
  Future<void> deactivateAccount() async {
    final response = await httpService.delete('/api/employee/account');
    if (response.staticCode != 200) {
      throw Exception('Failed to deactivate account: ${response.data}');
    }
  }

  /// Logout
  Future<void> logout() async {
    final response = await httpService.post('/api/employees/logout', {});
    if (response.staticCode != 200) {
      throw Exception('Failed to logout: ${response.data}');
    }
  }
}
