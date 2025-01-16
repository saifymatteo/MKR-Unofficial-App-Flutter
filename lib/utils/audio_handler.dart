import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'audio_metadata.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final audioPlayer = AudioPlayer();
  final audioMetadata = AudioMetadata();

  late Timer timer;

  final _radioURL = 'https://usa10.fastcast4u.com/voicespl';

  Future<void> initialisePlayer() async {
    // Broadcast that we're loading, and what controls are available.
    playbackState.add(
      playbackState.value.copyWith(
        controls: [MediaControl.play],
        processingState: AudioProcessingState.loading,
      ),
    );
    periodicUpdateMetadata();

    try {
      // Connect to the URL
      await audioPlayer.setUrl(_radioURL);

      // Broadcast that we've finished loading
      playbackState.add(playbackState.value.copyWith(
        processingState: AudioProcessingState.ready,
      ));
    } on PlayerException catch (e) {
      debugPrint('PlayerException: $e');
    } on PlayerInterruptedException catch (e) {
      debugPrint('PlayerInterruptedException: $e');
    }

    audioPlayer.playbackEventStream.listen((event) {}, onError: (
      Object e,
      StackTrace st,
    ) {
      if (e is PlatformException) {
        debugPrint('Error code: ${e.code}');
        debugPrint('Error message: ${e.message}');
        debugPrint('AudioSource index: ${e.details?["index"]}');
      } else {
        debugPrint('An error occurred: $e');
      }
    });
  }

  void periodicUpdateMetadata() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await audioMetadata.getURLMetadata();

      mediaItem.add(audioMetadata.currentMediaItem);

      // Jump to the latest stream position every 10 seconds
      if (!playbackState.value.playing) {
        await audioPlayer.seek(null);
      }
    });
  }

  void destroyTimer() {
    timer.cancel();
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
