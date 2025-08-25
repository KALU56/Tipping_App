import '../domain/models/user.dart';
import '../domain/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  User _mockUser = const User(
    id: "1",
    name: "maron",
    username: "maron_user",
    email: "maron@example.com",
    description: "Manager at Company",
    accountNumber: "1234567890",
  );

  @override
  Future<User> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockUser;
  }

  @override
  Future<void> updateProfile(User user) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockUser = user;
  }
}
