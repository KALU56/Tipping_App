import 'package:tip_employee/src/core/service/user_service.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});
@override
Future<User> getProfile() async {
  try {
    final data = await userService.getProfile();
    print('Raw API data: $data');
    
    // Check if critical fields exist with null safety
    if (data['first_name'] == null && data['last_name'] == null) {
      print('Warning: Name fields are null in API response');
      // Handle partial data gracefully
      return User.fromJson(data); // Ensure User.fromJson handles nulls
    }
    
    return User.fromJson(data);
  } catch (e) {
    print('Error in getProfile: $e');
    
    // Provide more specific error messages
    if (e.toString().contains('No token found')) {
      throw Exception('Please login again - authentication token missing');
    } else if (e.toString().contains('Unexpected data structure')) {
      throw Exception('Server returned invalid response format');
    } else {
      rethrow;
    }
  }
}
}
