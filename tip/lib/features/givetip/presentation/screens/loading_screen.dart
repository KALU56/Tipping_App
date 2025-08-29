import 'package:flutter/material.dart';
import '../../../../models/employee.dart';
import '../../../../services/chapa_service.dart';
import 'tip_confirmation_screen.dart';

class LoadingScreen extends StatefulWidget {
  final Employee employee;
  final double tipAmount;

  const LoadingScreen({
    super.key,
    required this.employee,
    required this.tipAmount,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final ChapaService _chapaService = ChapaService();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _processPayment();
  }

  Future<void> _processPayment() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final success = await _chapaService.processPayment(widget.tipAmount);

      if (!mounted) return;

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TipConfirmationScreen(
              employee: widget.employee,
              tipAmount: widget.tipAmount,
            ),
          ),
        );
      } else {
        _showError("Payment failed. Please try again.");
      }
    } catch (e) {
      if (mounted) _showError("An error occurred: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size; // for responsiveness

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular loading indicator
              SizedBox(
                height: size.width * 0.15,
                width: size.width * 0.15,
                child: const CircularProgressIndicator(strokeWidth: 5),
              ),
              SizedBox(height: size.height * 0.03),

              // Status text
              Text(
                'Processing your payment...',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Optional motivational icon
              Icon(
                Icons.monetization_on,
                size: size.width * 0.1,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
