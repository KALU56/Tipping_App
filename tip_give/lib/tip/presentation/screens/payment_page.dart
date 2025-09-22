import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/tip_bloc.dart';
import '../bloc/tip_event.dart';
import '../bloc/tip_state.dart';
import 'chapa_webview_payment.dart';

class PaymentPage extends StatefulWidget {
  final String employeeId;
  final String employeeName;

  const PaymentPage({super.key, required this.employeeId, required this.employeeName});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _amountController = TextEditingController();

  void _submitTip() {
    final amount = _amountController.text.trim();
    if (amount.isNotEmpty) {
      context.read<TipBloc>().add(
            InitializeTipEvent(employeeId: widget.employeeId, amount: amount),
          );
    }
  }

  void _openCheckoutLink(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChapaWebviewPayment(checkoutUrl: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('send_tip_to'.tr(args: [widget.employeeName])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<TipBloc, TipState>(
          listener: (context, state) {
            if (state is TipSuccess) {
              _openCheckoutLink(state.response.link);
            }
            if (state is TipFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('error_message'.tr(args: [state.message]))),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'enter_tip_amount'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: size.height * 0.02),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'amount'.tr(),
                    prefixIcon: const Icon(Icons.attach_money),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                ElevatedButton(
                  onPressed: state is TipLoading ? null : _submitTip,
                  child: state is TipLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('proceed_to_pay'.tr()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
