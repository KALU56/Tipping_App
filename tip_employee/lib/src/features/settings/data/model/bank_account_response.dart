// lib/src/domain/models/bank_account_response.dart
class BankAccountResponse {
  final String? message;
  final String? subAccountId;
  final DateTime? updatedAt;

  BankAccountResponse({
    this.message,
    this.subAccountId,
    this.updatedAt,
  });

  factory BankAccountResponse.fromJson(Map<String, dynamic> json) {
    return BankAccountResponse(
      message: json["message"],
      subAccountId: json["data"]?["sub_account_id"],
      updatedAt: json["data"]?["updated_at"] != null
          ? DateTime.tryParse(json["data"]["updated_at"])
          : null,
    );
  }
}
