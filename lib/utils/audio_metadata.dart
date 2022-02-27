import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AudioMetadata {
  String metaURL = 'http://usa10.fastcast4u.com:4800/statistics?json=1';
  String fileName = '';
  String titleSong = '';
  String artistSong = '';

  Future<void> getURLMetadata() async {
    try {
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
    } catch (e) {
      debugPrint('Error: $e');
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