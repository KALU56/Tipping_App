import 'package:flutter/material.dart';
import 'package:tip_employee/src/shared/data/models/tip_model.dart';


class TipList extends StatelessWidget {
  final List<Tip> tips;

  const TipList({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    if (tips.isEmpty) {
      return const Center(child: Text('No tips found'));
    }

    return ListView.separated(
      itemCount: tips.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final tip = tips[index];
        return ListTile(
          title: Text(tip.customerName),
          subtitle: Text('Amount: \$${tip.amount}'),
          trailing: Text(
            '${tip.date.day}/${tip.date.month}/${tip.date.year} ${tip.time.format(context)}',
          ),
        );
      },
    );
  }
}
