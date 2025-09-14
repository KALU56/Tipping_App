import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'first_name')
  final String firstname;

  @JsonKey(name: 'last_name')
  final String lastname;

  final String email;

  final String accountNumber; // comes from bank_account.sub_account_id

  final String password;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  const User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.accountNumber,
    required this.password,
    this.imageUrl,
  });

  // Custom fromJson to handle nested bank_account
  factory User.fromJson(Map<String, dynamic> json) => User(
        firstname: json['first_name'] as String,
        lastname: json['last_name'] as String,
        email: json['email'] as String,
        accountNumber: json['bank_account']?['sub_account_id'] as String? ?? '',
        password: json['password'] as String,
        imageUrl: json['image_url'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'account_number': accountNumber,
        'password': password,
        'image_url': imageUrl,
      };

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
