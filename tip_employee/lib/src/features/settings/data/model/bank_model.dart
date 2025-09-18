import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';

class Bank {
  final String name;
  final String code; // Chapa bank ID

  Bank({required this.name, required this.code});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'] ?? 'Unknown Bank',
      code: json['id']?.toString() ?? '',
    );
  }

  @override
  String toString() => 'Bank(name: $name, code: $code)';

  static Bank? findByCode(List<Bank> banks, String code) {
    try {
      return banks.firstWhere((bank) => bank.code == code);
    } catch (e) {
      return null;
    }
  }

  BankAccountRequest toBankAccountRequest({
    required String accountName,
    required String accountNumber,
    required String businessName,
  }) {
    return BankAccountRequest.fromBank(
      accountName: accountName,
      accountNumber: accountNumber,
      bank: this,
      businessName: businessName,
    );
  }
}
