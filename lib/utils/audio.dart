import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:http/http.dart';

class Audio {
  AudioPlayer audioPlayer = AudioPlayer();
  String radioURL = 'https://usa10.fastcast4u.com/voicespl';
  String metaURL = 'http://usa10.fastcast4u.com:4800/statistics?json=1';

  String fileName = '';
  String artistSong = '';
  String titleSong = '';

  // Set the stream URL
  void setStreamURL() async {
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(radioURL),
          tag: MediaItem(
            id: radioURL,
            album: 'MKR Radio Album',
            title: 'Various Songs',
            artist: 'Various Artist',
            artUri: Uri.parse(
                'https://mykampusradio.com/wp-content/uploads/2022/02/MKR-logo-small-blue-e1645612000865.png'),
          ),
        ),
      );
    } catch (e) {
      debugPrint('$e');
    }
    debugPrint('Playing from: $radioURL');
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

  // Return [bool] to get Player playing status
  bool get playingStatus => audioPlayer.playing;

  // Return [String] status of the Player
  String getPlayingState() {
    String statePlaying = '';
    switch (audioPlayer.processingState) {
      case ProcessingState.loading:
        statePlaying = 'Audio: Loading';
        break;
      case ProcessingState.ready:
        statePlaying = 'Audio: Ready';
        break;
      case ProcessingState.idle:
        statePlaying = 'Audio: Idle';
        break;
      case ProcessingState.buffering:
        statePlaying = 'Audio: Buffering';
        break;
      case ProcessingState.completed:
        statePlaying = 'Audio: Completed';
        break;
    }
    return statePlaying;
  }

  void getURLMetadata() async {
    Response response = await get(Uri.parse(metaURL));

    if (response.statusCode == 200) {
      fileName = jsonDecode(response.body)["streams"][0]["songtitle"];
      artistSong = getArtistName(fileName);
      titleSong = getTitleName(fileName);
      debugPrint('Now Playing: $fileName');
    } else {
      debugPrint('${response.statusCode}');
      debugPrint('${response.reasonPhrase}');
    }
  }

  String getArtistName(String name) {
    String placeholder = ' - ';

    if (name.contains(placeholder)) {
      int indexOfPlaceholder = name.indexOf(placeholder);
      return name.substring(0, indexOfPlaceholder);
    } else {
      return 'Various Artist';
    }
  }

  String getTitleName(String name) {
    String placeholder = ' - ';

    if (name.contains(placeholder)) {
      int indexOfPlaceholder = name.indexOf(placeholder);
      return name.substring((indexOfPlaceholder + 3), (name.length));
    } else {
      return 'Various Song';
    }
  }
}
