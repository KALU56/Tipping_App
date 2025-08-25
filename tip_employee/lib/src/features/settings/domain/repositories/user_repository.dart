import '../models/user.dart';

abstract class UserRepository {
  Future<User> getProfile();
  Future<void> updateProfile(User user);
}
