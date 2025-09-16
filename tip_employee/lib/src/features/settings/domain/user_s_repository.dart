import 'dart:io';
import 'package:tip_employee/src/shared/data/models/user_model.dart';

abstract interface class UserSettingRepository {
  Future<User> updateProfile({
    String? firstName,
    String? lastName,
    File? imageFile,
  });

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Map<String, dynamic>> getBankAccount();

  Future<List<Map<String, dynamic>>> getBanks();

  Future<Map<String, dynamic>> updateBankAccount({
    required String accountName,
    required String accountNumber,
    required String bankCode,
  });

  Future<void> deactivateAccount();

  Future<void> logout();
}