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
    if (_isProcessing) return; // ✅ Prevent multiple calls
    _isProcessing = true;

    try {
      final success = await _chapaService.processPayment(widget.tipAmount);

      if (!mounted) return; // ✅ avoid setState/navigation after dispose

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
      if (mounted) {
        _showError("An error occurred: $e");
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    Navigator.pop(context); // ✅ Go back to previous screen
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Processing payment...',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
