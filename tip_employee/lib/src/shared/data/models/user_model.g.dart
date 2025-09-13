// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  firstname: json['firstname'] as String,
  lastname: json['lastname'] as String,
  email: json['email'] as String,
  accountNumber: json['accountNumber'] as String,
  password: json['password'] as String,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'firstname': instance.firstname,
  'lastname': instance.lastname,
  'email': instance.email,
  'accountNumber': instance.accountNumber,
  'password': instance.password,
  'imageUrl': instance.imageUrl,
};
