import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tip_employee/src/core/service/cloudinary_service.dart';
import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/core/service/http_service/http_service_response_model.dart';


class UserService {
  final HttpService httpService;
  final CloudinaryService cloudinaryService;

  UserService({
    required this.httpService,
    required this.cloudinaryService,
  });

  /// -----------------------------
  /// GET PROFILE
  /// -----------------------------
  Future<Map<String, dynamic>> getProfile() async {
    final response = await httpService.get('/api/employee/profile');
    if (response.staticCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to load profile: ${response.data}');
    }
  }

  /// -----------------------------
  /// UPDATE PROFILE
  /// -----------------------------
  /// Accepts optional firstName, lastName, and imageFile
 
  /// Update profile with optional firstName, lastName, imageFile
  Future<Map<String, dynamic>> updateProfile({
    String? firstName,
    String? lastName,
    File? imageFile,
  }) async {
    final Map<String, dynamic> payload = {};

    if (firstName != null && firstName.isNotEmpty) payload['first_name'] = firstName;
    if (lastName != null && lastName.isNotEmpty) payload['last_name'] = lastName;

    if (imageFile != null) {
      // Upload image to Cloudinary first
      final imageUrl = await cloudinaryService.uploadImage(imageFile);
      print('✅ Cloudinary uploaded URL: $imageUrl');
      payload['image_url'] = imageUrl;
    }

    if (payload.isEmpty) throw Exception('No fields provided for update');

    print('➡ Sending payload to backend: $payload');

    final response = await httpService.put('/api/employee/profile', payload);

    if (response.staticCode == 200) {
      print('✅ Profile updated successfully: ${response.data}');
      return response.data['data'];
    } else {
      throw Exception('❌ Failed to update profile: ${response.data}');
    }
  }
  /// -----------------------------
  /// UPDATE PASSWORD
  /// -----------------------------
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

  /// -----------------------------
  /// GET BANK ACCOUNT
  /// -----------------------------
  Future<Map<String, dynamic>> getBankAccount() async {
    final response = await httpService.get('/api/employee/bank-account');
    if (response.staticCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to load bank account: ${response.data}');
    }
  }

  /// -----------------------------
  /// UPDATE BANK ACCOUNT
  /// -----------------------------
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

  /// -----------------------------
  /// DEACTIVATE ACCOUNT
  /// -----------------------------
  Future<void> deactivateAccount() async {
    final response = await httpService.delete('/api/employee/account');
    if (response.staticCode != 200) {
      throw Exception('Failed to deactivate account: ${response.data}');
    }
  }

  /// -----------------------------
  /// LOGOUT
  /// -----------------------------
  Future<void> logout() async {
    final response = await httpService.post('/api/employees/logout', {});
    if (response.staticCode != 200) {
      throw Exception('Failed to logout: ${response.data}');
    }
  }
}
