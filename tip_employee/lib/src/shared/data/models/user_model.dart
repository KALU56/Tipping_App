import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String firstname;
  final String lastname;
  final String email;
  final String accountNumber;
  final String password;
  final String? imageUrl; // optional profile picture

  const User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.accountNumber,
    required this.password,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? accountNumber,
    String? password,
    String? imageUrl,
  }) {
    return User(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      accountNumber: accountNumber ?? this.accountNumber,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
