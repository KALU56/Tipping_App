// payment_page.dart (modified)
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tip_/tip/presentation/screens/chapa_webview_payment.dart';
import '../widgets/tip_input_field.dart';

class PaymentPage extends StatefulWidget {
  final String employeeId;
  final String employeeName;
  
  const PaymentPage({
    super.key, 
    required this.employeeId, 
    required this.employeeName
  });

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
        _errorText = tr('enter_valid_amount');
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
            widget.employeeName
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
              // Navigate directly to Chapa WebView payment
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChapaWebViewPayment(
                    employeeId: widget.employeeId,
                    employeeName: widget.employeeName,
                    amount: amount,
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
                backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
                child: widget.employeeId.isNotEmpty 
                  ? null 
                  : Icon(Icons.person, size: size.width * 0.1),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                widget.employeeName,
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Text(
                'ID: ${widget.employeeId}',
                style: TextStyle(fontSize: size.width * 0.045, color: Colors.grey[700]),
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