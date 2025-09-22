import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tip_give/tip/presentation/screens/moble_scanner.dart';
import '../bloc/tip_bloc.dart';
import 'payment_page.dart';

class EmployeeSelectionScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const EmployeeSelectionScreen({super.key, required this.toggleTheme});

  @override
  State<EmployeeSelectionScreen> createState() => _EmployeeSelectionScreenState();
}

class _EmployeeSelectionScreenState extends State<EmployeeSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _goToPayment(String employeeId, String employeeName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentPage(employeeId: employeeId, employeeName: employeeName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'.tr()), // localized
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark ? Icons.wb_sunny : Icons.nightlight_round,
            ),
            onPressed: widget.toggleTheme,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'en') context.setLocale(const Locale('en'));
              if (value == 'am') context.setLocale(const Locale('am'));
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'am', child: Text('አማርኛ')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // more breathing space
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // buttons full width
            children: [
              // Top illustration
              Center(
                child: Image.asset(
                  'assets/images/gift.png',
                  height: size.height * 0.28,
                ),
              ),
              SizedBox(height: size.height * 0.04),

              // Scan QR section
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final scannedValue = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
                  );
                  if (scannedValue != null) {
                    _goToPayment(scannedValue, "Employee $scannedValue");
                  }
                },
                icon: const Icon(Icons.qr_code_scanner, size: 22),
                label: Text(
                  'scan_qr'.tr(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // Search field
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'enter_employee'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),

              SizedBox(height: size.height * 0.025),

              // Proceed button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final id = _searchController.text.trim();
                  if (id.isNotEmpty) _goToPayment(id, "Employee $id");
                },
                child: Text(
                  'proceed_payment'.tr(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
