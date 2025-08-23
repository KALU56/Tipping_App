// lib/src/features/transactions/presentation/screens/transaction_history_screen.dart
part of '../../transaction.dart';

class _TransactionState extends State<TransactionHistoryScreen> {
  final List<String> _filters = ['Today', 'This Week', 'This Month', 'This Year'];
  String _searchQuery = '';

  // Sample transaction data
  final List<TransactionModel> _transactions = [
    TransactionModel(
      title: 'cbe ',
      amount: -85.30,
      date: 'Today, 10:30 AM',
      icon: Icons.person,
      color: Colors.green,
    ),
    TransactionModel(
      title: 'telebirr',
      amount: 2500.00,
      date: 'Today, 9:15 AM',
      icon: Icons.person,
      color: Colors.green,
    ),
    // … other transactions
  ];

  double get _totalBalance => 12458.00;
  double get _totalIncome => 9258.00;
  double get _totalExpenses => 2458.00;

  List<TransactionModel> get _filteredTransactions {
    return _transactions.where((transaction) {
      final matchesSearch = transaction.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance card
            Padding(
              padding: const EdgeInsets.all(16),
              child: BalanceCard(
                totalBalance: _totalBalance,
                income: _totalIncome,
                expenses: _totalExpenses,
              ),
            ),
            // Filter Chips
            FilterChips(
              filters: _filters,
              onFilterChanged: (index) {
              },
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
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
                itemCount: _filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = _filteredTransactions[index];
                  return TransactionItem(transaction: transaction);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
