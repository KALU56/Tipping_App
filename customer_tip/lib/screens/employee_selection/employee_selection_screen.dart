import 'package:flutter/material.dart';
import '../../models/employee.dart';
import '../payment/payment_page.dart';

class EmployeeSelectionScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                print("Scan QR pressed");
              },
              child: Text('Scan QR code'),
            ),
            ElevatedButton(
              onPressed: () {
                print("Upload QR pressed");
              },
              child: Text('Upload QR file'),
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter Employee ID or Name',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String employeeName = _searchController.text.isEmpty
                    ? "John Doe"
                    : _searchController.text;

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
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
