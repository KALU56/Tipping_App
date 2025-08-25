// lib/src/features/settings/domain/repositories/user_repository.dart
import '../models/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile> getUserProfile();
  Future<void> updatePassword(String oldPassword, String newPassword);
  Future<void> logout();
}
