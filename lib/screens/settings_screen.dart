import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:mkr_flutter/utils/constant.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
              builder: (_, mode, child) {
                return ListTile(
                  title: const Text('Dark mode'),
                  trailing: Switch(
                    onChanged: (value) {
                      if (mode == AdaptiveThemeMode.dark) {
                        AdaptiveTheme.of(context).setLight();
                      } else {
                        AdaptiveTheme.of(context).setDark();
                      }
                    },
                    value: switch (mode) {
                      AdaptiveThemeMode.dark => true,
                      AdaptiveThemeMode.light => false,
                      _ => false,
                    },
                    activeColor: kMKRColorMain,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
