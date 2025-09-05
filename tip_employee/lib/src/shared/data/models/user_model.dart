import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String firstname;
  final String lastname;
  final String email;
  final String work;
  final String accountNumber;
  final String password;

  const User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.work,
    required this.accountNumber,
    required this.password,
  });

  // JSON serialization
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  // copyWith method
  User copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? work,
    String? accountNumber,
    String? password,
  }) {
    return User(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      work: work ?? this.work,
      accountNumber: accountNumber ?? this.accountNumber,
      password: password ?? this.password,
    );
  }
}
