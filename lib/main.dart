import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/audio_handler.dart';
import 'dart:async';
import 'screens/listen_now_screen.dart';
import 'screens/main_screen.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    audioHandler.stop();
    super.dispose();
  }

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
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(audioHandler),
      },
      // home: MainScreen(audioHandler),
    );
  }
}
