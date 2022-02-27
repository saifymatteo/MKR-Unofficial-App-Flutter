import 'package:flutter/material.dart';

class MyKampusTvScreen extends StatelessWidget {
  const MyKampusTvScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('MyKampus TV Page'));
  }
}
