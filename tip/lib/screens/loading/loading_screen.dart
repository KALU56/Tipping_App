import 'package:flutter/material.dart';
import '../../models/employee.dart';
import '../../services/chapa_service.dart';
import '../tip_confirmation/tip_confirmation_screen.dart';

class LoadingScreen extends StatefulWidget {
  final Employee employee;
  final double tipAmount;

  LoadingScreen({required this.employee, required this.tipAmount});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final ChapaService _chapaService = ChapaService();

  @override
  void initState() {
    super.initState();
    _processPayment();
  }

  void _processPayment() async {
    bool success = await _chapaService.processPayment(widget.tipAmount);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Processing payment...'),
          ],
        ),
      ),
    );
  }
}
