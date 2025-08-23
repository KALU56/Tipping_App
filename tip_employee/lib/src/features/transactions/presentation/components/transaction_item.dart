part of '../../transaction.dart';



class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: transaction.color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(transaction.icon, color: transaction.color),
        ),
        title: Text(transaction.title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(transaction.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(
          '\$${transaction.amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: transaction.isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
