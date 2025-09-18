// lib/src/domain/models/bank_account_request.dart
import 'bank_model.dart';

class BankAccountRequest {
  final String? accountName;
  final String? accountNumber;
  final String? bankCode;

  BankAccountRequest({
    this.accountName,
    this.accountNumber,
    this.bankCode,
  });

  // Create request from Bank model
  factory BankAccountRequest.fromBank({
    required String accountName,
    required String accountNumber,
    required Bank bank,
  }) {
    return BankAccountRequest(
      accountName: accountName,
      accountNumber: accountNumber,
      bankCode: bank.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accountName != null) "account_name": accountName,
      if (accountNumber != null) "account_number": accountNumber,
      if (bankCode != null) "bank_code": bankCode,
    };
  }
}
