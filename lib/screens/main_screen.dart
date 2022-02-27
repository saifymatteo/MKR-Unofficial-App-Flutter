import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mkr_flutter/screens/listen_now_screen.dart';
import 'package:mkr_flutter/components/drawer.dart';
import 'package:mkr_flutter/utils/constant.dart';

class MainScreen extends StatelessWidget {
  final AudioHandler audioHandler;

  const MainScreen(this.audioHandler);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyKampus Radio'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StreamBuilder<PlaybackState>(
          stream: audioHandler.playbackState,
          builder: (context, snapshot) {
            final playing = snapshot.data?.playing ?? false;
            String isPlaying = playing ? 'Playing' : 'Pause';
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (playing) {
                    audioHandler.pause();
                    debugPrint('Audio is pause');
                  } else {
                    audioHandler.play();
                    debugPrint('Audio is playing');
                  }
                },
                backgroundColor: kMKRColorMain,
                label: Text(isPlaying),
                icon: playing
                    ? const Icon(Icons.pause_rounded)
                    : const Icon(Icons.play_arrow_rounded),
              ),
            );
          }),
      body: ListenNowScreen(audioHandler),
      drawer: const DrawerNav(),
    );
  }
}
