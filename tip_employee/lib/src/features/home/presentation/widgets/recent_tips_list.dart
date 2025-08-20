import 'package:flutter/material.dart';

class RecentTipsList extends StatelessWidget {
  const RecentTipsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/user_placeholder.png'),
          ),
          title: Text('Customer ${index + 1}'),
          subtitle: Text('2${index + 1} minutes ago'),
          trailing: Text('\$${(index + 1) * 5}.00',
              style: Theme.of(context).textTheme.titleMedium),
        );
      },
    );
  }
}