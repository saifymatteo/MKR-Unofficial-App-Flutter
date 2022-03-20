// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB0ai9t4GWPN9DNPIWMYD66NIwttZw5WMs',
    appId: '1:490595730844:web:32c672245f5a888848f459',
    messagingSenderId: '490595730844',
    projectId: 'mkr-unofficial-app',
    authDomain: 'mkr-unofficial-app.firebaseapp.com',
    storageBucket: 'mkr-unofficial-app.appspot.com',
    measurementId: 'G-GPWZHY9M2X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdBQB7L5Iq_vYqYQZofjveFEDTsb4Pa_M',
    appId: '1:490595730844:android:8e1365106e6bda4f48f459',
    messagingSenderId: '490595730844',
    projectId: 'mkr-unofficial-app',
    storageBucket: 'mkr-unofficial-app.appspot.com',
  );
}