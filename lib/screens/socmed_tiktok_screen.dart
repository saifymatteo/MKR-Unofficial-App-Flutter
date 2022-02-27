import 'package:flutter/material.dart';

class SocmedTikTokScreen extends StatelessWidget {
  const SocmedTikTokScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('TikTok Page'));
  }
}