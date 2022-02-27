import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mkr_flutter/components/drawer.dart';
import 'package:mkr_flutter/utils/constant.dart';
import 'package:mkr_flutter/utils/screen_name.dart';

import 'package:mkr_flutter/screens/laman_web_screen.dart';
import 'package:mkr_flutter/screens/listen_now_screen.dart';
import 'package:mkr_flutter/screens/mykampus_tv_screen.dart';
import 'package:mkr_flutter/screens/settings_screen.dart';
import 'package:mkr_flutter/screens/show_clip_screen.dart';
import 'package:mkr_flutter/screens/socmed_facebook_screen.dart';
import 'package:mkr_flutter/screens/socmed_instagram_screen.dart';
import 'package:mkr_flutter/screens/socmed_tiktok_screen.dart';
import 'package:mkr_flutter/screens/socmed_twitter_screen.dart';
import 'package:mkr_flutter/screens/error_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.audioHandler,
    required this.title,
    required this.route,
    required this.navigatorKey,
  }) : super(key: key);

  final AudioHandler audioHandler;
  final String title;
  final String route;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StreamBuilder<PlaybackState>(
          stream: widget.audioHandler.playbackState,
          builder: (context, snapshot) {
            final playing = snapshot.data?.playing ?? false;
            String isPlaying = playing ? 'Playing' : 'Pause';
            final processingState =
                snapshot.data?.processingState ?? AudioProcessingState.idle;
            return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: (processingState == AudioProcessingState.loading)
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: kMKRColorMain, size: 60)
                    : FloatingActionButton.extended(
                        onPressed: () {
                          if (playing) {
                            widget.audioHandler.pause();
                            debugPrint('Audio is pause');
                          } else {
                            widget.audioHandler.play();
                            debugPrint('Audio is playing');
                          }
                        },
                        backgroundColor: kMKRColorMain,
                        label: Text(isPlaying),
                        icon: playing
                            ? const Icon(Icons.pause_rounded)
                            : const Icon(Icons.play_arrow_rounded),
                      ));
          }),
      drawer: DrawerNav(
        navigatorKey: widget.navigatorKey,
      ),
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (widget.route) {
            case Screen.home:
              builder = (BuildContext context) => listenNowScreen();
              break;
            case Screen.lamanWebScreen:
              builder = (BuildContext context) => lamanWebScreen();
              break;
            case Screen.showClipScreen:
              builder = (BuildContext context) => showClipScreen();
              break;
            case Screen.myKampusTvScreen:
              builder = (BuildContext context) => myKampusTvScreen();
              break;
            case Screen.socmedFacebookScreen:
              builder = (BuildContext context) => socmedFacebookScreen();
              break;
            case Screen.socmedTwitterScreen:
              builder = (BuildContext context) => socmedTwitterScreen();
              break;
            case Screen.socmedInstagramScreen:
              builder = (BuildContext context) => socmedInstagramScreen();
              break;
            case Screen.socmedTikTokScreen:
              builder = (BuildContext context) => socmedTikTokScreen();
              break;
            case Screen.settingsScreen:
              builder = (BuildContext context) => settingsScreen();
              break;
            default:
              builder = (BuildContext context) => const ErrorScreen();
          }
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }

  Widget listenNowScreen() => ListenNowScreen(
      audioHandler: widget.audioHandler, navigatorKey: widget.navigatorKey);

  Widget lamanWebScreen() => LamanWebScreen(navigatorKey: widget.navigatorKey);

  Widget showClipScreen() => ShowClipScreen(navigatorKey: widget.navigatorKey);

  Widget myKampusTvScreen() =>
      MyKampusTvScreen(navigatorKey: widget.navigatorKey);

  Widget socmedFacebookScreen() =>
      SocmedFacebookScreen(navigatorKey: widget.navigatorKey);

  Widget socmedTwitterScreen() =>
      SocmedTwitterScreen(navigatorKey: widget.navigatorKey);

  Widget socmedInstagramScreen() =>
      SocmedInstagramScreen(navigatorKey: widget.navigatorKey);

  Widget socmedTikTokScreen() =>
      SocmedTikTokScreen(navigatorKey: widget.navigatorKey);

  Widget settingsScreen() => SettingScreen(navigatorKey: widget.navigatorKey);
}
