import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'first_name')
  final String firstname;

  @JsonKey(name: 'last_name')
  final String lastname;

  final String email;

  @JsonKey(name: 'account_number')
  final String? accountNumber; // sub_account_id

  @JsonKey(name: 'account_name')
  final String? accountName; // new

  @JsonKey(name: 'bank_code')
  final String? bankCode; // new

  final String password;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  const User({
    required this.firstname,
    required this.lastname,
    required this.email,
    this.accountNumber,
    this.accountName,
    this.bankCode,
    this.password = '',
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstname: json['first_name'] as String,
        lastname: json['last_name'] as String,
        email: json['email'] as String,
        accountNumber: json['bank_account']?['sub_account_id'] as String?,
        accountName: json['bank_account']?['account_name'] as String?,
        bankCode: json['bank_account']?['bank_code'] as String?,
        password: '',
        imageUrl: json['image_url'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        if (accountNumber != null) 'account_number': accountNumber,
        if (accountName != null) 'account_name': accountName,
        if (bankCode != null) 'bank_code': bankCode,
        'password': password,
        'image_url': imageUrl,
      };

  User copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? accountNumber,
    String? accountName,
    String? bankCode,
    String? password,
    String? imageUrl,
  }) {
    return User(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      bankCode: bankCode ?? this.bankCode,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
