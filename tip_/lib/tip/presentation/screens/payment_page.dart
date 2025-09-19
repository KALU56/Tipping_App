import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_/tip/presentation/bloc/tip_bloc.dart';
import 'package:tip_/tip/presentation/bloc/tip_event.dart';
import 'package:tip_/tip/presentation/bloc/tip_state.dart';
import 'package:tip_/tip/presentation/screens/chapa_webview_payment.dart';

class PaymentPage extends StatefulWidget {
  final String employeeId;
  final String employeeName;

  const PaymentPage({
    super.key,
    required this.employeeId,
    required this.employeeName,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submitTip() {
    final amount = _amountController.text.trim();
    if (amount.isNotEmpty) {
      context.read<TipBloc>().add(
            InitializeTipEvent(
              employeeId: widget.employeeId,
              amount: amount,
            ),
          );
    }
  }

  void _openCheckoutLink(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChapaWebviewPayment(checkoutUrl: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Send Tip to ${widget.employeeName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<TipBloc, TipState>(
          listener: (context, state) {
            if (state is TipSuccess) {
              _openCheckoutLink(state.response.link);
            } else if (state is TipFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${state.message}")),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Enter Tip Amount",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: size.height * 0.02),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                ElevatedButton(
                  onPressed: state is TipLoading ? null : _submitTip,
                  child: state is TipLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Proceed to Pay"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
