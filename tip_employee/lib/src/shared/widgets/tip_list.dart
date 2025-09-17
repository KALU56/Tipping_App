import 'package:flutter/material.dart';
import 'package:tip_employee/src/shared/data/models/tip.dart';


class TipList extends StatelessWidget {
  final List<TipModel> tips;

  const TipList({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (tips.isEmpty) {
      return Center(
        child: Text(
          'No tips found',
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final tip = tips[index];

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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              'Amount: \$${tip.netAmount?.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              tip.date.toLocal().toString(),
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
