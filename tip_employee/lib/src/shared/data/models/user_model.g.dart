// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  firstname: json['firstname'] as String,
  lastname: json['lastname'] as String,
  email: json['email'] as String,
  work: json['work'] as String,
  accountNumber: json['accountNumber'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'firstname': instance.firstname,
  'lastname': instance.lastname,
  'email': instance.email,
  'work': instance.work,
  'accountNumber': instance.accountNumber,
  'password': instance.password,
};
