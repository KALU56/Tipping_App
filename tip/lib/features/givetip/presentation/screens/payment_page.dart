import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../models/employee.dart';
import '../widgets/tip_input_field.dart';
import 'loading_screen.dart';

class PaymentPage extends StatefulWidget {
  final Employee employee;
  const PaymentPage({super.key, required this.employee});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _tipController = TextEditingController();
  String? _errorText;

  void _validateAndProceed() {
    final text = _tipController.text.trim();
    final tipAmount = double.tryParse(text);

    if (tipAmount == null || tipAmount <= 0) {
      setState(() {
        _errorText = tr('enter_valid_amount'); // localized error
      });
      return;
    }

    setState(() {
      _errorText = null;
    });

    _showConfirmDialog(context, tipAmount);
  }

  void _showConfirmDialog(BuildContext context, double amount) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('confirm_tip'.tr()),
        content: Text(
          tr('confirm_tip_message', args: [
            amount.toStringAsFixed(2),
            widget.employee.name
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LoadingScreen(
                    employee: widget.employee,
                    tipAmount: amount,
                  ),
                ),
              );
            },
            child: Text('confirm'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('send_tip'.tr())),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: size.width * 0.12,
                backgroundImage: NetworkImage(widget.employee.pictureUrl),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                widget.employee.name,
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Text(
                widget.employee.workspace,
                style: TextStyle(fontSize: size.width * 0.045, color: Colors.grey[700]),
              ),
              if (widget.employee.note != null)
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.005),
                  child: Text(
                    widget.employee.note!,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              SizedBox(height: size.height * 0.04),
              TipInputField(
                controller: _tipController,
                errorText: _errorText,
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndProceed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  ),
                  child: Text('send_tip'.tr(), style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
