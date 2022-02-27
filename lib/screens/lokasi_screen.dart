import 'package:flutter/material.dart';

class LokasiScreen extends StatelessWidget {
  const LokasiScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Lokasi Page'));
  }
}
