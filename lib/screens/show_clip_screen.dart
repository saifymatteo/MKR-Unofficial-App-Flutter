import 'package:flutter/material.dart';

class ShowClipScreen extends StatelessWidget {
  const ShowClipScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Show Clip Page'));
  }
}
