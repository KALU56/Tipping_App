// auth/domain/entities/user_entity.dart
class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? phone;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
  });
}

// auth/domain/entities/login_entity.dart
class LoginEntity {
  final String email;
  final String password;

  LoginEntity({required this.email, required this.password});
}

// auth/domain/entities/signup_entity.dart
class SignUpEntity {
  final String username;
  final String email;
  final String phone;
  final String providerCode;
  final String password;

  SignUpEntity({
    required this.username,
    required this.email,
    required this.phone,
    required this.providerCode,
    required this.password,
  });
}