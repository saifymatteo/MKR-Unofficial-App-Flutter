import 'package:flutter/material.dart';

class SocmedInstagramScreen extends StatelessWidget {
  const SocmedInstagramScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Instagram Page'));
  }
}
