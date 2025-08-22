// features/transactions/presentation/screens/transaction_history_screen.dart
import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';

class Transaction {
  final String id;
  final String customerName;
  final double amount;
  final DateTime date;
  final String type; // 'tip', 'withdrawal', 'bonus'
  final String status; // 'completed', 'pending', 'failed'

  Transaction({
    required this.id,
    required this.customerName,
    required this.amount,
    required this.date,
    required this.type,
    required this.status,
  });
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      customerName: 'John Doe',
      amount: 15.50,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: 'tip',
      status: 'completed',
    ),
    Transaction(
      id: '2',
      customerName: 'Sarah Smith',
      amount: 25.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: 'tip',
      status: 'completed',
    ),
    Transaction(
      id: '3',
      customerName: 'Mike Johnson',
      amount: 10.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: 'tip',
      status: 'completed',
    ),
    Transaction(
      id: '4',
      customerName: 'Withdrawal',
      amount: -100.00,
      date: DateTime.now().subtract(const Duration(days: 4)),
      type: 'withdrawal',
      status: 'completed',
    ),
    Transaction(
      id: '5',
      customerName: 'Weekly Bonus',
      amount: 50.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
      type: 'bonus',
      status: 'completed',
    ),
  ];

  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = _filterTransactions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Total Balance Summary
          _buildBalanceSummary(),
          
          // Transactions List
          Expanded(
            child: filteredTransactions.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      return _buildTransactionCard(transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSummary() {
    final totalEarned = _transactions
        .where((t) => t.amount > 0)
        .fold(0.0, (sum, item) => sum + item.amount);
    
    final totalWithdrawn = _transactions
        .where((t) => t.amount < 0)
        .fold(0.0, (sum, item) => sum + item.amount);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Total Earned', '\$${totalEarned.toStringAsFixed(2)}'),
          _buildSummaryItem('Total Withdrawn', '\$${totalWithdrawn.abs().toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getTransactionColor(transaction.type),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getTransactionIcon(transaction.type),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          transaction.customerName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${transaction.date.day}/${transaction.date.month}/${transaction.date.year} • ${transaction.status}',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Text(
          '${transaction.amount > 0 ? '+' : ''}\$${transaction.amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: transaction.amount > 0 ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your transaction history will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case 'tip':
        return Icons.attach_money;
      case 'withdrawal':
        return Icons.account_balance_wallet;
      case 'bonus':
        return Icons.card_giftcard;
      default:
        return Icons.receipt;
    }
  }

  Color _getTransactionColor(String type) {
    switch (type) {
      case 'tip':
        return Colors.green;
      case 'withdrawal':
        return Colors.orange;
      case 'bonus':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  List<Transaction> _filterTransactions() {
    if (_selectedFilter == 'all') return _transactions;
    return _transactions.where((t) => t.type == _selectedFilter).toList();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Transactions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('All', 'all'),
              _buildFilterOption('Tips', 'tip'),
              _buildFilterOption('Withdrawals', 'withdrawal'),
              _buildFilterOption('Bonuses', 'bonus'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: _selectedFilter == value
          ? const Icon(Icons.check, color: AppTheme.primaryColor)
          : null,
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
        Navigator.pop(context);
      },
    );
  }
}