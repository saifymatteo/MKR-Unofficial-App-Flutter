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

  String titleSong = '';
  String artistSong = '';
  String artURI = '';

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
    await audioMetadata.getURLMetadata();
    debugPrint('');
    titleSong = audioMetadata.titleSong;
    debugPrint('titleSong: $titleSong');
    artistSong = audioMetadata.artistSong;
    debugPrint('artistSong: $artistSong');
    artURI = audioMetadata.artURI;
    updateNewMediaItem();
  }

  void updateNewMediaItem() {
    item = MediaItem(
      id: radioURL,
      album: 'MKR Stream',
      title: titleSong,
      artist: artistSong,
      artUri: Uri.parse(artURI),
    );
    mediaItem.add(item);
  }

  void periodicUpdateMetadata() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      getMetadata();

      // Jump to the latest stream position every 10 seconds
      if (!playbackState.value.playing) {
        await audioPlayer.seek(null);
      }
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
        artUri: Uri.parse(artURI),
      );
      return mediaItem;
    } catch (e) {
      debugPrint('Error: $e');
      return MediaItem(
        id: radioURL,
        album: 'MKR Stream',
        title: 'Various Song',
        artist: 'Various Artist',
        artUri: Uri.parse(artURI),
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
