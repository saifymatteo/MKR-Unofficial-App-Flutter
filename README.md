# MyKampus Radio Unofficial Apps

![Demo](https://github.com/saifymatteo/mkr_flutter/blob/master/images/github/MKR_Unofficial_App_Demo.gif)

A clone app of [MyKampus Radio apps](https://play.google.com/store/apps/details?id=info.mykampusradio.station) with the main purpose is to be on multiple platform.

## Platforms

- Android
- iOS
- [Windows](https://github.com/saifymatteo/mkr_flutter/releases)
- MacOS
- [Web](https://mkrunofficial.netlify.app/)

## Dependecies

- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter): used for alternative Material icons.
- [google_fonts](https://pub.dev/packages/google_fonts): used for to set the apps font.
- [just_audio](https://pub.dev/packages/just_audio): used to manage audio streaming.
- [just_audio_libwinmedia](https://pub.dev/packages/just_audio_libwinmedia): required for Windows platform for ```just_audio```.
- [audio_service](https://pub.dev/packages/audio_service): used with ```just_audio``` to add background playback and as well notification on Android.
- [http](https://pub.dev/packages/http): used to get metadata.
- [loading_animation_widget](https://pub.dev/packages/loading_animation_widget): used to show animated loading while the Audio player is loading.
- [url_launcher](https://pub.dev/packages/url_launcher): used to launch url in ```Drawer``` of the app.
- [adaptive_theme](https://pub.dev/packages/adaptive_theme): used for light and dark mode for the app.
- [desktop_window](https://pub.dev/packages/desktop_window): used to set Windows minimum and maximum screen size.

## TODO

- Create server-side function to retrieve metadata (Firebase or something else)
- Windows audio notification

## Problem

- [Web](https://github.com/saifymatteo/mkr_flutter/blob/master/images/github/Mixed%20Content%20error.png): unable to get metadata due to ```Mixed Content``` issue (HTTP).
- MacOS: unable to notarize the app for now
