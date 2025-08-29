

import 'package:flutter/material.dart';
import 'package:tip/screens/moble_scanner/moble_scanner.dart';


import '../../models/employee.dart';
import '../payment/payment_page.dart';

class EmployeeSelectionScreen extends StatefulWidget {
  @override
  _EmployeeSelectionScreenState createState() =>
      _EmployeeSelectionScreenState();
}

class _EmployeeSelectionScreenState extends State<EmployeeSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome!')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hello Customer! \nSelect an employee to tip:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Row with QR buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               ElevatedButton.icon(
                  onPressed: () async {
                    final scannedValue = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BarcodeScannerScreen()),
                    );

                    if (scannedValue != null) {
                      _goToPayment(scannedValue.toString());
                    }
                  },
                  icon: Icon(Icons.mobile_screen_share),
                  label: Text('Mobile Scanner'),
                ),
         
              ],
            ),
            SizedBox(height: 20),

            // Manual search
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter Employee ID or Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                String employeeName = _searchController.text.isEmpty
                    ? "John Doe"
                    : _searchController.text;
                _goToPayment(employeeName);
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }

  void _goToPayment(String employeeName) {
    Employee employee = Employee(
      id: '1',
      name: employeeName,
      pictureUrl: 'https://via.placeholder.com/150',
      workspace: 'Café',
      note: 'Great service!',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentPage(employee: employee),
      ),
    );
  }
}

