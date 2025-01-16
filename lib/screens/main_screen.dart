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
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: (processingState == AudioProcessingState.loading)
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: kMKRColorMain,
                    size: 60,
                  )
                : FloatingActionButton.extended(
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
