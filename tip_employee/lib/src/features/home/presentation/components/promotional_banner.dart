part of '../../home.dart';
class _PromotionalBanner extends StatelessWidget {
  final List<TransactionModel> transactions;

  const _PromotionalBanner({super.key, required this.transactions});

  double getTotal() => transactions.fold(0, (sum, tx) => sum + (tx.amount ?? 0));

  double getWeekTotal() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return transactions
        .where((tx) => tx.createdAt != null &&
                       tx.createdAt!.isAfter(startOfWeek) &&
                       tx.createdAt!.isBefore(now.add(const Duration(days: 1))))
        .fold(0, (sum, tx) => sum + (tx.amount ?? 0));
  }

  double getTodayTotal() {
    final now = DateTime.now();
    return transactions
        .where((tx) => tx.createdAt != null &&
                       tx.createdAt!.year == now.year &&
                       tx.createdAt!.month == now.month &&
                       tx.createdAt!.day == now.day)
        .fold(0, (sum, tx) => sum + (tx.amount ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 220,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/birr.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text('Total money earned',
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            Text('\$${getTotal().toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
       
            Text('Total today',
                style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            Text('\$${getTodayTotal().toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
