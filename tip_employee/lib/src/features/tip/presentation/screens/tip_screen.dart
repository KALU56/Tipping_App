part of '../../tip.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends State<TransactionHistoryScreen> {

  String _searchQuery = '';
  int _selectedFilter = 0;

  List<String> get _filters => ['today', 'this week', 'this month', 'all'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                onChanged: (query) {
                  setState(() => _searchQuery = query);
                },
                onSearchChanged: (query) {
                  setState(() => _searchQuery = query);
                },
              ),
            ),

          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'All tip',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Filter Chips
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: FilterChips(
                  filters: _filters,
                  onFilterChanged: (index) {
                    setState(() => _selectedFilter = index);
                  },
              
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
