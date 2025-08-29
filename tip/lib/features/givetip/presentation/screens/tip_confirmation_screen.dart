import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../models/employee.dart';

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
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('tip_confirmation'.tr())),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: size.width * 0.2),
              SizedBox(height: size.height * 0.03),
              CircleAvatar(
                radius: size.width * 0.12,
                backgroundImage: NetworkImage(employee.pictureUrl),
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                employee.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.06,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Card(
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.01,
                ),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: theme.cardColor,
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    children: [
                      Text(
                        tr('amount_tipped', args: [tipAmount.toStringAsFixed(2)]),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        tr('tip_given_by', args: [customerName]),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              OutlinedButton.icon(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                icon: const Icon(Icons.home),
                label: Text('return_home'.tr()),
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
