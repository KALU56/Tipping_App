part of '../../transaction.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expenses;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\$${totalBalance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildBalanceItem(
                  icon: Icons.arrow_downward,
                  title: 'Income',
                  amount: income,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                _buildBalanceItem(
                  icon: Icons.arrow_upward,
                  title: 'Expenses',
                  amount: expenses,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

Widget _buildBalanceItem({
  required IconData icon,
  required String title,
  required double amount,
  required MaterialColor color, // <-- MaterialColor here
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color[700]),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color[700],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

}