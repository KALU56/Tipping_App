// features/withdraw/presentation/screens/withdraw_screen.dart
import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedMethod = 'bank_transfer';
  double _availableBalance = 345.67;
  double _withdrawalAmount = 0.0;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'bank_transfer',
      'name': 'Bank Transfer',
      'icon': Icons.account_balance,
      'fee': 1.50,
      'processingTime': '2-3 business days',
    },
    {
      'id': 'paypal',
      'name': 'PayPal',
      'icon': Icons.payment,
      'fee': 2.00,
      'processingTime': 'Instant',
    },
    {
      'id': 'venmo',
      'name': 'Venmo',
      'icon': Icons.account_balance_wallet,
      'fee': 1.00,
      'processingTime': 'Instant',
    },
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMethod = _paymentMethods.firstWhere(
      (method) => method['id'] == _selectedMethod,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw Funds'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available Balance
            _buildBalanceCard(),
            const SizedBox(height: 24),

            // Amount Input
            _buildAmountInput(),
            const SizedBox(height: 24),

            // Payment Methods
            _buildPaymentMethods(),
            const SizedBox(height: 24),

            // Withdrawal Details
            _buildWithdrawalDetails(selectedMethod),
            const SizedBox(height: 32),

            // Withdraw Button
            _buildWithdrawButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Available Balance',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$$_availableBalance',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Withdrawal Amount',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: '\$',
            hintText: 'Enter amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.attach_money),
              onPressed: _setMaxAmount,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _withdrawalAmount = double.tryParse(value) ?? 0.0;
            });
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Minimum withdrawal: \$10.00',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ..._paymentMethods.map((method) => _buildPaymentMethodCard(method)),
      ],
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: _selectedMethod == method['id']
          ? AppTheme.primaryColor.withOpacity(0.1)
          : null,
      child: ListTile(
        leading: Icon(
          method['icon'] as IconData,
          color: AppTheme.primaryColor,
        ),
        title: Text(method['name'] as String),
        subtitle: Text(
          'Fee: \$${method['fee']} • ${method['processingTime']}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: _selectedMethod == method['id']
            ? const Icon(Icons.check_circle, color: AppTheme.primaryColor)
            : null,
        onTap: () {
          setState(() {
            _selectedMethod = method['id'] as String;
          });
        },
      ),
    );
  }

  Widget _buildWithdrawalDetails(Map<String, dynamic> method) {
    final fee = method['fee'] as double;
    final totalReceived = _withdrawalAmount - fee;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Withdrawal Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Amount', '\$$_withdrawalAmount'),
            _buildDetailRow('Fee', '-\$$fee'),
            const Divider(),
            _buildDetailRow(
              'You will receive',
              '\$${totalReceived.toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 8),
            Text(
              'Processing time: ${method['processingTime']}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? AppTheme.primaryColor : Colors.black,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawButton() {
    final isValid = _withdrawalAmount >= 10.0 && _withdrawalAmount <= _availableBalance;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid ? _processWithdrawal : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Withdraw Funds',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _setMaxAmount() {
    setState(() {
      _amountController.text = _availableBalance.toStringAsFixed(2);
      _withdrawalAmount = _availableBalance;
    });
  }

  void _processWithdrawal() {
    if (_withdrawalAmount < 10.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimum withdrawal amount is \$10.00')),
      );
      return;
    }

    if (_withdrawalAmount > _availableBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient balance')),
      );
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Withdrawal'),
          content: Text(
            'Are you sure you want to withdraw \$$_withdrawalAmount?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessDialog();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Withdrawal Successful'),
          content: const Text('Your withdrawal request has been processed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}