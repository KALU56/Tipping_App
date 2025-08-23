// lib/src/features/home/presentation/components/recent_tips_list.dart
part of '../../home.dart';

class RecentTipsList extends StatelessWidget {
  const RecentTipsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        final amount = (index + 1) * 5.0;
        final minutesAgo = (index + 1) * 2;
        
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.blue),
            ),
            title: Text(
              'Customer ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.w500)
            ),
            subtitle: Text(
              '$minutesAgo minutes ago',
              style: const TextStyle(fontSize: 12, color: Colors.grey)
            ),
            trailing: Text(
              '\$$amount',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }
}