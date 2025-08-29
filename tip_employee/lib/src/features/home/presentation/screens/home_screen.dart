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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // ✅ adaptive

      body: Stack(
        children: [
          // 1️⃣ Header background including status bar
          Container(
            height: 100,
            color: AppTheme.primaryColor, // brand color, stays consistent
          ),
          SafeArea(
            child: Column(
              children: [
                // Header row
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 16),
                  child: const _HeaderRow(),
                ),

                // Promotional banner
                const _PromotionalBanner(),

                // Recent tips section header
                const _RecentTipsHeader(),
                const SizedBox(height: 8),

                // Recent tips list
                Expanded(
                  child: RecentTipsList(repository: widget.repository),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
