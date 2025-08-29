import 'package:flutter/material.dart';
import '../../../../models/employee.dart';
import '../widgets/tip_input_field.dart';
import 'loading_screen.dart';

class PaymentPage extends StatefulWidget {
  final Employee employee;

  const PaymentPage({super.key, required this.employee});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _tipController = TextEditingController();
  String? _errorText;

  void _validateAndProceed() {
    final text = _tipController.text.trim();
    final tipAmount = double.tryParse(text);

    if (tipAmount == null || tipAmount <= 0) {
      setState(() {
        _errorText = "Please enter a valid amount";
      });
      return;
    }

    setState(() {
      _errorText = null;
    });

    _showConfirmDialog(context, tipAmount);
  }

  void _showConfirmDialog(BuildContext context, double amount) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Tip'),
        content: Text(
          'Are you sure you want to tip \$${amount.toStringAsFixed(2)} to ${widget.employee.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LoadingScreen(
                    employee: widget.employee,
                    tipAmount: amount,
                  ),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // ✅ dismiss keyboard
      child: Scaffold(
        appBar: AppBar(title: const Text('Payment')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.employee.pictureUrl),
              ),
              const SizedBox(height: 10),
              Text(
                widget.employee.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(widget.employee.workspace),
              if (widget.employee.note != null)
                Text(widget.employee.note!, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              /// Tip Input
              TipInputField(
                controller: _tipController,
                // errorText: _errorText, // ✅ inline error
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndProceed,
                child: const Text('Send Tip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
