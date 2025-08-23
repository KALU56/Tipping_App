import 'package:flutter/material.dart';



class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionState();
}

class _TransactionState extends State<TransactionHistoryScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Today', 'This Week', 'This Month', 'This Year'];
  
  // Sample transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Grocery Shopping',
      'amount': -85.30,
      'date': 'Today, 10:30 AM',
      'icon': Icons.shopping_cart,
      'color': Colors.orange
    },
    {
      'title': 'Salary Deposit',
      'amount': 2500.00,
      'date': 'Today, 9:15 AM',
      'icon': Icons.account_balance,
      'color': Colors.green
    },
    {
      'title': 'Netflix Subscription',
      'amount': -15.99,
      'date': 'Yesterday, 2:00 PM',
      'icon': Icons.movie,
      'color': Colors.red
    },
    {
      'title': 'Coffee Shop',
      'amount': -5.75,
      'date': 'Yesterday, 8:30 AM',
      'icon': Icons.coffee,
      'color': Colors.brown
    },
    {
      'title': 'Freelance Work',
      'amount': 320.00,
      'date': 'Apr 12, 2023',
      'icon': Icons.work,
      'color': Colors.purple
    },
    {
      'title': 'Amazon Purchase',
      'amount': -42.50,
      'date': 'Apr 10, 2023',
      'icon': Icons.shopping_bag,
      'color': Colors.blue
    },
    {
      'title': 'Electric Bill',
      'amount': -78.34,
      'date': 'Apr 5, 2023',
      'icon': Icons.bolt,
      'color': Colors.amber
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '\$12,458.00',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.arrow_downward, color: Colors.green[700]),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '\$9,258.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.arrow_upward, color: Colors.red[700]),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Expenses',
                                    style: TextStyle(
                                      color: Colors.red[700],
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '\$2,458.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Filter Chips
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 16 : 8,
                      right: index == _filters.length - 1 ? 16 : 0,
                    ),
                    child: FilterChip(
                      label: Text(_filters[index]),
                      selected: _selectedFilter == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedFilter = selected ? index : 0;
                        });
                      },
                      selectedColor: Colors.blue[100],
                      checkmarkColor: Colors.blue,
                      labelStyle: TextStyle(
                        color: _selectedFilter == index ? Colors.blue : Colors.grey[700],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search transactions...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            
            // Transactions List Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Recent Transactions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            
            // Transactions List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  final bool isIncome = transaction['amount'] > 0;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: transaction['color'].withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          transaction['icon'],
                          color: transaction['color'],
                        ),
                      ),
                      title: Text(
                        transaction['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        transaction['date'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Text(
                        '\$${transaction['amount'].abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isIncome ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
     
    );
  }
}