part of '../../home.dart';

class RecentTipsList extends StatelessWidget {
  final List<Tip> tips;

  const RecentTipsList({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
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
