import 'package:flutter/material.dart';

class TipConfirmationScreen extends StatelessWidget {
  final String employeeId;
  final double tipAmount;

  const TipConfirmationScreen({
    super.key,
    required this.employeeId,
    required this.tipAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tip Confirmation')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 16),
              Text('Tip sent to $employeeId', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 8),
              Text('Amount: \$${tipAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Return Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
