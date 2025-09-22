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
          // Top background color
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

BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    return _PromotionalBanner(transactions: state.allTips);
  },
),

                // Recent tips header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Recent Tips',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 8),

                // List of recent 5 tips
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

                      // Pass last 5 filtered transactions
                      return TransactionHistoryList(transactions: state.filteredTips);
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
