import 'package:flutter/material.dart';

class SocmedTwitterScreen extends StatelessWidget {
  const SocmedTwitterScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Twitter Page'));
  }
}
