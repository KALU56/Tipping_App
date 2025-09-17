import 'dart:io';
import 'package:tip_employee/core/service/user_service.dart';
import 'package:tip_employee/shared/data/models/user_model.dart';
import 'package:tip_employee/features/settings/domain/user_s_repository.dart';

class UserSettingRepositoryImpl implements UserSettingRepository {
  final UserService userService;

  UserSettingRepositoryImpl({required this.userService});

  @override
  Future<User> updateProfile({
    String? firstName,
    String? lastName,
    File? imageFile,
  }) async {
    final currentData = await userService.getProfile();
    final currentUser = User.fromJson(currentData);

    final updatedData = await userService.updateProfile(
      firstName: firstName,
      lastName: lastName,
      imageFile: imageFile,
    );

    return User(
      firstname: updatedData['first_name'] ?? currentUser.firstname,
      lastname: updatedData['last_name'] ?? currentUser.lastname,
      email: currentUser.email,
      password: currentUser.password,
      imageUrl: updatedData['image_url'] ?? currentUser.imageUrl,
      accounts: currentUser.accounts,
    );
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await userService.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      print('Error updating password: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getBankAccount() async {
    try {
      final bankData = await userService.getBankAccount();
      return bankData;
    } catch (e) {
      print('Error fetching bank account: $e');
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getBanks() async {
    try {
      final banks = await userService.getBanks();
      return banks;
    } catch (e) {
      print('Error fetching banks: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateBankAccount({
    required String accountName,
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      final updatedBankData = await userService.updateBankAccount(
        accountName: accountName,
        accountNumber: accountNumber,
        bankCode: bankCode,
      );
      return updatedBankData;
    } catch (e) {
      print('Error updating bank account: $e');
      rethrow;
    }
  }

  @override
  Future<void> deactivateAccount() async {
    try {
      await userService.deactivateAccount();
      print('Account successfully deactivated');
    } catch (e) {
      print('Error deactivating account: $e');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await userService.logout();
      print('Successfully logged out');
    } catch (e) {
      print('Error logging out: $e');
      rethrow;
    }
  }
}