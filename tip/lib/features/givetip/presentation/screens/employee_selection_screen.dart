import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tip/features/givetip/presentation/screens/moble_scanner.dart';
import '../../../../models/employee.dart';
import 'payment_page.dart';


class EmployeeSelectionScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const EmployeeSelectionScreen({super.key, required this.toggleTheme});

  @override
  State<EmployeeSelectionScreen> createState() => _EmployeeSelectionScreenState();
}

class _EmployeeSelectionScreenState extends State<EmployeeSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'.tr()),
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
            onPressed: widget.toggleTheme,
          ),
          // Language switcher
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'en') context.setLocale(Locale('en'));
              if (value == 'am') context.setLocale(Locale('am'));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'am', child: Text('አማርኛ')),
            ],
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/gift.png',
                  height: size.height * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: size.height * 0.02),
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
                label: Text('scan_qr'.tr()),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'enter_employee'.tr(),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              SizedBox(height: size.height * 0.015),
              ElevatedButton(
                onPressed: () {
                  final employeeName = _searchController.text.isEmpty
                      ? "John Doe"
                      : _searchController.text;
                  _goToPayment(employeeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                ),
                child: Text('proceed_payment'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
