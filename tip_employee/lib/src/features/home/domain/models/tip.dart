// lib/src/features/home/domain/models/tip.dart
class Tip {
  final String customerName;
  final double amount;
  final int minutesAgo;

  Tip({
    required this.customerName,
    required this.amount,
    required this.minutesAgo,
  });
}
