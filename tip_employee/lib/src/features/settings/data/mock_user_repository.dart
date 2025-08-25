// lib/src/features/settings/data/mock_user_repository.dart
import '../domain/models/user_profile.dart';
import '../domain/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  @override
  Future<UserProfile> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserProfile(
      name: 'maron',
      role: 'manager',
      avatar: 'assets/images/Ellipse 7.png',
    );
  }

  @override
  Future<void> updatePassword(String oldPassword, String newPassword) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Just mock success
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock logout
  }
}
