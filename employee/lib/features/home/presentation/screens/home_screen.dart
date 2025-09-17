part of '../../home.dart';

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            height: 100,
            color: AppTheme.primaryColor,
          ),
          SafeArea(
            child: Column(
              children: [
        
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const _HeaderRow(),
                ),

                const _PromotionalBanner(),

                const _RecentTipsHeader(),
                const SizedBox(height: 8),

              
           
              ],
            ),
          ),
        ],
      ),
    );
  }
}
