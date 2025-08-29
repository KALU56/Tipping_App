import 'package:flutter/material.dart';
import '../../models/employee.dart';
import '../employee_selection/employee_selection_screen.dart';

class TipConfirmationScreen extends StatelessWidget {
  final Employee employee;
  final double tipAmount;

  TipConfirmationScreen({required this.employee, required this.tipAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tip Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 40, backgroundImage: NetworkImage(employee.pictureUrl)),
            SizedBox(height: 10),
            Text(employee.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Amount tipped: \$${tipAmount.toStringAsFixed(2)}'),
            Text('Tip given by Customer Name'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => EmployeeSelectionScreen()),
                  (route) => false,
                );
              },
              child: Text('Send Another Tip'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Return Home'),
            ),
          ],
        ),
      ),
    );
  }
}
