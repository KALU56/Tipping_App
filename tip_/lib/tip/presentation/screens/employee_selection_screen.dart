import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tip_/tip/data/repository_imp.dart';
import 'package:tip_/tip/presentation/bloc/tip_bloc.dart';
import 'package:tip_/tip/presentation/screens/moble_scanner.dart';
import 'tip_bloc.dart';
import 'tip_event.dart';
import 'tip_state.dart';
import 'payment_page.dart';
import 'tip_repository_impl.dart';

class EmployeeSelectionScreen extends StatefulWidget {
  const EmployeeSelectionScreen({super.key});

  @override
  State<EmployeeSelectionScreen> createState() => _EmployeeSelectionScreenState();
}

class _EmployeeSelectionScreenState extends State<EmployeeSelectionScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isScanning = false;

  void _scanQR(BuildContext context) async {
    if (_isScanning) return;
    _isScanning = true;

    final scannedId = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QRScannerScreen()),
    );

    _isScanning = false;

    if (scannedId != null) {
      context.read<TipBloc>().add(EmployeeIdEntered(scannedId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TipBloc(TipRepositoryImpl()),
      child: BlocConsumer<TipBloc, TipState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.employeeExists && state.employeeId.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaymentPage(employeeId: state.employeeId),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Select Employee')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _scanQR(context),
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Scan QR'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Enter Employee ID'),
                  ),
                  const SizedBox(height: 20),
                  state.isSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            final id = _controller.text.trim();
                            if (id.isNotEmpty) {
                              context.read<TipBloc>().add(EmployeeIdEntered(id));
                            }
                          },
                          child: const Text('Proceed'),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
