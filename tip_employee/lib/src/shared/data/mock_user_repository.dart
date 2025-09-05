import 'dart:async';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  User _user = User(
    firstname: 'Kali',
    lastname: 'Smith',
    email: 'kal@gmail.com',
    work: 'Manager',
    accountNumber: '12345678',
    password: 'password123',
  );

  @override
  Future<User> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _user;
  }

  @override
  Future<void> updateProfile(User user) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _user = user;
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (_user.password != oldPassword) {
      throw Exception("Old password is incorrect");
    }

    _user = _user.copyWith(password: newPassword);
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // For mock: just "clear" user (in real API you'd delete token/session)
    _user = User(
      firstname: '',
      lastname: '',
      email: '',
      work: '',
      accountNumber: '',
      password: '',
    );
  }
}
