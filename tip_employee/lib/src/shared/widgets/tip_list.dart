import 'package:flutter/material.dart';
import 'package:tip_employee/src/features/tip/data/models/transaction_model.dart';


class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No transactions found',
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];

        final formattedDate = tx.createdAt != null
            ? "${tx.createdAt!.day.toString().padLeft(2, '0')}-"
              "${tx.createdAt!.month.toString().padLeft(2, '0')}-"
              "${tx.createdAt!.year} "
              "${tx.createdAt!.hour.toString().padLeft(2, '0')}:"
              "${tx.createdAt!.minute.toString().padLeft(2, '0')}"
            : "N/A";

        final amount = tx.amount != null ? "\$${tx.amount!.toStringAsFixed(2)}" : "N/A";

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.monetization_on, color: Colors.white),
            ),
            title: Text(
              'Amount: $amount',
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              'Time: $formattedDate',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
              ),
            ),
          ),
        );
      },
    );
  }
}
