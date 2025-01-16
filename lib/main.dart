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

late AudioHandler _audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final playerHandler = AudioPlayerHandler();
  await playerHandler.initialisePlayer();

  _audioHandler = await AudioService.init(
    builder: () => playerHandler,
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

  // For Web
  if (kIsWeb) {
    // TODO:
  }
  // For Desktop Platform
  else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setMinWindowSize(const Size(360, 640));
    await DesktopWindow.setMaxWindowSize(const Size(720, 1280));
  }
  // For Mobile Platform
  else if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  final savedTheme = await AdaptiveTheme.getThemeMode();

  runApp(
    MyApp(savedTheme: savedTheme),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.savedTheme});

  final AdaptiveThemeMode? savedTheme;

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
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      ),
      initial: savedTheme ?? AdaptiveThemeMode.light,
      builder: (lightTheme, darkTheme) => MaterialApp(
        title: 'MyKampus Radio Unofficial',
        theme: lightTheme,
        darkTheme: darkTheme,
        routes: {
          Screen.home: (context) => MainScreen(
                audioHandler: _audioHandler,
                title: 'MyKampus Radio',
                route: Screen.home,
              ),
          Screen.settingsScreen: (context) => MainScreen(
                audioHandler: _audioHandler,
                title: 'Settings',
                route: Screen.settingsScreen,
              ),
        },
      ),
    );
  }
}

class Screen {
  static const home = '/';
  static const lamanWebScreen = '/laman-web';
  static const showClipScreen = '/show-clip';
  static const myKampusTvScreen = '/my-kampus-tv';
  static const socmedFacebookScreen = '/social-facebook';
  static const socmedTwitterScreen = '/social-twitter';
  static const socmedInstagramScreen = '/social-instagram';
  static const socmedTikTokScreen = '/social-tiktok';
  static const telephoneScreen = '/social-telephone';
  static const whatsappScreen = '/contact-whatsapp';
  static const lokasiScreen = '/location';
  static const settingsScreen = '/setting';
}
