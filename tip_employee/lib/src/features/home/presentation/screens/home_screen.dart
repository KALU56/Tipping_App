// lib/src/features/home/presentation/screens/home_screen.dart
part of '../../home.dart';

class _HomeScreen extends StatefulWidget {
  final TipRepository repository;

  const _HomeScreen({required this.repository});

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            const _HeaderRow(),
            const _PromotionalBanner(),
            const _RecentTipsHeader(),
            const SizedBox(height: 8),
            Expanded(child: RecentTipsList(repository: widget.repository)),
          ],
        ),
      ),
    );
  }
}
