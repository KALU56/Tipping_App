// loading_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tip_/tip/presentation/bloc/tip_bloc.dart';
import 'package:tip_/tip/presentation/bloc/tip_event.dart';
import 'package:tip_/tip/presentation/bloc/tip_state.dart';
import 'package:tip_/tip/presentation/screens/tip_confirmation_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String employeeId;
  final String employeeName;
  final double tipAmount;

  const LoadingScreen({
    super.key,
    required this.employeeId,
    required this.employeeName,
    required this.tipAmount,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the tip submission when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TipBloc>().add(TipSubmitted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TipBloc, TipState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // Navigate to success screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => TipConfirmationScreen(
                employeeId: widget.employeeId,
                employeeName: widget.employeeName,
                tipAmount: widget.tipAmount,
              ),
            ),
          );
        } else if (state.errorMessage != null) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: const CircularProgressIndicator(strokeWidth: 5),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  tr('processing_payment'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Icon(
                  Icons.monetization_on,
                  size: MediaQuery.of(context).size.width * 0.1,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}