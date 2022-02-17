import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/audio.dart';
import 'components/drawer_left.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPlaying = false;

  Audio audio = Audio();

  @override
  void initState() {
    audio.start();
    super.initState();
  }

  @override
  void dispose() {
    audio.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kMKRColorMain,
        textTheme: GoogleFonts.montserratTextTheme(
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
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (isPlaying == true) {
                    // player.pause();
                    audio.pause();
                    isPlaying = false;
                    debugPrint('Audio is pause');
                  } else {
                    // player.play();
                    audio.play();
                    isPlaying = true;
                    debugPrint('Audio is playing');
                  }
                });
              },
              backgroundColor: kMKRColorMain,
              child: isPlaying
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
              Text(
                'status',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
          drawer: const DrawerLeft(),
        ),
      ),
    );
  }
}
