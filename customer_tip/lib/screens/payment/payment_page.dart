import 'package:flutter/material.dart';
import '../../models/employee.dart';
import '../../widgets/tip_input_field.dart';
import '../loading/loading_screen.dart';

class PaymentPage extends StatefulWidget {
  final Employee employee;

  PaymentPage({required this.employee});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _tipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.employee.pictureUrl),
            ),
            SizedBox(height: 10),
            Text(widget.employee.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(widget.employee.workspace),
            if (widget.employee.note != null) Text(widget.employee.note!),
            SizedBox(height: 20),
            TipInputField(controller: _tipController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double tipAmount = double.tryParse(_tipController.text) ?? 0;
                if (tipAmount > 0) {
                  _showConfirmDialog(context, tipAmount);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Enter a valid tip amount")));
                }
              },
              child: Text('Pay / Confirm'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, double amount) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm Tip'),
        content:
            Text('Are you sure you want to tip \$${amount.toStringAsFixed(2)} to ${widget.employee.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          TextButton(
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
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
