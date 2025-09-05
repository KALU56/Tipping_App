


import 'package:tip_employee/src/shared/data/models/user_model.dart';

abstract class UserRepository {
  Future<User> getProfile();
  Future<void> updateProfile(User user);
    /// New: Change password
  Future<void> changePassword(String oldPassword, String newPassword);

  /// New: Logout
  Future<void> logout();
}
