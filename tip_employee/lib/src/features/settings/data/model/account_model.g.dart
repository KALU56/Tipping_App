// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  id: json['id'] as String,
  employeeId: json['employee_id'] as String,
  accountNumber: json['account_number'] as String,
  accountName: json['account_name'] as String,
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'id': instance.id,
  'employee_id': instance.employeeId,
  'account_number': instance.accountNumber,
  'account_name': instance.accountName,
};
