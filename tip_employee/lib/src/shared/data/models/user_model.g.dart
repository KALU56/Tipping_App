// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  firstname: json['first_name'] as String,
  lastname: json['last_name'] as String,
  email: json['email'] as String,
  accountNumber: json['account_number'] as String,
  password: json['password'] as String? ?? '',
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'first_name': instance.firstname,
  'last_name': instance.lastname,
  'email': instance.email,
  'account_number': instance.accountNumber,
  'password': instance.password,
  'image_url': instance.imageUrl,
};
