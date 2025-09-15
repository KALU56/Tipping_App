import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class Account {
  final String id;

  @JsonKey(name: "employee_id")
  final String employeeId;

  @JsonKey(name: "account_number")
  final String accountNumber;

  @JsonKey(name: "account_name")
  final String accountName; // new field for friendly name

  Account({
    required this.id,
    required this.employeeId,
    required this.accountNumber,
    required this.accountName,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
