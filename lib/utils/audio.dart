import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class Audio {
  late AudioPlayer audioPlayer;
  String url = 'https://usa10.fastcast4u.com/voicespl';

  // Method to start and set the audio
  void start() {
    try {
      audioPlayer = AudioPlayer();
      AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: '1',
          album: 'Station Indie Terbaik',
          title: 'Lagu Lokal',
          artUri: Uri.parse(
              'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
        ),
      );
      audioPlayer.audioSource;
    } on PlayerException catch (e) {
      debugPrint('Error code: ${e.code}');
      debugPrint('Error message: ${e.message}');
    } on PlayerInterruptedException catch (e) {
      debugPrint('Connection aborted: ${e.message}');
    } catch (e) {
      debugPrint('$e');
    }
  }

  // Play the audio
  void play() {
    audioPlayer.play();
  }

  // Pause the audio
  void pause() async {
    await audioPlayer.pause();
  }

  // To free the memory
  void destroy() {
    audioPlayer.dispose();
  }
}
