# MyKampus Radio Unofficial Apps

![Demo](https://github.com/saifymatteo/mkr_flutter/blob/master/images/github/MKR_Unofficial_App_Demo.gif)

A clone app of [MyKampus Radio apps](https://play.google.com/store/apps/details?id=info.mykampusradio.station) with the main purpose is to be on multiple platform.

<a href='https://play.google.com/store/apps/details?id=com.saifymatteo.mkr_flutter&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width=300 /></a>

## Platforms

- [Android](https://github.com/saifymatteo/MKR-Unofficial-App-Flutter/releases/latest)
- iOS
- [Windows](https://github.com/saifymatteo/MKR-Unofficial-App-Flutter/releases/latest)
- MacOS
- [Web](https://mkr.saifulmashuri.com/)

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

- Add audio notification (Windows).
- Audio stream broken suddenly. Possible [fix](https://github.com/ryanheise/just_audio/issues/4#issuecomment-643762611).

## Problem

- [Web](https://github.com/saifymatteo/mkr_flutter/blob/master/images/github/Mixed%20Content%20error.png): unable to get metadata due to CORS.
- MacOS: unable to notarize the app for now.
- iOS: unable to create IPA or publish to App Store due to cost

## Technology

- Flutter: `3.32.8`
- Dart: `3.8.1`

## Compiles

### Pre-requisite

Use PowerShell with YAML module

```PowerShell
Install-Module -Name powershell-yaml
Import-Module powershell-yaml
```

### Builds

```PowerShell
# Create folder
New-Item -Path ".\build\deploy" -ItemType Directory -Force

# Get pubspec
$content = Get-Content -Path "./pubspec.yaml" -Raw
$pubspec = ConvertFrom-Yaml -Yaml $content

# Web
flutter build web --release --wasm --verbose
Compress-Archive -Path ".\build\web\*" -DestinationPath ".\build\deploy\MKR-Unofficial-App-v$($pubspec.version)-Web.zip" -Force

# Android APK
flutter build apk --release --verbose
Copy-Item -Path ".\build\app\outputs\flutter-apk\app-release.apk" -Destination ".\build\deploy\MKR-Unofficial-App-v$($pubspec.version)-Android.apk" -Force -Recurse

# Android App Bundle
flutter build appbundle --release --verbose
Copy-Item -Path ".\build\app\outputs\bundle\release\app-release.aab" -Destination ".\build\deploy\MKR-Unofficial-App-v$($pubspec.version)-Android.aab" -Force -Recurse

# Windows
flutter build windows --release --verbose
Compress-Archive -Path ".\build\windows\x64\runner\Release\*" -DestinationPath ".\build\deploy\MKR-Unofficial-App-v$($pubspec.version)-Windows.zip" -Force
```

## Disclaimer

This project is my first Flutter project and my very first 'professional' project. Do hit me up if you have any feedback.
