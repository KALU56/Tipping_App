// lib/src/domain/models/bank_account_request.dart
import 'bank_model.dart';

class BankAccountRequest {
  final String businessName;
  final String accountName;
  final String accountNumber;
  final int bankCode;

  BankAccountRequest({
    required this.businessName,
    required this.accountName,
    required this.accountNumber,
    required this.bankCode,
  });

  /// Convenience constructor from Bank model
  factory BankAccountRequest.fromBank({
    required String businessName,
    required String accountName,
    required String accountNumber,
    required Bank bank,
  }) {
    return BankAccountRequest(
      businessName: businessName,
      accountName: accountName,
      accountNumber: accountNumber,
      bankCode: int.parse(bank.code), // ensure it's an int
    );
  }

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'business_name': businessName,
      'account_name': accountName,
      'account_number': accountNumber,
      'bank_code': bankCode,
    };
  }
}
