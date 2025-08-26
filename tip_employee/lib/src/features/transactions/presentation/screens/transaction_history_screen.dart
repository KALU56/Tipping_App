// lib/src/features/transactions/presentation/screens/transaction_history_screen.dart
part of '../../transaction.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TransactionRepository _repository = MockTransactionRepository();
  String _searchQuery = '';
  int _selectedFilter = 0;

  List<String> get _filters => ['Today', 'This Week', 'This Month', 'This Year'];

  List<TransactionModel> get _transactions {
    final all = _repository.getTransactions();
    return all.where((tx) =>
        tx.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Padding(
              padding: const EdgeInsets.all(16),
              child: BalanceCard(
                totalBalance: _repository.getTotalBalance(),
                income: _repository.getTotalIncome(),
                expenses: _repository.getTotalExpenses(),
              ),
            ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return TransactionItem(transaction: _transactions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
