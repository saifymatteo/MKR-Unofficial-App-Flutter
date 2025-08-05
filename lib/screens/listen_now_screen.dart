import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mkr_flutter/utils/constant.dart';

class ListenNowScreen extends StatelessWidget {
  const ListenNowScreen({super.key, required this.audioHandler});

  final AudioHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 80, right: 80),
            child: Image(image: AssetImage('images/MKR-logo-long-blue.png')),
          ),
          StreamBuilder<MediaItem?>(
            stream: audioHandler.mediaItem,
            builder: (context, snapshot) {
              final artistSong = snapshot.data?.artist ?? 'Various Artist';
              final titleSong = snapshot.data?.title ?? 'Various Song';
              final artUri = snapshot.data?.artUri;

              return Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: (!snapshot.hasData)
                    ? LoadingAnimationWidget.waveDots(
                        color: kMKRColorMain,
                        size: 40,
                      )
                    : ValueListenableBuilder(
                        valueListenable: AdaptiveTheme.of(
                          context,
                        ).modeChangeNotifier,
                        builder: (_, mode, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (artUri != null) ...[
                                Image.network(
                                  artUri.toString(),
                                  width: 80,
                                  height: 80,
                                  errorBuilder: (_, _, _) => const Image(
                                    image: AssetImage(
                                      'images/MKR-logo-small-blue.png',
                                    ),
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      titleSong,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: (mode == AdaptiveThemeMode.dark)
                                            ? kMKRColorMainLight
                                            : kMKRColorMain,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      artistSong,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: (mode == AdaptiveThemeMode.dark)
                                            ? kMKRColorMain
                                            : kMKRColorMainDark,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
