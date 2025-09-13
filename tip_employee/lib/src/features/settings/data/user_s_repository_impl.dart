
import 'package:tip_employee/src/core/service/user_service.dart';
import 'package:tip_employee/src/features/settings/domain/user_s_repository.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';


class UserSettingRepositoryImpl implements UserSettingRepository {
  final UserService userService;

  UserSettingRepositoryImpl({required this.userService});

  @override
  Future<User> updateProfile({
    String? firstName,
    String? lastName,
    String? imageUrl,
  }) async {
    final data = await userService.updateProfile(
      firstName: firstName,
      lastName: lastName,
      imageUrl: imageUrl,
    );

    return User(
      firstname: data['first_name'],
      lastname: data['last_name'],
      email: '', // email won't change
      accountNumber: data['bank_account']?['sub_account_id'] ?? '',
      password: '',
      imageUrl: data['image_url'],
    );
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await userService.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<Map<String, dynamic>> getBankAccount() async {
    return await userService.getBankAccount();
  }

  @override
  Future<Map<String, dynamic>> updateBankAccount({
   
    required String accountNumber,
  }) async {
    return await userService.updateBankAccount(
      businessName: '', // keep empty if not needed
      accountName: '',  // keep empty if not needed
      bankCode: 0,
      accountNumber: accountNumber,
    );
  }

  @override
  Future<void> deactivateAccount() async {
    await userService.deactivateAccount();
  }

  @override
  Future<void> logout() async {
    await userService.logout();
  }
}
