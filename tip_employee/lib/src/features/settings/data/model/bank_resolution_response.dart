import 'package:flutter/material.dart';

class BankResolutionResponse {
  final String? accountName;
  final String? accountNumber;
  final String? bankCode;
  final String? bankName;
  final bool isValid;

  BankResolutionResponse({
    this.accountName,
    this.accountNumber,
    this.bankCode,
    this.bankName,
    this.isValid = false,
  });

  factory BankResolutionResponse.fromJson(Map<String, dynamic> json) {
    try {
      final data = json['data'] ?? {};
      final isValidResolution = data['account_name'] != null && 
                                data['account_name'].toString().isNotEmpty;
      
      return BankResolutionResponse(
        accountName: data['account_name'] as String?,
        accountNumber: data['account_number'] as String?,
        bankCode: data['bank_code']?.toString(),
        bankName: data['bank_name'] as String?,
        isValid: isValidResolution,
      );
    } catch (e) {
      debugPrint('❌ Error parsing BankResolutionResponse: $e');
      return BankResolutionResponse(isValid: false);
    }
  }

  @override
  String toString() {
    return 'BankResolutionResponse(accountName: $accountName, bankCode: $bankCode, isValid: $isValid)';
  }
}
