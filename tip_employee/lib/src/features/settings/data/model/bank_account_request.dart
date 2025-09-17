// lib/src/domain/models/bank_account_request.dart
class BankAccountRequest {
  final String? accountName;
  final String? accountNumber;
  final String? bankCode; // using string because your UI sends code as string

  BankAccountRequest({
    this.accountName,
    this.accountNumber,
    this.bankCode,
  });

  /// Convert model to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      if (accountName != null) "account_name": accountName,
      if (accountNumber != null) "account_number": accountNumber,
      if (bankCode != null) "bank_code": bankCode,
    };
  }
}
