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
                // Header row with username from state
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

                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state.error != null) {
                        return Center(
                          child: Text('Error: ${state.error}'),
                        );
                      }

                      // Use TransactionList instead of TipList
                      return TransactionList(transactions: state.filteredTips);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
