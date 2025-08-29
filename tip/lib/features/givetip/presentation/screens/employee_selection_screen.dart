import 'package:flutter/material.dart';
import 'package:tip/features/givetip/presentation/screens/moble_scanner.dart';
import '../../../../models/employee.dart';
import 'payment_page.dart';

class EmployeeSelectionScreen extends StatefulWidget {
  final VoidCallback toggleTheme; // callback to switch theme
  const EmployeeSelectionScreen({super.key, required this.toggleTheme});

  @override
  State<EmployeeSelectionScreen> createState() =>
      _EmployeeSelectionScreenState();
}

class _EmployeeSelectionScreenState extends State<EmployeeSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello Customer!',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Select an employee to tip:',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // QR scanner button
            ElevatedButton.icon(
              onPressed: () async {
                final scannedValue = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
                );

                if (scannedValue != null) {
                  _goToPayment(scannedValue.toString());
                }
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan Employee QR'),
            ),
            const SizedBox(height: 20),

            // Manual search field
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Enter Employee ID or Name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                final employeeName = _searchController.text.isEmpty
                    ? "John Doe"
                    : _searchController.text;
                _goToPayment(employeeName);
              },
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }

  void _goToPayment(String employeeName) {
    final employee = Employee(
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
