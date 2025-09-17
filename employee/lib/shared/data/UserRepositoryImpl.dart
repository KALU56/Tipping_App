import 'package:tip_employee/core/service/user_service.dart';
import 'package:tip_employee/shared/data/models/user_model.dart';
import 'package:tip_employee/shared/domain/repositories/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});
  @override
  Future<User> getProfile() async {
    try {
      final data = await userService.getProfile();
      final user = User.fromJson(data);
      print('Fetched user: ${user.toJson()}');
      return user;
    } catch (e) {
      print('Error fetching profile: $e');
      rethrow;
    }
  }
}
