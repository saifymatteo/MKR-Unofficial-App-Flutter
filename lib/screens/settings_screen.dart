import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Page'));
  }
}
