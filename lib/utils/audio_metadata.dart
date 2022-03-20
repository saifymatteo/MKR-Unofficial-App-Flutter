// import 'package:cloud_functions/cloud_functions.dart';
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
        fileName = jsonDecode(response.body)["streams"][0]["songtitle"];
        artistSong = getArtistName(fileName);
        titleSong = getTitleName(fileName);
      } else {
        debugPrint('${response.statusCode}');
        debugPrint('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // ! get metadata through Firebase CLoud Function
  // Future<void> getURLMetadataFirebase() async {
  //   try {
  //     HttpsCallable callable =
  //         FirebaseFunctions.instance.httpsCallable('callMetadata');
  //     final result = await callable(metaURL);
  //     debugPrint('Firebase metadata function');
  //     debugPrint("Now Playing: $result");
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //   }
  // }

  String getArtistName(String name) {
    String placeholder = ' - ';

    if (name.contains(placeholder)) {
      int indexOfPlaceholder = name.indexOf(placeholder);
      return name.substring(0, indexOfPlaceholder);
    } else {
      return 'MyKampus Radio';
    }
  }

  String getTitleName(String name) {
    String placeholder = ' - ';

    if (name.contains(placeholder)) {
      int indexOfPlaceholder = name.indexOf(placeholder);
      return name.substring((indexOfPlaceholder + 3), (name.length));
    } else {
      return name;
    }
  }
}
