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
    final data = json["data"] ?? {};
    return BankAccountResponse(
      message: json["message"] ?? '',
      subAccountId: data["sub_account_id"],
      updatedAt: data["updated_at"] != null
          ? DateTime.tryParse(data["updated_at"])
          : null,
    );
  }

  @override
  String toString() =>
      'BankAccountResponse(message: $message, subAccountId: $subAccountId, updatedAt: $updatedAt)';
}
