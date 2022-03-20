import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'audio_metadata.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final audioPlayer = AudioPlayer();
  final audioMetadata = AudioMetadata();
  late Timer timer;

  String radioURL = 'https://usa10.fastcast4u.com/voicespl';

  String fileName = '';
  String titleSong = '';
  String artistSong = '';

  late MediaItem item;

  AudioPlayerHandler() {
    // Broadcast that we're loading, and what controls are available.
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play],
      processingState: AudioProcessingState.loading,
    ));
    item = setMediaItem();
    mediaItem.add(item);
    periodicUpdateMetadata();
    // Connect to the URL
    audioPlayer.setUrl(radioURL).then((_) {
      // Broadcast that we've finished loading
      playbackState.add(playbackState.value.copyWith(
        processingState: AudioProcessingState.ready,
      ));
    });
  }

  void getMetadata() async {
    // await audioMetadata.getURLMetadataFirebase(); // ! Firebase Test
    await audioMetadata.getURLMetadata();
    debugPrint('');
    fileName = audioMetadata.fileName;
    debugPrint('fileName: $fileName');
    titleSong = audioMetadata.titleSong;
    debugPrint('titleSong: $titleSong');
    artistSong = audioMetadata.artistSong;
    debugPrint('artistSong: $artistSong');
    updateNewMediaItem();
  }

  void updateNewMediaItem() {
    item = MediaItem(
      id: radioURL,
      album: 'MKR Stream',
      title: titleSong,
      artist: artistSong,
      artUri: Uri.parse(
          'https://mykampusradio.com/wp-content/uploads/2022/02/MKR-logo-small-blue-e1645612000865.png'),
    );
    mediaItem.add(item);
  }

  void periodicUpdateMetadata() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getMetadata();
    });
  }

  void destroyTimer() {
    timer.cancel();
  }

  MediaItem setMediaItem() {
    try {
      MediaItem mediaItem = MediaItem(
        id: radioURL,
        album: 'MKR Stream',
        title: titleSong,
        artist: artistSong,
        artUri: Uri.parse(
            'https://mykampusradio.com/wp-content/uploads/2022/02/MKR-logo-small-blue-e1645612000865.png'),
      );
      return mediaItem;
    } catch (e) {
      debugPrint('Error: $e');
      return MediaItem(
        id: radioURL,
        album: 'MKR Stream',
        title: 'Various Song',
        artist: 'Various Artist',
        artUri: Uri.parse(
            'https://mykampusradio.com/wp-content/uploads/2022/02/MKR-logo-small-blue-e1645612000865.png'),
      );
    }
  }

  // Play the audio
  @override
  Future<void> play() async {
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [MediaControl.pause],
    ));
    await audioPlayer.play();
    // To jump to the latest stream position
    await audioPlayer.seek(null); 
  }

  // Pause the audio
  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));
    await audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    playbackState.add(playbackState.value.copyWith(
      processingState: AudioProcessingState.idle,
    ));
    await audioPlayer.stop();
  }

  @override
  Future<void> onTaskRemoved() async {
    if (!playbackState.value.playing) {
      await audioPlayer.stop();
    }
  }
}
