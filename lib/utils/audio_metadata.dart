import 'package:audio_service/audio_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AudioMetadata {
  final _metaURL =
      'https://usa10.fastcast4u.com:3840/api/v2/history/?limit=3&offset=0&server=1';

  MediaItem? _currentMediaItem;
  MediaItem? get currentMediaItem => _currentMediaItem;

  Future<void> getURLMetadata() async {
    try {
      final response = await http.get(Uri.parse(_metaURL));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body)['results'];

        if (body is! List<dynamic>) {
          return;
        }

        final firstContent = body[0];

        if (firstContent case {
          'id': final int? id,
          'album': final String? album,
          'author': final String? author,
          'title': final String? title,
          'img_url': final String? imageUrl,
        }) {
          debugPrint('Album: $album');
          debugPrint('Artist: $author');
          debugPrint('Title: $title');
          debugPrint('ArtURI: $imageUrl');

          _currentMediaItem = MediaItem(
            id: id.toString(),
            title: title ?? 'Various Song',
            album: album,
            artist: author,
            artUri: Uri.tryParse(imageUrl ?? ''),
            isLive: true,
          );
        }
      } else {
        debugPrint('${response.statusCode}');
        debugPrint('${response.reasonPhrase}');
      }
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrint('Stacktrace: $s');

      _currentMediaItem = MediaItem(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: 'Various Song',
        isLive: true,
      );
    }
  }
}
