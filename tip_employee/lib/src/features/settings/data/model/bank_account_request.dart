// lib/src/domain/models/bank_account_request.dart
class BankAccountRequest {
  final String? accountName;
  final String? accountNumber;
  final String? bankCode; 

  BankAccountRequest({
    this.accountName,
    this.accountNumber,
    this.bankCode,
  });

  
  Map<String, dynamic> toJson() {
    return {
      if (accountName != null) "account_name": accountName,
      if (accountNumber != null) "account_number": accountNumber,
      if (bankCode != null) "bank_code": bankCode,
    };
  }
}
