import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AudioMetadata {
  String metaURL =
      'https://fastcast4u.com/player/voicespl/index.php?c=MyKampus%20Radio%20Stream';
  String artURI = '';
  String titleSong = '';
  String artistSong = '';

  Future<void> getURLMetadata() async {
    try {
      Response response = await get(
        Uri.parse(metaURL),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      if (response.statusCode == 200) {
        artistSong = getArtistName(jsonDecode(response.body)["artist"]);
        titleSong = getTitleName(jsonDecode(response.body)["title"]);
        artURI = getArtURI(jsonDecode(response.body)["image"]);
        debugPrint('Artist: $artistSong');
        debugPrint('Title: $titleSong');
        debugPrint('ArtURI: $artURI');
      } else {
        debugPrint('${response.statusCode}');
        debugPrint('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  String getArtistName(String name) {
    if (titleSong == '') {
      titleSong = artistSong;
      return '';
    } else {
      return name;
    }
  }

  String getTitleName(String name) {
    if (name == '') {
      return artistSong;
    } else {
      return name;
    }
  }

  String getArtURI(String name) {
    if (name.contains('favicon.ico')) {
      return 'https://mykampusradio.com/wp-content/uploads/2022/02/MKR-logo-small-blue-e1645612000865.png';
    } else {
      return 'https://fastcast4u.com/player/voicespl/$name';
    }
  }
}
