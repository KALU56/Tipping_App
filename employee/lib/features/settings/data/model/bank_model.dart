import 'package:json_annotation/json_annotation.dart';

part 'bank_model.g.dart';

@JsonSerializable()
class BankAccount {
  @JsonKey(name: "has_bank_account")
  final bool hasBankAccount;

  @JsonKey(name: "sub_account_id")
  final String? subAccountId; 

  @JsonKey(name: "bank_account_updated_at")
  final String? bankAccountUpdatedAt; 

  BankAccount({
    required this.hasBankAccount,
    this.subAccountId,
    this.bankAccountUpdatedAt,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountToJson(this);
}
