
import 'package:tip_employee/src/core/service/user_service.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<User> getProfile() async {
    final data = await userService.getProfile(); // use service

    return User(
      firstname: data['first_name'],
      lastname: data['last_name'],
      email: data['email'],
      accountNumber: data['bank_account']?['sub_account_id'] ?? '',
      password: '', // don’t expose password
      imageUrl: data['image_url'],
    );
  }
}
