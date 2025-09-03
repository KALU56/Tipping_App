import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tip_bloc.dart';
import 'tip_event.dart';
import 'tip_state.dart';
import 'tip_repository_impl.dart';
import 'tip_confirmation_screen.dart';

class PaymentPage extends StatefulWidget {
  final String employeeId;
  const PaymentPage({super.key, required this.employeeId});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _tipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: TipBloc(TipRepositoryImpl()),
      child: BlocConsumer<TipBloc, TipState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => TipConfirmationScreen(
                  employeeId: state.employeeId,
                  tipAmount: state.tipAmount,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Send Tip')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Employee ID: ${widget.employeeId}'),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _tipController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Tip Amount'),
                  ),
                  const SizedBox(height: 16),
                  state.isSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            final amount =
                                double.tryParse(_tipController.text.trim()) ?? 0;
                            context.read<TipBloc>().add(TipAmountEntered(amount));
                            context.read<TipBloc>().add(TipSubmitted());
                          },
                          child: const Text('Submit Tip'),
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
