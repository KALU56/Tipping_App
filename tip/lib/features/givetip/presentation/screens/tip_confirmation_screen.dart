import 'package:flutter/material.dart';
import '../../../../models/employee.dart';
import 'employee_selection_screen.dart';

class TipConfirmationScreen extends StatelessWidget {
  final Employee employee;
  final double tipAmount;
  final String customerName;

  const TipConfirmationScreen({
    super.key,
    required this.employee,
    required this.tipAmount,
    this.customerName = "Anonymous Customer",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // access current theme

    return Scaffold(
      appBar: AppBar(title: const Text('Tip Confirmation')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 20),

              // Employee picture
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(employee.pictureUrl),
              ),
              const SizedBox(height: 10),

              // Employee name
              Text(
                employee.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Tip info card
              Card(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: theme.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Amount tipped: \$${tipAmount.toStringAsFixed(2)}',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tip given by $customerName',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

            
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(Icons.home),
                label: const Text('Return Home'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
