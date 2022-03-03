import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/audio_handler.dart';
import 'dart:async';
import 'screens/main_screen.dart';
import 'package:flutter/services.dart';
import 'package:desktop_window/desktop_window.dart';
import 'dart:io';

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
  // For Web
  if (kIsWeb) {
    runApp(MyApp(savedThemeMode: savedThemeMode));
  }
  // For Desktop Platform
  else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setMinWindowSize(const Size(540, 960));
    await DesktopWindow.setMaxWindowSize(const Size(1080, 1920));
    runApp(MyApp(savedThemeMode: savedThemeMode));
  }
  // For Mobile Platform
  else if (Platform.isAndroid || Platform.isIOS) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => runApp(MyApp(savedThemeMode: savedThemeMode)),
    );
  }
  // For Everything else
  else {
    runApp(MyApp(savedThemeMode: savedThemeMode));
  }
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
        title: 'MyKampus Radio Unofficial',
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

class Screen {
  static const home = '/';
  static const lamanWebScreen = '/lamanWebScreen';
  static const showClipScreen = '/showClipScreen';
  static const myKampusTvScreen = '/myKampusTVScreen';
  static const socmedFacebookScreen = '/socmedFacebookScreen';
  static const socmedTwitterScreen = '/socmedTwitterScreen';
  static const socmedInstagramScreen = '/socmedInstagramScreen';
  static const socmedTikTokScreen = '/socmedTikTokScreen';
  static const telephoneScreen = '/telephoneScreen';
  static const whatsappScreen = '/whatsappScreen';
  static const lokasiScreen = '/lokasiScreen';
  static const settingsScreen = '/settingsScreen';
}
