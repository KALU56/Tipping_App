// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  firstname: json['first_name'] as String,
  lastname: json['last_name'] as String,
  email: json['email'] as String,
  tipCode: json['tip_code'] as String?,
  accountNumber: json['account_number'] as String?,
  accountName: json['account_name'] as String?,
  bankCode: json['bank_code'] as String?,
  password: json['password'] as String? ?? '',
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'first_name': instance.firstname,
  'last_name': instance.lastname,
  'email': instance.email,
  'tip_code': instance.tipCode,
  'account_number': instance.accountNumber,
  'account_name': instance.accountName,
  'bank_code': instance.bankCode,
  'password': instance.password,
  'image_url': instance.imageUrl,
};
