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
    // First, get the current profile
    final currentData = await userService.getProfile();
    final currentUser = User.fromJson(currentData);

    // Call API to update
    final updatedData = await userService.updateProfile(
      firstName: firstName,
      lastName: lastName,
      imageUrl: imageUrl,
    );

    // Merge with current user
    return User(
      firstname: updatedData['first_name'] ?? currentUser.firstname,
      lastname: updatedData['last_name'] ?? currentUser.lastname,
      email: currentUser.email,
      accountNumber: updatedData['bank_account']?['sub_account_id'] ?? currentUser.accountNumber,
      password: currentUser.password,
      imageUrl: updatedData['image_url'] ?? currentUser.imageUrl,
    );
  }

  @override
  Future<void> updatePassword({required String currentPassword, required String newPassword, required String confirmPassword}) async {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getBankAccount() async {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateBankAccount({required String accountNumber}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deactivateAccount() async {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    throw UnimplementedError();
  }
}
