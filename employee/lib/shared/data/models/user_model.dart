import 'package:json_annotation/json_annotation.dart';
import 'package:tip_employee/features/settings/data/model/account_model.dart';



part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'first_name')
  final String firstname;

  @JsonKey(name: 'last_name')
  final String lastname;

  final String email;
  final String password;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  final List<Account>? accounts; 

  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.imageUrl,
    this.accounts,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
