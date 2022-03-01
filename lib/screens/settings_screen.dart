import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:mkr_flutter/utils/constant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                bool isDark;
                if (mode == AdaptiveThemeMode.dark) {
                  isDark = true;
                } else {
                  isDark = false;
                }
                return ListTile(
                  title: const Text('Dark mode'),
                  trailing: Switch(
                    onChanged: (value) {
                      if (mode == AdaptiveThemeMode.dark) {
                        isDark = true;
                        AdaptiveTheme.of(context).setLight();
                      } else {
                        isDark = false;
                        AdaptiveTheme.of(context).setDark();
                      }
                      setState(() {
                        isDark = value;
                      });
                    },
                    value: isDark,
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
