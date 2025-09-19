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
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => print("Loading $url"),
          onPageFinished: (url) => setState(() => _isLoading = false),
          onNavigationRequest: (request) {
            print("Navigating to ${request.url}");
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chapa Payment"),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
