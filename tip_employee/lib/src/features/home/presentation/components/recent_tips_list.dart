import 'package:flutter/material.dart';

class RecentTipsList extends StatelessWidget {
  const RecentTipsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 12), // space between tiles
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // padding inside each tile
          leading: const Icon(
            Icons.person, // Flutter icon instead of avatar
            size: 32,
            color: Colors.blueGrey,
          ),
          title: Text(
            'Customer ${index + 1}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            '${(index + 1) * 2} minutes ago',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          trailing: Text(
            '\$${(index + 1) * 5}.00',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
          ),
        );
      },
    );
  }
}
