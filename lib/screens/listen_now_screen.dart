import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mkr_flutter/utils/constant.dart';

class ListenNowScreen extends StatelessWidget {
  const ListenNowScreen({
    super.key,
    required this.audioHandler,
  });

  final AudioHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 80, right: 80),
          child: Image(
            image: AssetImage('images/MKR-logo-small-blue.png'),
          ),
        ),
        Column(
          children: [
            StreamBuilder<MediaItem?>(
              stream: audioHandler.mediaItem,
              builder: (context, snapshot) {
                final artistSong = snapshot.data?.artist ?? 'Various Artist';
                final titleSong = snapshot.data?.title ?? 'Various Song';
                if (kIsWeb) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: (artistSong == '')
                        ? LoadingAnimationWidget.waveDots(
                            color: kMKRColorMain, size: 40)
                        : ValueListenableBuilder(
                            valueListenable:
                                AdaptiveTheme.of(context).modeChangeNotifier,
                            builder: (_, mode, child) {
                              return Column(
                                children: [
                                  Text(
                                    titleSong,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: (mode == AdaptiveThemeMode.dark)
                                          ? kMKRColorMainLight
                                          : kMKRColorMain,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    artistSong,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: (mode == AdaptiveThemeMode.dark)
                                          ? kMKRColorMain
                                          : kMKRColorMainDark,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  );
                }
              },
            ),
            const SizedBox(height: 5),
            StreamBuilder<PlaybackState>(
              stream: audioHandler.playbackState,
              builder: (context, snapshot) {
                final processingState =
                    snapshot.data?.processingState ?? AudioProcessingState.idle;
                final statusAudio = switch (processingState) {
                  AudioProcessingState.loading => 'Audio: Loading',
                  AudioProcessingState.ready => 'Audio: Ready',
                  AudioProcessingState.idle => 'Audio: Idle',
                  AudioProcessingState.buffering => 'Audio: Buffering',
                  _ => 'Audio: Error'
                };
                return Text(
                  statusAudio,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
