// chapa_webview_payment.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:easy_localization/easy_localization.dart';

class ChapaWebViewPayment extends StatefulWidget {
  final String employeeId;
  final double amount;
  final String employeeName;

  const ChapaWebViewPayment({
    super.key,
    required this.employeeId,
    required this.amount,
    required this.employeeName,
  });

  @override
  State<ChapaWebViewPayment> createState() => _ChapaWebViewPaymentState();
}

class _ChapaWebViewPaymentState extends State<ChapaWebViewPayment> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _paymentSuccess = false;

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
  }

  void _initializeWebViewController() {
    // Set up platform-specific creation parameters
    late final PlatformWebViewControllerCreationParams params;
    
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params);

    // Enable platform-specific features
    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    // Configure the controller
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          setState(() => _isLoading = true);
        },
        onPageFinished: (String url) {
          setState(() => _isLoading = false);
        },
        onWebResourceError: (WebResourceError error) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('payment_error'.tr())),
          );
        },
        onUrlChange: (UrlChange change) {
          // Check if payment was successful
          if (change.url?.contains('/success') ?? false) {
            setState(() => _paymentSuccess = true);
            _handlePaymentSuccess();
          } else if (change.url?.contains('/error') ?? false) {
            _handlePaymentError();
          }
        },
      ))
      ..loadRequest(Uri.parse(_generatePaymentUrl()));
  }

  String _generatePaymentUrl() {
    // Create a unique transaction reference
    final txRef = 'tip_${widget.employeeId}_${DateTime.now().millisecondsSinceEpoch}';
    
    // Construct the Chapa payment URL with parameters
    return 'https://checkout.chapa.co/checkout/web/payment/SC-0jnZQJSSsQAr?'
        'amount=${widget.amount}'
        '&currency=ETB'
        '&tx_ref=$txRef'
        '&customer[name]=Customer'
        '&customer[email]=customer@example.com'
        '&customization[title]=Tip Payment'
        '&customization[description]=Tip for ${widget.employeeName}'
        '&metadata[employee_id]=${widget.employeeId}'
        '&metadata[employee_name]=${Uri.encodeComponent(widget.employeeName)}';
  }

  void _handlePaymentSuccess() {
    // Payment was successful
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('payment_successful'.tr())),
    );
    
    // Navigate back to home after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
  }

  void _handlePaymentError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('payment_failed'.tr())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chapa_payment'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_paymentSuccess) {
              Navigator.popUntil(context, (route) => route.isFirst);
            } else {
              Navigator.pop(context);
            }
          },
        ),
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