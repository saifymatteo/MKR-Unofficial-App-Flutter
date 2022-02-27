import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class ShowClipScreen extends StatelessWidget {
  ShowClipScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.youtube.com/channel/UChVS7qvjXYiPuqYNtiAPOWw',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        controller.complete(webViewController);
      },
    );
  }
}
