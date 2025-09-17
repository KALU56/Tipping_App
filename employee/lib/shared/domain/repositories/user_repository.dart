// lib/src/features/settings/domain/repositories/user_repository.dart
import 'package:tip_employee/shared/data/models/user_model.dart';


abstract interface class UserRepository {
  Future<User> getProfile();  

}
