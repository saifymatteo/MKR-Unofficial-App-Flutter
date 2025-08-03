import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mkr_flutter/components/drawer.dart';
import 'package:mkr_flutter/utils/constant.dart';
import 'package:mkr_flutter/main.dart';

import 'package:mkr_flutter/screens/listen_now_screen.dart';
import 'package:mkr_flutter/screens/settings_screen.dart';
import 'package:mkr_flutter/screens/error_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.audioHandler,
    required this.title,
    required this.route,
  });

  final AudioHandler audioHandler;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StreamBuilder<PlaybackState>(
        stream: audioHandler.playbackState,
        builder: (context, snapshot) {
          final playing = snapshot.data?.playing ?? false;
          String isPlaying = playing ? 'Pause' : 'Play';
          final processingState =
              snapshot.data?.processingState ?? AudioProcessingState.idle;

          final statusAudio = switch (processingState) {
            AudioProcessingState.loading => 'Audio: Loading',
            AudioProcessingState.ready => 'Audio: Ready',
            AudioProcessingState.idle => 'Audio: Idle',
            AudioProcessingState.buffering => 'Audio: Buffering',
            _ => 'Audio: Error'
          };

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (processingState == AudioProcessingState.loading)
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: kMKRColorMain,
                    size: 60,
                  )
                else
                  FloatingActionButton.extended(
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
                const SizedBox(height: 10),
                Text(
                  statusAudio,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: DrawerNav(),
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: switch (route) {
              Screen.home => (context) =>
                  ListenNowScreen(audioHandler: audioHandler),
              Screen.settingsScreen => (context) => SettingScreen(),
              _ => (context) => const ErrorScreen()
            },
          );
        },
      ),
    );
  }
}
