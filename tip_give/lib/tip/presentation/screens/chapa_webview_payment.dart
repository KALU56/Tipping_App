import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChapaWebviewPayment extends StatefulWidget {
  final String checkoutUrl;

  const ChapaWebviewPayment({super.key, required this.checkoutUrl});

  @override
  State<ChapaWebviewPayment> createState() => _ChapaWebviewPaymentState();
}

class _ChapaWebviewPaymentState extends State<ChapaWebviewPayment> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chapa Payment"),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageFinished: (_) {
                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
              )
              ..loadRequest(Uri.parse(widget.checkoutUrl)),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
