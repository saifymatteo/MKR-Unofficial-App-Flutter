import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/audio_handler.dart';
import 'dart:async';
import 'screens/main_screen.dart';
import 'utils/screen_name.dart';

late AudioHandler audioHandler;
Future<void> main() async {
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.saifymatteo.mkr_flutter.channel.audio',
      androidNotificationChannelName: 'Radio Playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidNotificationChannelDescription: 'Lagu indie lokal hangat',
      androidNotificationClickStartsActivity: true,
      androidResumeOnClick: true,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode,));
}

class MyApp extends StatelessWidget {
  MyApp({this.savedThemeMode, Key? key}) : super(key: key);
  final mainNavigatorKey = GlobalKey<NavigatorState>();
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primaryColor: kMKRColorMain,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kMKRColorMain,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (lightTheme, darkTheme) => MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        navigatorKey: mainNavigatorKey,
        routes: {
          Screen.home: (context) => MainScreen(
                audioHandler: audioHandler,
                title: 'MyKampus Radio',
                route: Screen.home,
                navigatorKey: mainNavigatorKey,
              ),
          Screen.settingsScreen: (context) => MainScreen(
                audioHandler: audioHandler,
                title: 'Settings',
                route: Screen.settingsScreen,
                navigatorKey: mainNavigatorKey,
              ),
        },
      ),
    );
  }
}
