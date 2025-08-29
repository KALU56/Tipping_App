import 'package:flutter/material.dart';
import 'package:tip/features/givetip/presentation/screens/payment_page.dart';
import '../../../../models/employee.dart';
import 'employee_selection_screen.dart';

class TipConfirmationScreen extends StatelessWidget {
  final Employee employee;
  final double tipAmount;
  final String customerName;
  final VoidCallback? toggleTheme;

  const TipConfirmationScreen({
    super.key,
    required this.employee,
    required this.tipAmount,
    this.customerName = "Anonymous Customer",
    this.toggleTheme, // pass it to allow returning to EmployeeSelectionScreen
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Tip Confirmation')),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: size.width * 0.2,
              ),
              SizedBox(height: size.height * 0.03),

              // Employee picture
              CircleAvatar(
                radius: size.width * 0.12,
                backgroundImage: NetworkImage(employee.pictureUrl),
              ),
              SizedBox(height: size.height * 0.015),

              // Employee name
              Text(
                employee.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.06,
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Tip info card
              Card(
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.01,
                ),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: theme.cardColor,
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    children: [
                      Text(
                        'Amount tipped: \$${tipAmount.toStringAsFixed(2)}',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        'Tip given by $customerName',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color
                              ?.withOpacity(0.6),
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),

          

              // Return Home button
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(Icons.home),
                label: const Text('Return Home'),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, size.height * 0.06),
                  textStyle: TextStyle(fontSize: size.width * 0.045),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
