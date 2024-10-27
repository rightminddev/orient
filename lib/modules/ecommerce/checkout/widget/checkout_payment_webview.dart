import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/cart/controller/cart_controller.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewStack extends StatefulWidget {
  final String url;
  WebViewStack(this.url);

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}
class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  late WebViewController controller;
  late CheckoutControllerProvider checkoutControllerProvider;
  @override
  void initState() {
    super.initState();
    checkoutControllerProvider = CheckoutControllerProvider();
    controller = WebViewController()
      ..loadRequest(Uri.parse('${widget.url}'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                loadingPercentage = 0;
              });
            }
          },
          onProgress: (progress) {
            if (mounted) {
              setState(() {
                loadingPercentage = progress;
              });
            }
          },
          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                loadingPercentage = 100;
              });
            }
          },
          onNavigationRequest: (navigation) {
            final host = Uri.parse(navigation.url).host;
            if (navigation.url.contains('Status=success')) {
              if (mounted) {
                checkoutControllerProvider.setPaymentStatus('success');
                if (Navigator.of(context).canPop()) {
                  Navigator.pop(context);
                }
              }
            }
            else if (navigation.url.contains('status=failure')) {
              if (mounted) {
                checkoutControllerProvider.setPaymentStatus('failure');
                if (Navigator.of(context).canPop()) {
                  Navigator.pop(context);
                }
              }
            }
            if (host.contains('youtube.com')) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Blocking navigation to $host')),
                );
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (loadingPercentage < 100)
            LinearProgressIndicator(value: loadingPercentage / 100.0),
        ],
      ),
    );
  }
}
