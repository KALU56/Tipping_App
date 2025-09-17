import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class Account {
  final String id;

  @JsonKey(name: "employee_id")
  final String employeeId;

  @JsonKey(name: "account_number")
  final String? accountNumber;

  @JsonKey(name: "account_name")
  final String? accountName;

  @JsonKey(name: "bank_code")
  final String? bankCode;

  Account({
    required this.id,
    required this.employeeId,
    this.accountNumber,
    this.accountName,
    this.bankCode,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as String,
      employeeId: json['employee_id'] as String,
      accountNumber: json['account_number'] as String?,
      accountName: json['account_name'] as String?,
      bankCode: json['bank_code'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'account_number': instance.accountNumber,
      'account_name': instance.accountName,
      'bank_code': instance.bankCode,
    };