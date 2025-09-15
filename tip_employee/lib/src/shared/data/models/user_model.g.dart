// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  firstname: json['first_name'] as String,
  lastname: json['last_name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  imageUrl: json['image_url'] as String?,
  accounts: (json['accounts'] as List<dynamic>?)
      ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'first_name': instance.firstname,
  'last_name': instance.lastname,
  'email': instance.email,
  'password': instance.password,
  'image_url': instance.imageUrl,
  'accounts': instance.accounts?.map((e) => e.toJson()).toList(),
};
