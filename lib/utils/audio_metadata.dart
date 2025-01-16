import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AudioMetadata {
  final _metaURL =
      'https://fastcast4u.com/player/voicespl/index.php?c=MyKampus%20Radio%20Stream';

  String _artURI = '';
  String get artURI => _artURI;

  String _titleSong = '';
  String get titleSong => _titleSong;

  String _artistSong = '';
  String get artistSong => _artistSong;

  Future<void> getURLMetadata() async {
    try {
      Response response = await get(
        Uri.parse(_metaURL),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        _artistSong = _getArtistName(body["artist"]);
        _titleSong = _getTitleName(body["title"]);
        _artURI = _getArtURI(body["image"]);

        debugPrint('Artist: $_artistSong');
        debugPrint('Title: $_titleSong');
        debugPrint('ArtURI: $_artURI');
      } else {
        debugPrint('${response.statusCode}');
        debugPrint('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  String _getArtistName(String name) {
    if (_titleSong == '') {
      _titleSong = _artistSong;
      return '';
    } else {
      return name;
    }
  }

  String _getTitleName(String name) {
    if (name == '') {
      return _artistSong;
    } else {
      return name;
    }
  }

  String _getArtURI(String name) {
    if (name.contains('favicon.ico')) {
      return 'https://mykampusradio.com/wp-content/uploads/2022/02/MKR-logo-small-blue-e1645612000865.png';
    } else {
      return 'https://fastcast4u.com/player/voicespl/$name';
    }
  }
}
