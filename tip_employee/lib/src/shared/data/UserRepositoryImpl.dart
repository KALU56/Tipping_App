import 'package:tip_employee/src/core/service/user_service.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});
  @override
  Future<User> getProfile() async {
    try {
      final data = await userService.getProfile(); // Map<String, dynamic>
      final user = User.fromJson(data); // convert map to User
      print('Fetched user: ${user.toJson()}'); // now works
      return user;
    } catch (e) {
      print('Error fetching profile: $e');
      rethrow;
    }
  }
}
