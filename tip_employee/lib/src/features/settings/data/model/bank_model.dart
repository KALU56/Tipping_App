// lib/src/features/settings/data/model/bank_model.dart
class Bank {
  final String name;
  final String code; // This will store Chapa's bank ID (e.g., "130")

  Bank({required this.name, required this.code});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'] ?? 'Unknown Bank',
      code: json['id']?.toString() ?? '', // Use 'id' from Chapa API
    );
  }

  @override
  String toString() => 'Bank(name: $name, code: $code)';

  // Helper method to find bank by code
  static Bank? findByCode(List<Bank> banks, String code) {
    try {
      return banks.firstWhere((bank) => bank.code == code);
    } catch (e) {
      return null;
    }
  }
}