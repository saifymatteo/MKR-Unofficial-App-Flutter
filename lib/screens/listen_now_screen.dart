import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mkr_flutter/utils/constant.dart';

class ListenNowScreen extends StatelessWidget {
  final AudioHandler audioHandler;
  final GlobalKey<NavigatorState> navigatorKey;

  const ListenNowScreen({
    Key? key,
    required this.audioHandler,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(80),
          child: Image(
            image: AssetImage('images/MKR-logo-small-blue.png'),
          ),
        ),
        StreamBuilder<MediaItem?>(
          stream: audioHandler.mediaItem,
          builder: (context, snapshot) {
            final artistSong = snapshot.data?.artist ?? 'Various Artist';
            final titleSong = snapshot.data?.title ?? 'Various Song';
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
                            const SizedBox(
                              height: 5,
                            ),
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
          },
        ),
        const SizedBox(
          height: 5,
        ),
        StreamBuilder<PlaybackState>(
          stream: audioHandler.playbackState,
          builder: (context, snapshot) {
            String statusAudio = '';
            final processingState =
                snapshot.data?.processingState ?? AudioProcessingState.idle;
            switch (processingState) {
              case AudioProcessingState.loading:
                statusAudio = 'Audio: Loading';
                break;
              case AudioProcessingState.ready:
                statusAudio = 'Audio: Ready';
                break;
              case AudioProcessingState.idle:
                statusAudio = 'Audio: Idle';
                break;
              case AudioProcessingState.buffering:
                statusAudio = 'Audio: Buffering';
                break;
              default:
                statusAudio = 'Audio: Error';
            }
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
    );
  }
}
