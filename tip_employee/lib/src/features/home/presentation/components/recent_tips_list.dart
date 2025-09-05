part of '../../home.dart';

class RecentTipsList extends StatefulWidget {
  final TipRepository repository;

  const RecentTipsList({super.key, required this.repository});

  @override
  State<RecentTipsList> createState() => _RecentTipsListState();
}

class _RecentTipsListState extends State<RecentTipsList> {
  late Future<List<Tip>> _tipsFuture;

  @override
  void initState() {
    super.initState();
    _tipsFuture = widget.repository.getRecentTips();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<Tip>>(
      future: _tipsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: theme.textTheme.bodyMedium,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No tips yet',
              style: theme.textTheme.bodyMedium,
            ),
          );
        }

        final tips = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tips.length,
          itemBuilder: (context, index) {
            final tip = tips[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: theme.cardColor, // ✅ adaptive
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
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              
              ),
            );
          },
        );
      },
    );
  }
}
