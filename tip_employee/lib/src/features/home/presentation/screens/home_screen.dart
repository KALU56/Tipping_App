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
      
      body: Stack(
        children: [
          // 1️⃣ Header background including status bar
          Container(
            height: 100, // total height for header + status bar
            color: AppTheme.primaryColor,
          ),
      SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor, // header background color
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16), // add top padding for status bar
              child: const _HeaderRow(),
            ),
            const _PromotionalBanner(),
            const _RecentTipsHeader(),
            const SizedBox(height: 8),
            Expanded(child: RecentTipsList(repository: widget.repository)),
          ],
        ),
      ),
        ],
      ),
    );
  }
}
