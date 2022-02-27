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
      // androidNotificationIcon: , //TODO: to add custom icon (monochrome) to notification bar
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final mainNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kMKRColorMain,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      navigatorKey: mainNavigatorKey,
      routes: {
        Screen.home: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'MyKampus Radio',
              route: Screen.home,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.lamanWebScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'Laman Web',
              route: Screen.lamanWebScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.showClipScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'Show Clip',
              route: Screen.showClipScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.myKampusTvScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'MyKampus TV',
              route: Screen.myKampusTvScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.socmedFacebookScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'Facebook',
              route: Screen.socmedFacebookScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.socmedTwitterScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'Twitter',
              route: Screen.socmedTwitterScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.socmedInstagramScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'Instagram',
              route: Screen.socmedInstagramScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.socmedTikTokScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'TikTok',
              route: Screen.socmedTikTokScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.telephoneScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'Telephone',
              route: Screen.telephoneScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.whatsappScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'WhatsApp',
              route: Screen.whatsappScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.lokasiScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'Lokasi',
              route: Screen.lokasiScreen,
              navigatorKey: mainNavigatorKey,
            ),
        Screen.settingsScreen: (context) => MainScreen(
              audioHandler: audioHandler,
              title: 'Settings',
              route: Screen.settingsScreen,
              navigatorKey: mainNavigatorKey,
            ),
      },
    );
  }
}
