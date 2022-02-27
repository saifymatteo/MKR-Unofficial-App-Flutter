import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LamanWebScreen extends StatelessWidget {
  LamanWebScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://mykampusradio.com/',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        controller.complete(webViewController);
      },
    );
  }
}
