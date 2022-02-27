import 'package:flutter/material.dart';

class TelephoneScreen extends StatelessWidget {
  const TelephoneScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Telephone Page'));
  }
}
