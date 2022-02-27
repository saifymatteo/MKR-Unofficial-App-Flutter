import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class ListenNowScreen extends StatelessWidget {
  final AudioHandler audioHandler;

  const ListenNowScreen(this.audioHandler);

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
              style: TextStyle(color: Colors.grey[400]),
            );
          },
        ),
        StreamBuilder<MediaItem?>(
          stream: audioHandler.mediaItem,
          builder: (context, snapshot) {
            final artist = snapshot.data?.artist ?? 'Various Artist';
            final title = snapshot.data?.title ?? 'Various Song';
            return Column(
              children: [
                Text(
                  'Filename: $artist - $title',
                  // 'Filename',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Text(
                  'Artist: $artist',
                  // 'Artist',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Text(
                  'Song: $title',
                  // 'Title',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
