import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/audio.dart';
import 'components/drawer_left.dart';
import 'dart:async';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.saifymatteo.mkr_flutter.channel.audio',
    androidNotificationChannelName: 'Radio Playback',
    androidNotificationOngoing: true,
    androidStopForegroundOnPause: true,
    androidNotificationChannelDescription: 'Lagu indie lokal hangat',
    androidNotificationClickStartsActivity: true,
    androidResumeOnClick: true,
    // androidNotificationIcon: , //TODO: to add custom icon (monochrome) to notification bar
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String statusAudio = '';
  String statusPlaying = '';
  Audio audio = Audio();
  Timer?
      timerStatusAudio; // Initialize timer to display audio player loading status
  Timer? timerFileName;

  void callURLMetada() {
    audio.getURLMetadata();
  }

  @override
  void initState() {
    audio.setStreamURL();
    audio.getURLMetadata();
    statusAudio = audio.getPlayingState();
    // periodically set State every 0.5 seconds
    timerStatusAudio = Timer.periodic(const Duration(milliseconds: 500),
        (timer) => setState(() => statusAudio = audio.getPlayingState()));
    timerFileName = Timer.periodic(const Duration(seconds: 30),
        (timer) => setState(() => callURLMetada()));
    super.initState();
  }

  @override
  void dispose() {
    audio.destroy();
    timerStatusAudio?.cancel();
    timerFileName?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = audio.playingStatus;
    String fileName = audio.fileName;
    String artistSong = audio.artistSong;
    String titleSong = audio.titleSong;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kMKRColorMain,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('MyKampus Radio'),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: FloatingActionButton.extended(
              onPressed: () {
                if (isPlaying) {
                  audio.pause();
                  statusPlaying = 'Pause';
                  debugPrint('Audio is pause');
                } else {
                  audio.play();
                  statusPlaying = 'Playing';
                  debugPrint('Audio is playing');
                }
                setState(() {
                  isPlaying = !audio.playingStatus;
                });
              },
              backgroundColor: kMKRColorMain,
              label: Text(statusPlaying),
              icon: isPlaying
                  ? const Icon(Icons.pause_rounded)
                  : const Icon(Icons.play_arrow_rounded),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(80),
                child: Image(
                  image: AssetImage('images/MKR-logo-small-blue.png'),
                ),
              ),
              Column(
                children: [
                  Text(
                    statusAudio,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Text(
                    'Filename: $fileName',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Text(
                    'Artist: $artistSong',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Text(
                    'Title: $titleSong',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ],
          ),
          drawer: const DrawerLeft(),
        ),
      ),
    );
  }
}
