import 'dart:io';

import 'package:tip_employee/src/core/service/user_service.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';

abstract interface class UserSettingRepository {
  /// Update employee profile (first name, last name, image)
    Future<User> updateProfile({
    String? firstName,
    String? lastName,
    File? imageFile,
  });

   /// Update password
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  /// Get bank account info
  Future<Map<String, dynamic>> getBankAccount();

  /// Update bank account info
  Future<Map<String, dynamic>> updateBankAccount({

    required String accountNumber,
  });

  /// Deactivate account
  Future<void> deactivateAccount();

  /// Logout
  Future<void> logout();
}
