// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
  hasBankAccount: json['has_bank_account'] as bool,
  subAccountId: json['sub_account_id'] as String?,
  bankAccountUpdatedAt: json['bank_account_updated_at'] as String?,
);

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'has_bank_account': instance.hasBankAccount,
      'sub_account_id': instance.subAccountId,
      'bank_account_updated_at': instance.bankAccountUpdatedAt,
    };
